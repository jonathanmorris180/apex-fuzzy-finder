/**
 * A ratio/algorithm that can be applied
 */
global interface Applicable {
  /**
   * Apply the ratio/algorithm to the input strings
   *
   * @param s1 Input string
   * @param s2 Input string
   * @return The score of similarity
   */
  Integer apply(String s1, String s2);
}
