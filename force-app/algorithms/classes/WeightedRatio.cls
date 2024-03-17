public class WeightedRatio extends BasicAlgorithm {
  public static final Double UNBASE_SCALE = .95;
  public static final Double PARTIAL_SCALE = .90;
  public static final Boolean TRY_PARTIALS = true;

  public override Integer apply(
    String s1,
    String s2,
    ToStringFunction stringProcessor
  ) {
    s1 = stringProcessor.apply(s1);
    s2 = stringProcessor.apply(s2);

    Integer len1 = s1.length();
    Integer len2 = s2.length();

    if (len1 == 0 || len2 == 0) {
      return 0;
    }

    Boolean tryPartials = TRY_PARTIALS;
    Double unbaseScale = UNBASE_SCALE;
    Double partialScale = PARTIAL_SCALE;

    Integer base = FuzzySearch.ratio(s1, s2);
    Double lenRatio = ((Double) Math.max(len1, len2)) / Math.min(len1, len2);

    // if strings are similar length don't use partials
    if (lenRatio < 1.5) {
      tryPartials = false;
    }

    // if one string is much shorter than the other
    if (lenRatio > 8) {
      partialScale = .6;
    }

    if (tryPartials) {
      Double partial = FuzzySearch.partialRatio(s1, s2) * partialScale;
      Double partialSor =
        FuzzySearch.tokenSortPartialRatio(s1, s2) *
        unbaseScale *
        partialScale;
      Double partialSet =
        FuzzySearch.tokenSetPartialRatio(s1, s2) *
        unbaseScale *
        partialScale;

      return (Integer) Math.round(
        PrimitiveUtils.max(
          new List<Double>{ base, partial, partialSor, partialSet }
        )
      );
    } else {
      Double tokenSort = FuzzySearch.tokenSortRatio(s1, s2) * unbaseScale;
      Double tokenSet = FuzzySearch.tokenSetRatio(s1, s2) * unbaseScale;

      return (Integer) Math.round(
        PrimitiveUtils.max(new List<Double>{ base, tokenSort, tokenSet })
      );
    }
  }
}
