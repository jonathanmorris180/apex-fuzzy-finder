/**
 * Transforms an item of type T to a String.
 *
 * @param <T> The type of the item to transform.
 */
public interface ToStringFunction {
  /**
   * Transforms the input item to a string.
   *
   * @param item The item to transform.
   * @return A string to use for comparing the item.
   */
  String apply(String item);
}
