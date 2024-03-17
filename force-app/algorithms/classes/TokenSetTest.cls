@isTest
public class TokenSetTest {
  @isTest
  static void itGetsTheTokenSetWithSimpleRatio() {
    Integer result = new TokenSet()
      .apply(
        'mariners vs angels',
        'los angeles angels of anaheim at seattle mariners',
        new SimpleRatio(),
        new NoProcessToStringFunction()
      );
    System.assertEquals(
      90,
      result,
      'The ratio should be 90 -- see https://chairnerd.seatgeek.com/fuzzywuzzy-fuzzy-string-matching-in-python/'
    );
  }
}
