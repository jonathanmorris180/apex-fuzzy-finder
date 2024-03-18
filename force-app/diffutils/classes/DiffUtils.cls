/**
 * This is a port of all the functions needed from python-levenshtein C implementation.
 * The code was ported line by line but unfortunately it was mostly undocumented,
 * so it is mostly non readable (eg. var names)
 */
@SuppressWarnings('PMD')
public class DiffUtils {
  public static EditOp[] getEditOps(String s1, String s2) {
    return getEditOps(s1.length(), s1, s2.length(), s2);
  }

  private static EditOp[] getEditOps(
    Integer len1,
    String s1,
    Integer len2,
    String s2
  ) {
    Integer len1o, len2o;
    Integer i;

    Integer[] matrix;

    String[] c1 = s1.split('');
    String[] c2 = s2.split('');

    Integer p1 = 0;
    Integer p2 = 0;

    len1o = 0;

    while (len1 > 0 && len2 > 0 && c1[p1] == c2[p2]) {
      len1--;
      len2--;

      p1++;
      p2++;

      len1o++;
    }

    len2o = len1o;

    /* strip common suffix */
    while (len1 > 0 && len2 > 0 && c1[p1 + len1 - 1] == c2[p2 + len2 - 1]) {
      len1--;
      len2--;
    }

    len1++;
    len2++;

    matrix = new List<Integer>(len2 * len1);

    for (i = 0; i < len2; i++)
      matrix[i] = i;
    for (i = 1; i < len1; i++)
      matrix[len2 * i] = i;

    for (i = 1; i < len1; i++) {
      Integer ptrPrev = (i - 1) * len2;
      Integer ptrC = i * len2;
      Integer ptrEnd = ptrC + len2 - 1;

      String char1 = c1[p1 + i - 1];
      Integer ptrChar2 = p2;

      Integer x = i;

      ptrC++;

      while (ptrC <= ptrEnd) {
        Integer c3 = matrix[ptrPrev++] + (char1 != c2[ptrChar2++] ? 1 : 0);
        x++;

        if (x > c3) {
          x = c3;
        }

        c3 = matrix[ptrPrev] + 1;

        if (x > c3) {
          x = c3;
        }

        matrix[ptrC++] = x;
      }
    }

    return editOpsFromCostMatrix(
      len1,
      c1,
      p1,
      len1o,
      len2,
      c2,
      p2,
      len2o,
      matrix
    );
  }

  private static EditOp[] editOpsFromCostMatrix(
    Integer len1,
    String[] c1,
    Integer p1,
    Integer o1,
    Integer len2,
    String[] c2,
    Integer p2,
    Integer o2,
    Integer[] matrix
  ) {
    Integer i, j, pos;

    Integer ptr;

    EditOp[] ops;

    Integer dir = 0;

    pos = matrix[len1 * len2 - 1];

    ops = new List<EditOp>(pos);

    i = len1 - 1;
    j = len2 - 1;

    ptr = len1 * len2 - 1;

    while (i > 0 || j > 0) {
      if (
        i != 0 &&
        j != 0 &&
        matrix[ptr] == matrix[ptr - len2 - 1] &&
        c1[p1 + i - 1] == c2[p2 + j - 1]
      ) {
        i--;
        j--;
        ptr -= len2 + 1;
        dir = 0;

        continue;
      }

      if (dir < 0 && j != 0 && matrix[ptr] == matrix[ptr - 1] + 1) {
        EditOp eop = new EditOp();

        pos--;
        ops[pos] = eop;
        eop.type = EditType.INS;
        eop.spos = i + o1;
        eop.dpos = --j + o2;
        ptr--;

        continue;
      }

      if (dir > 0 && i != 0 && matrix[ptr] == matrix[ptr - len2] + 1) {
        EditOp eop = new EditOp();

        pos--;
        ops[pos] = eop;
        eop.type = EditType.DEL;
        eop.spos = --i + o1;
        eop.dpos = j + o2;
        ptr -= len2;

        continue;
      }

      if (i != 0 && j != 0 && matrix[ptr] == matrix[ptr - len2 - 1] + 1) {
        pos--;

        EditOp eop = new EditOp();
        ops[pos] = eop;

        eop.type = EditType.REPLACE;
        eop.spos = --i + o1;
        eop.dpos = --j + o2;

        ptr -= len2 + 1;
        dir = 0;
        continue;
      }

      if (dir == 0 && j != 0 && matrix[ptr] == matrix[ptr - 1] + 1) {
        pos--;
        EditOp eop = new EditOp();
        ops[pos] = eop;
        eop.type = EditType.INS;
        eop.spos = i + o1;
        eop.dpos = --j + o2;
        ptr--;
        dir = -1;

        continue;
      }

      if (dir == 0 && i != 0 && matrix[ptr] == matrix[ptr - len2] + 1) {
        pos--;
        EditOp eop = new EditOp();
        ops[pos] = eop;

        eop.type = EditType.DEL;
        eop.spos = --i + o1;
        eop.dpos = j + o2;
        ptr -= len2;
        dir = 1;
        continue;
      }

      Assert.isTrue(false, 'No statements evaluated to true');
    }

    return ops;
  }

