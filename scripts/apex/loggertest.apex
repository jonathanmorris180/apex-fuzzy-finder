Logger logger1 = LoggerFactory.getLogger(Logger.class);
Logger logger2 = LoggerFactory.getLogger(LoggerFactory.class);

logger1.debug('This is a test');
logger2.debug('This is a test again');

logger1.save();

