global class LoggerFactory {
  private static Map<Type, Logger> loggers = new Map<Type, Logger>();

  global static Logger getLogger(Type loggerType) {
    if (loggers.get(loggerType) == null) {
      loggers.put(loggerType, new Logger(loggerType));
    }
    return loggers.get(loggerType);
  }
}
