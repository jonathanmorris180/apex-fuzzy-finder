global abstract class RatioAlgorithm extends BasicAlgorithm {
  private Ratio ratio;

  global RatioAlgorithm() {
    super();
    this.ratio = new SimpleRatio();
  }

  global RatioAlgorithm(ToStringFunction stringFunction) {
    super(stringFunction);
  }

  global RatioAlgorithm(Ratio ratio) {
    super();
    this.ratio = ratio;
  }

  global RatioAlgorithm(ToStringFunction stringFunction, Ratio ratio) {
    super(stringFunction);
    this.ratio = ratio;
  }

  global abstract Integer apply(
    String s1,
    String s2,
    Ratio ratio,
    ToStringFunction stringFunction
  );

  global RatioAlgorithm with(Ratio ratio) {
    setRatio(ratio);
    return this;
  }

  global Integer apply(String s1, String s2, Ratio ratio) {
    return apply(s1, s2, ratio, getStringFunction());
  }

  global override Integer apply(
    String s1,
    String s2,
    ToStringFunction stringFunction
  ) {
    return apply(s1, s2, getRatio(), stringFunction);
  }

  global void setRatio(Ratio ratio) {
    this.ratio = ratio;
  }

  global Ratio getRatio() {
    return ratio;
  }
}
