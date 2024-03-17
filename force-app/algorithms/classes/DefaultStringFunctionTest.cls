@isTest
public class DefaultStringFunctionTest {
  @isTest
  static void itReplacesNonAlphanumericChars() {
    String str = 'Hello, World! Привет, мир!';
    String result = new DefaultStringFunction().subNonAlphaNumeric(str, ' ');
    System.assertEquals(
      'Hello  World              ',
      result,
      'Non-alphanumeric characters should be replaced with spaces'
    );
  }

  @isTest
  static void itAppliesDefaultStringFunction() {
    String str = 'Hello, World! Привет, мир!';
    String result = new DefaultStringFunction().apply(str);
    System.assertEquals(
      'hello  world',
      result,
      'It should convert to lowercase, remove non-alphanumeric characters, and trim the result'
    );
  }

  @isTest
  static void itReturnsInputIfNoMatchFound() {
    String str = 'Hello World';
    String result = new DefaultStringFunction().subNonAlphaNumeric(str, ' ');
    System.assertEquals(
      'Hello World',
      result,
      'It should return the input if no match found'
    );
  }
}
