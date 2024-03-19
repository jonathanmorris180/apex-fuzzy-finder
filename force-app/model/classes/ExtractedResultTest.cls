@isTest
public class ExtractedResultTest {
  @isTest
  static void itCreatesExtractedResultWithString() {
    Integer index = 0;
    Integer score = 0;
    String input = 'test';
    String replacement = 'replacement';
    ExtractedResult result = new ExtractedResult(input, score, index);
    result.setString(replacement);
    System.assertEquals(
      score,
      result.getScore(),
      'The score should be the same'
    );
    System.assertEquals(
      index,
      result.getIndex(),
      'The index should be the same'
    );
    System.assertEquals(
      String.format(
        '(string: {0}, score: {1}, index: {2})',
        new List<Object>{ replacement, score, index }
      ),
      result.toString(),
      'ExtractedResult was not stringified correctly'
    );
  }
}
