public class LoggerFactory {
  private static Map<Type, Logger> loggers = new Map<Type, Logger>();

  public static Logger getLogger(Type loggerType) {
    if (loggers.get(loggerType) == null) {
      loggers.put(loggerType, new Logger(loggerType));
    }
    return loggers.get(loggerType);
  }
}
