@isTest
public class MatchingBlockTest {
  @isTest
  static void itCreatesEditOp() {
    MatchingBlock matchingBlock = new MatchingBlock();
    matchingBlock.dpos = 1;
    matchingBlock.spos = 2;
    matchingBlock.length = 3;
    String stringified = matchingBlock.toString();
    System.assertEquals(
      '(2,1,3)',
      stringified,
      'MatchingBlock was not stringified correctly'
    );
  }
}
