/**
 * Partial ratio of similarity
 */
global class PartialRatio implements Ratio {
  /**
   * Computes a partial ratio between the strings
   *
   * @param s1 Input string
   * @param s2 Input string
   * @return The partial ratio
   */
  global Integer apply(String s1, String s2) {
    String shorter;
    String longer;

    if (s1.length() <= s2.length()) {
      shorter = s1;
      longer = s2;
    } else {
      shorter = s2;
      longer = s1;
    }

    MatchingBlock[] matchingBlocks = DiffUtils.getMatchingBlocks(
      shorter,
      longer
    );

    List<Double> scores = new List<Double>();

    for (MatchingBlock mb : matchingBlocks) {
      Integer dist = mb.dpos - mb.spos;

      Integer longStart = dist > 0 ? dist : 0;
      Integer longEnd = longStart + shorter.length();

      if (longEnd > longer.length()) {
        longEnd = longer.length();
      }

      String longSubstr = longer.substring(longStart, longEnd);

      double ratio = DiffUtils.getRatio(shorter, longSubstr);

      if (ratio > .995) {
        return 100;
      } else {
        scores.add(ratio);
      }
    }

    return (Integer) Math.round(100 * Collections.max(scores));
  }

  global Integer apply(String s1, String s2, ToStringFunction sp) {
    return apply(sp.apply(s1), sp.apply(s2));
  }
}