  public static MatchingBlock[] getMatchingBlocks(String s1, String s2) {
    return getMatchingBlocks(s1.length(), s2.length(), getEditOps(s1, s2));
  }

  public static MatchingBlock[] getMatchingBlocks(
    Integer len1,
    Integer len2,
    OpCode[] ops
  ) {
    Integer n = ops.size();

    Integer noOfMB, i;
    Integer o = 0;

    noOfMB = 0;

    for (i = n; i-- != 0; o++) {
      if (ops[o].type == EditType.KEEP) {
        noOfMB++;

        while (i != 0 && ops[o].type == EditType.KEEP) {
          i--;
          o++;
        }

        if (i == 0)
          break;
      }
    }

    MatchingBlock[] matchingBlocks = new List<MatchingBlock>(noOfMB + 1);
    Integer mb = 0;
    o = 0;
    matchingBlocks[mb] = new MatchingBlock();

    for (i = n; i != 0; i--) {
      o++; // Remove from loop condition as Apex doesn't support multiple variables

      if (ops[o].type == EditType.KEEP) {
        matchingBlocks[mb].spos = ops[o].sbeg;
        matchingBlocks[mb].dpos = ops[o].dbeg;

        while (i != 0 && ops[o].type == EditType.KEEP) {
          i--;
          o++;
        }

        if (i == 0) {
          matchingBlocks[mb].length = len1 - matchingBlocks[mb].spos;
          mb++;
          break;
        }

        matchingBlocks[mb].length = ops[o].sbeg - matchingBlocks[mb].spos;
        mb++;
        matchingBlocks[mb] = new MatchingBlock();
      }
    }

    Assert.isTrue(mb == noOfMB, 'mb != noOfMB');

    MatchingBlock finalBlock = new MatchingBlock();
    finalBlock.spos = len1;
    finalBlock.dpos = len2;
    finalBlock.length = 0;

    matchingBlocks[mb] = finalBlock;

    return matchingBlocks;
  }

  private static MatchingBlock[] getMatchingBlocks(
    Integer len1,
    Integer len2,
    EditOp[] ops
  ) {
    Integer n = ops.size();

    Integer numberOfMatchingBlocks, i, spos, dpos;

    numberOfMatchingBlocks = 0;

    Integer o = 0;

    spos = dpos = 0;

    EditType type;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0) {
        o++;
      }

      if (i == 0)
        break;

      if (spos < ops[o].spos || dpos < ops[o].dpos) {
        numberOfMatchingBlocks++;
        spos = ops[o].spos;
        dpos = ops[o].dpos;
      }

      type = ops[o].type;

