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

  @isTest
  static void itLogsTheStringsToCompare() {
    Logger localLogger = LoggerFactory.getLogger(TokenSetTest.class);
    localLogger.enable();
    Integer result = new TokenSet()
      .apply(
        'mariners vs angels',
        'los angeles angels of anaheim at seattle mariners',
        new SimpleRatio(),
        new NoProcessToStringFunction()
      );
    localLogger.save();
    Log__c loggedResult = [
      SELECT Message__c
      FROM Log__c
      LIMIT 1
    ];
    System.assert(
      loggedResult.Message__c.contains('TokenSet.class'),
      'The log should contain the class name'
    );
    System.assert(
      loggedResult.Message__c.contains('mariners vs angels'),
      'The log should contain the first string'
    );
  }
}
