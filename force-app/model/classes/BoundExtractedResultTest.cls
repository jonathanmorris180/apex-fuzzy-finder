@isTest
public class BoundExtractedResultTest {
  @isTest
  static void itCreatesBoundExtractedResultWithString() {
    Integer index = 0;
    Integer score = 0;
    String input = 'test';
    String replacement = 'replacement';
    BoundExtractedResult result = new BoundExtractedResult(input, score, index);
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
      'BoundExtractedResult was not stringified correctly'
    );
  }
}