      switch on type {
        when REPLACE {
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when DEL {
          do {
            spos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when INS {
          do {
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when else {
        }
      }
    }

    if (spos < len1 || dpos < len2) {
      numberOfMatchingBlocks++;
    }

    MatchingBlock[] matchingBlocks = new List<MatchingBlock>(
      numberOfMatchingBlocks + 1
    );

    o = 0;
    spos = dpos = 0;
    Integer mbIndex = 0;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0)
        o++;

      if (i == 0)
        break;

      if (spos < ops[o].spos || dpos < ops[o].dpos) {
        MatchingBlock mb = new MatchingBlock();

        mb.spos = spos;
        mb.dpos = dpos;
        mb.length = ops[o].spos - spos;
        spos = ops[o].spos;
        dpos = ops[o].dpos;

        matchingBlocks[mbIndex++] = mb;
      }

      type = ops[o].type;

      switch on type {
        when REPLACE {
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when DEL {
          do {
            spos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when INS {
          do {
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when else {
        }
      }
    }

    if (spos < len1 || dpos < len2) {
      if (len1 - spos != len2 - dpos) {
        throw new DiffUtilsException(
          'getMatchingBlocks: len1 - spos != len2 - dpos'
        );
      }

      MatchingBlock mb = new MatchingBlock();
      mb.spos = spos;
      mb.dpos = dpos;
      mb.length = len1 - spos;

      matchingBlocks[mbIndex++] = mb;
    }

    Assert.isTrue(
      numberOfMatchingBlocks == mbIndex,
      'numberOfMatchingBlocks != mbIndex'
    );

    MatchingBlock finalBlock = new MatchingBlock();
    finalBlock.spos = len1;
    finalBlock.dpos = len2;
    finalBlock.length = 0;

    matchingBlocks[mbIndex] = finalBlock;

    return matchingBlocks;
  }

  private static OpCode[] editOpsToOpCodes(
    EditOp[] ops,
    Integer len1,
    Integer len2
  ) {
    Integer n = ops.size();
    Integer noOfBlocks, i, spos, dpos;
    Integer o = 0;
    EditType type;

    noOfBlocks = 0;
    spos = dpos = 0;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0) {
        o++;
      }

      if (i == 0)
        break;

      if (spos < ops[o].spos || dpos < ops[o].dpos) {
        noOfBlocks++;
        spos = ops[o].spos;
        dpos = ops[o].dpos;
      }

      // TODO: Is this right?
      noOfBlocks++;
      type = ops[o].type;

      switch on type {
        when REPLACE {
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when DEL {
          do {
            spos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when INS {
          do {
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when else {
        }
      }
    }

    if (spos < len1 || dpos < len2)
      noOfBlocks++;

    OpCode[] opCodes = new List<OpCode>(noOfBlocks);

    o = 0;
    spos = dpos = 0;
    Integer oIndex = 0;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0)
        o++;

      if (i == 0)
        break;

      OpCode oc = new OpCode();
      opCodes[oIndex] = oc;
      oc.sbeg = spos;
      oc.dbeg = dpos;

      if (spos < ops[o].spos || dpos < ops[o].dpos) {
        oc.type = EditType.KEEP;
        spos = oc.send = ops[o].spos;
        dpos = oc.dend = ops[o].dpos;

        oIndex++;
        OpCode oc2 = new OpCode();
        opCodes[oIndex] = oc2;
        oc2.sbeg = spos;
        oc2.dbeg = dpos;
      }

      type = ops[o].type;

      switch on type {
        when REPLACE {
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when DEL {
          do {
            spos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when INS {
          do {
            dpos++;
            i--;
            o++;
          } while (
            i != 0 &&
            ops[o].type == type &&
            spos == ops[o].spos &&
            dpos == ops[o].dpos
          );
        }
        when else {
        }
      }

      opCodes[oIndex].type = type;
      opCodes[oIndex].send = spos;
      opCodes[oIndex].dend = dpos;
      oIndex++;
    }

    if (spos < len1 || dpos < len2) {
      Assert.isTrue(
        len1 - spos == len2 - dpos,
        'editOpsToOpCodes: len1 - spos != len2 - dpos'
      );
      if (opCodes[oIndex] == null)
        opCodes[oIndex] = new OpCode();
      opCodes[oIndex].type = EditType.KEEP;
      opCodes[oIndex].sbeg = spos;
      opCodes[oIndex].dbeg = dpos;
      opCodes[oIndex].send = len1;
      opCodes[oIndex].dend = len2;

      oIndex++;
    }

    Assert.isTrue(oIndex == noOfBlocks, 'oIndex != noOfBlocks');

    return opCodes;
  }

  public static Integer levEditDistance(String s1, String s2, Integer xcost) {
    Integer i;
    Integer half;

    String[] c1 = s1.split('');
    String[] c2 = s2.split('');

    Integer str1 = 0;
    Integer str2 = 0;

    Integer len1 = s1.length();
    Integer len2 = s2.length();

    /* strip common prefix */
    while (len1 > 0 && len2 > 0 && c1[str1] == c2[str2]) {
      len1--;
      len2--;
      str1++;
      str2++;
    }

    /* strip common suffix */
    while (len1 > 0 && len2 > 0 && c1[str1 + len1 - 1] == c2[str2 + len2 - 1]) {
      len1--;
      len2--;
    }

    /* catch trivial cases */
    if (len1 == 0)
      return len2;
    if (len2 == 0)
      return len1;

    /* make the inner cycle (i.e. str2) the longer one */
    if (len1 > len2) {
      Integer nx = len1;
      Integer temp = str1;

      len1 = len2;
      len2 = nx;

      str1 = str2;
      str2 = temp;

      String[] t = c2;
      c2 = c1;
      c1 = t;
    }

    /* check len1 == 1 separately */
    if (len1 == 1) {
      if (xcost != 0) {
        return len2 + 1 - 2 * memchr(c2, str2, c1[str1], len2);
      } else {
        return len2 - memchr(c2, str2, c1[str1], len2);
      }
    }

    len1++;
    len2++;
    half = len1 >> 1;

    Integer[] row = new List<Integer>(len2);
    Integer endIdx = len2 - 1;

    for (i = 0; i < len2 - (xcost != 0 ? 0 : half); i++)
      row[i] = i;

    /* go through the matrix and compute the costs.  yes, this is an extremely
     * obfuscated version, but also extremely memory-conservative and relatively
     * fast.  */

    if (xcost != 0) {
      for (i = 1; i < len1; i++) {
        Integer p = 1;

        String ch1 = c1[str1 + i - 1];
        Integer c2p = str2;

        Integer D = i;
        Integer x = i;

        while (p <= endIdx) {
          if (ch1 == c2[c2p++]) {
            x = --D;
          } else {
            x++;
          }
          D = row[p];
          D++;

          if (x > D)
            x = D;
          row[p++] = x;
        }
      }
    } else {
      /* in this case we don't have to scan two corner triangles (of size len1/2)
       * in the matrix because no best path can go throught them. note this
       * breaks when len1 == len2 == 2 so the memchr() special case above is
       * necessary */

      row[0] = len1 - half - 1;
      for (i = 1; i < len1; i++) {
        Integer p;

        String ch1 = c1[str1 + i - 1];
        Integer c2p;

        Integer D, x;

        /* skip the upper triangle */
        if (i >= len1 - half) {
          Integer offset = i - (len1 - half);
          Integer c3;

          c2p = str2 + offset;
          p = offset;
          c3 = row[p++] + ((ch1 != c2[c2p++]) ? 1 : 0);
          x = row[p];
          x++;
          D = x;
          if (x > c3) {
            x = c3;
          }
          row[p++] = x;
        } else {
          p = 1;
          c2p = str2;
          D = x = i;
        }
        /* skip the lower triangle */
        if (i <= half + 1)
          endIdx = len2 + i - half - 2;
        /* main */
        while (p <= endIdx) {
          Integer c3 = --D + ((ch1 != c2[c2p++]) ? 1 : 0);
          x++;
          if (x > c3) {
            x = c3;
          }
          D = row[p];
          D++;
          if (x > D)
            x = D;
          row[p++] = x;
        }

        /* lower triangle sentinel */
        if (i <= half) {
          Integer c3 = --D + ((ch1 != c2[c2p]) ? 1 : 0);
          x++;
          if (x > c3) {
            x = c3;
          }
          row[p] = x;
        }
      }
    }

    i = row[endIdx];

    return i;
  }

  private static Integer memchr(
    String[] haystack,
    Integer offset,
    String needle,
    Integer num
  ) {
    if (num != 0) {
      Integer p = 0;

      do {
        if (haystack[offset + p] == needle)
          return 1;

        p++;
      } while (--num != 0);
    }
    return 0;
  }

  public static Double getRatio(String s1, String s2) {
    Integer len1 = s1.length();
    Integer len2 = s2.length();
    Integer lensum = len1 + len2;

    Integer editDistance = levEditDistance(s1, s2, 1);

    if (lensum == 0)
      return 0.0;

    return (lensum - editDistance) / (Double) lensum;
  }

  public class DiffUtilsException extends Exception {
  }
}
