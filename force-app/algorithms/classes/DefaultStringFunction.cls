public class DefaultStringFunction implements ToStringFunction {

    private final static String regex = '(?ui)\\W';
    private final static Pattern r = Pattern.compile(regex);


    /**
     * Substitute non alphanumeric characters.
     *
     * @param in The input string
     * @param sub The string to substitute with
     * @return The replaced string
     */
    public static String subNonAlphaNumeric(String input, String sub) {

      Matcher m = r.matcher(input);
      if (m.find()) {
        return m.replaceAll(sub);
      } else {
        return input;
      }

    }

    /**
     * Performs the default string processing on the input string
     *
     * @param in Input string
     * @return The processed string
     */
    public String apply(String input) {
      input = subNonAlphaNumeric(input, ' ');
      input = input.toLowerCase();
      input = input.trim();
      return input;
    }

}
