@isTest
public class DiffUtilsTest {
  @isTest
  static void itGetsTheRatio() {
    String a = 'a';
    String b = 'a';
    System.assertEquals(
      1.0,
      DiffUtils.getRatio(a, b),
      'The ratio should be 1.0 for an exact match'
    );
  }

  @isTest
  static void itGetsThePartialMatchRatio() {
    String a = 'ab';
    String b = 'a';
    System.assertEquals(
      0.6666666666666666,
      DiffUtils.getRatio(a, b),
      'The ratio should be 0.6666666666666666, see https://stackoverflow.com/questions/14260126/how-python-levenshtein-ratio-is-computed'
    );
  }

  @isTest
  static void itGetsMatchingBlocks() {
    String a = 'similar';
    String b = 'somewhr';
    List<MatchingBlock> matchingBlocks = DiffUtils.getMatchingBlocks(a, b);
    // Matching blocks take the form [indexFirstString, indexSecondString, lengthOfMatch]
    System.debug('matchingBlocks: ' + matchingBlocks);
    MatchingBlock match1 = new MatchingBlock();
    MatchingBlock match2 = new MatchingBlock();
    MatchingBlock match3 = new MatchingBlock();
    MatchingBlock match4 = new MatchingBlock();
    match1.spos = 0;
    match1.dpos = 0;
    match1.length = 1;
    match2.spos = 2;
    match2.dpos = 2;
    match2.length = 1;
    match3.spos = 6;
    match3.dpos = 6;
    match3.length = 1;
    match4.spos = 7; // Indicates end of string
    match4.dpos = 7;
    match4.length = 0;
    List<MatchingBlock> expectedMatchingBlocks = new List<MatchingBlock>{
      match1,
      match2,
      match3,
      match4
    };
    System.assertEquals(
      expectedMatchingBlocks.size(),
      matchingBlocks.size(),
      'The matching blocks should be the same length'
    );
    for (Integer i = 0; i < matchingBlocks.size(); i++) {
      System.assertEquals(
        expectedMatchingBlocks[i].spos,
        matchingBlocks[i].spos,
        'The spos should be the same'
      );
      System.assertEquals(
        expectedMatchingBlocks[i].dpos,
        matchingBlocks[i].dpos,
        'The dpos should be the same'
      );
      System.assertEquals(
        expectedMatchingBlocks[i].length,
        matchingBlocks[i].length,
        'The length should be the same'
      );
    }
  }
}
