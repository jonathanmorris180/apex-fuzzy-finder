@isTest
public class BasicAlgorithmTest {
  @isTest
  static void itGetsTokenSetWithToStringFunction() {
    String expectedResult = 'test';
    TokenSet tokenSet = (TokenSet) new TokenSet()
      .with(new NoProcessToStringFunction());
    String result = tokenSet.getStringFunction().apply(expectedResult);
    System.assertEquals(
      expectedResult,
      result,
      'NoProcessToStringFunction should return the same string as the input'
    );
  }

  @isTest
  static void itGetsTokenSetWithDefaultToStringFunction() {
    String expectedResult = 'test';
    TokenSet tokenSet = (TokenSet) new TokenSet().noProcessor();
    String result = tokenSet.getStringFunction().apply(expectedResult);
    System.assertEquals(
      expectedResult,
      result,
      'The default ToStringFunction should return the same string as the input'
    );
  }
}
