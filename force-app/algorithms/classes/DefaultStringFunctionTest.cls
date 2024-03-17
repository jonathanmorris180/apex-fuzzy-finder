@isTest
public class DefaultStringFunctionTest {
  @isTest
  static void itReplacesNonAlphaNumbericChars() {
    String str = 'Hello, World! Привет, мир!';
    String result = new DefaultStringFunction().subNonAlphaNumeric(str, ' ');
    System.assertEquals('Hello  World              ', result);
  }

  @isTest
  static void itAppliesDefaultStringFunction() {
    String str = 'Hello, World! Привет, мир!';
    String result = new DefaultStringFunction().apply(str);
    System.assertEquals('hello  world', result);
  }

  @isTest
  static void itReturnsInputIfNoMatchFound() {
    String str = 'Hello World';
    String result = new DefaultStringFunction().subNonAlphaNumeric(str, ' ');
    System.assertEquals('Hello World', result);
  }
}
