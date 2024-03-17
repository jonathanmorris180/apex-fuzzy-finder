@isTest
public class WeightedRatioTest {
  @isTest
  static void itReturnsTheExpectedWeightedRatio() {
    Integer result = new WeightedRatio()
      .apply(
        'The quick brown fox jimps ofver the small lazy dog',
        'the quick brown fox jumps over the small lazy dog',
        new NoProcessToStringFunction()
      );
    System.assertEquals(
      97,
      result,
      'The weighted ratio should be 97 -- see https://github.com/xdrop/fuzzywuzzy/blob/master/README.md'
    );
  }

  @isTest
  static void itReturnsTheExpectedWeightedRatioWithPartials() {
    Integer result = new WeightedRatio()
      .apply(
        'The quick brown fox jimps',
        'The quick brown fox jumps over the small lazy dog',
        new NoProcessToStringFunction()
      );
    System.assertEquals(86, result, 'The weighted ratio should be 86');
  }
}
