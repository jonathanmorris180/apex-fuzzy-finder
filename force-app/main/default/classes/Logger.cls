global without sharing class Logger {
  private Type type;
  private static Log__c log = new Log__c(Message__c = '');
  private static Boolean enabled = false;
  private static final String FORMAT = '{0} [{1}] [{2}.class] --- {3}\n'; // {0} = timestamp, {1} = severity, {3} = type {4} = message

  private enum Severity {
    INFO,
    ERROR,
    DEBUG,
    WARN,
    FATAL
  }

  global Logger(Type type) {
    this.type = type;
    this.init();
  }

  private void init() {
    this.log(
      Severity.INFO,
      String.format(
        'Initializing logger for {0}.class',
        new List<Object>{ this.type.getName() }
      )
    );
  }

  private void log(Severity sev, String message) {
    if (!enabled) {
      return;
    }
    String severity = sev.name();
    log.Message__c += String.format(
      FORMAT,
      new List<Object>{ DateTime.now(), severity, this.type.getName(), message }
    );
  }

  global void enable() {
    enabled = true;
  }

  global void disable() {
    enabled = false;
  }

  global void info(String message) {
    this.log(Severity.INFO, message);
  }

  global void error(String message) {
    this.log(Severity.ERROR, message);
  }

  global void debug(String message) {
    this.log(Severity.DEBUG, message);
  }

  global void warn(String message) {
    this.log(Severity.WARN, message);
  }

  global void fatal(String message) {
    this.log(Severity.FATAL, message);
  }

  global void save() {
    if (!enabled) {
      return;
    }
    insert log;
  }
}
