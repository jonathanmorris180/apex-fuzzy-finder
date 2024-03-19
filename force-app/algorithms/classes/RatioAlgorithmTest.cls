@isTest
public class RatioAlgorithmTest {
  private class TestRatioAlgorithm extends RatioAlgorithm {
    public TestRatioAlgorithm() {
      super();
    }

    public TestRatioAlgorithm(ToStringFunction toStringFunction) {
      super(toStringFunction);
    }

    public TestRatioAlgorithm(Ratio ratio) {
      super(ratio);
    }

    public TestRatioAlgorithm(ToStringFunction toStringFunction, Ratio ratio) {
      super(toStringFunction, ratio);
    }

    public override Integer apply(
      String s1,
      String s2,
      Ratio ratio,
      ToStringFunction toStringFunction
    ) {
      return 0;
    }
  }

  private class TestRatio implements Ratio {
    public Integer apply(String s1, String s2) {
      return 0;
    }

    public Integer apply(
      String s1,
      String s2,
      ToStringFunction toStringFunction
    ) {
      return 0;
    }
  }

  @isTest
  static void itCreatesRatioAlgorithmWithToStringFunction() {
    String expectedResult = 'test';
    TestRatioAlgorithm test = new TestRatioAlgorithm(
      new NoProcessToStringFunction()
    );
    String result = test.getStringFunction().apply(expectedResult);
    System.assertEquals(
      expectedResult,
      result,
      'The default ToStringFunction should return the same string as the input'
    );
  }

  @isTest
  static void itCreatesRatioAlgorithmWithRatio() {
    TestRatio testRatio = new TestRatio();
    TestRatioAlgorithm test = new TestRatioAlgorithm(testRatio);
    System.assertEquals(
      testRatio,
      test.getRatio(),
      'The ratio should be the same as the input'
    );
    TestRatioAlgorithm test2 = (TestRatioAlgorithm) new TestRatioAlgorithm()
      .with(testRatio);
    System.assertEquals(
      testRatio,
      test.getRatio(),
      'The ratio should be the same as the input'
    );
  }

  @isTest
  static void itCreatesRatioAlgorithmWithToStringFunctionAndRatio() {
    String expectedResult = 'test';
    TestRatio testRatio = new TestRatio();
    TestRatioAlgorithm test = new TestRatioAlgorithm(
      new NoProcessToStringFunction(),
      testRatio
    );
    String result = test.getStringFunction().apply(expectedResult);
    System.assertEquals(
      expectedResult,
      result,
      'The default ToStringFunction should return the same string as the input'
    );
    System.assertEquals(
      testRatio,
      test.getRatio(),
      'The ratio should be the same as the input'
    );
  }
}
