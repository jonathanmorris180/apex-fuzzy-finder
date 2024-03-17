@isTest
public class TokenSortTest {
  @isTest
  static void itGetsTheTokenSortWithSimpleRatio() {
    Integer result = new TokenSort()
      .apply(
        'New York Mets vs Atlanta Braves',
        'Atlanta Braves vs New York Mets',
        new SimpleRatio(),
        new NoProcessToStringFunction()
      );
    System.assertEquals(
      100,
      result,
      'The token sort ratio should be 100 -- see https://chairnerd.seatgeek.com/fuzzywuzzy-fuzzy-string-matching-in-python/'
    );
  }

  @isTest
  static void itLogsTheStringsToCompare() {
    Logger localLogger = LoggerFactory.getLogger(TokenSortTest.class);
    localLogger.enable();
    Integer result = new TokenSort()
      .apply(
        'New York Mets vs Atlanta Braves',
        'Atlanta Braves vs New York Mets',
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
      loggedResult.Message__c.contains('TokenSort.class'),
      'The log should contain the class name'
    );
    System.assert(
      loggedResult.Message__c.contains('New York Mets vs Atlanta Braves'),
      'The log should contain the first string'
    );
  }
}
