/**
 * A default ToStringFunction that returns the input string;
 * used by methods that use plain strings in {@link FuzzySearch}.
 */
public class NoProcessToStringFunction implements ToStringFunction {
  public String apply(String item) {
    return item;
  }
}
