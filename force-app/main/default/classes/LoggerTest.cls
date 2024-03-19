@isTest
public class LoggerTest {
  private static final String LOG_FORMAT = '[{0}.class] --- {1}';

  @isTest
  static void itLogsAtAllLevels() {
    String debugMessage = 'Debug message';
    String infoMessage = 'Info message';
    String warnMessage = 'Warn message';
    String errorMessage = 'Error message';
    String fatalMessage = 'Fatal message';
    Logger logger = LoggerFactory.getLogger(LoggerTest.class);
    logger.enable();
    logger.debug(debugMessage);
    logger.info(infoMessage);
    logger.warn(warnMessage);
    logger.error(errorMessage);
    logger.fatal(fatalMessage);
    logger.save();
    Log__c result = [SELECT Message__c FROM Log__c LIMIT 1];
    System.assertNotEquals(null, result, 'Log should have been saved');
    for (
      String message : new List<String>{
        debugMessage,
        infoMessage,
        warnMessage,
        errorMessage,
        fatalMessage
      }
    ) {
      System.assert(
        result.Message__c.contains(
          String.format(
            LOG_FORMAT,
            new List<Object>{ LoggerTest.class, message }
          )
        ),
        String.format(
          '{0} should have been logged',
          new List<Object>{ message }
        )
      );
    }
  }
}
