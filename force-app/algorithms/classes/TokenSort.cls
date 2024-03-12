public class TokenSort extends RatioAlgorithm {

    public override Integer apply(String s1, String s2, Ratio ratio, ToStringFunction stringFunction) {

        String sorted1 = processAndSort(s1, stringFunction);
        String sorted2 = processAndSort(s2, stringFunction);

        return ratio.apply(sorted1, sorted2);

    }

    private static String processAndSort(String input, ToStringFunction stringProcessor) {

        input = stringProcessor.apply(input);
        String[] wordsArray = input.split('\\s+');

        List<String> words = new List<String>(wordsArray);
        String joined = Utils.sortAndJoin(words, ' ');

        return joined.trim();

    }

}
