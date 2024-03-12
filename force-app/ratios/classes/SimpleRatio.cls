public class SimpleRatio implements Ratio {

    /**
     * Computes a simple Levenshtein distance ratio between the strings
     *
     * @param s1 Input string
     * @param s2 Input string
     * @return The resulting ratio of similarity
     */
    public Integer apply(String s1, String s2) {

        return (Integer) Math.round(100 * DiffUtils.getRatio(s1, s2));

    }

    public Integer apply(String s1, String s2, ToStringFunction sp) {
        return apply(sp.apply(s1), sp.apply(s2));
    }
}
