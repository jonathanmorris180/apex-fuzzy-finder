/**
 * A default ToStringFunction that returns the input string;
 * used by methods that use plain strings in {@link FuzzySearch}.
 */
global class NoProcessToStringFunction implements ToStringFunction {
  global String apply(String item) {
    return item;
  }
}
