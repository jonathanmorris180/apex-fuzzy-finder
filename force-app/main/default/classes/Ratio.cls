/**
 * Interface for the different ratios
 */
global interface Ratio extends Applicable {
  /**
   * Applies the ratio between the two strings
   *
   * @param s1 Input string
   * @param s2 Input string
   * @return Integer representing ratio of similarity
   */
  Integer apply(String s1, String s2);

  /**
   * Applies the ratio between the two strings
   *
   * @param s1 Input string
   * @param s2 Input string
   * @param sp String processor to pre-process strings before calculating the ratio
   * @return Integer representing ratio of similarity
   */
  Integer apply(String s1, String s2, ToStringFunction sp);
}
