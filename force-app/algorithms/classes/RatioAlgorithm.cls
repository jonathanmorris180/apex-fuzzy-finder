public abstract class RatioAlgorithm extends BasicAlgorithm {
  private Ratio ratio;

  public RatioAlgorithm() {
    super();
    this.ratio = new SimpleRatio();
  }

  public RatioAlgorithm(ToStringFunction stringFunction) {
    super(stringFunction);
  }

  public RatioAlgorithm(Ratio ratio) {
    super();
    this.ratio = ratio;
  }

  public RatioAlgorithm(ToStringFunction stringFunction, Ratio ratio) {
    super(stringFunction);
    this.ratio = ratio;
  }

  public abstract Integer apply(
    String s1,
    String s2,
    Ratio ratio,
    ToStringFunction stringFunction
  );

  public RatioAlgorithm with(Ratio ratio) {
    setRatio(ratio);
    return this;
  }

  public Integer apply(String s1, String s2, Ratio ratio) {
    return apply(s1, s2, ratio, getStringFunction());
  }

  public override Integer apply(
    String s1,
    String s2,
    ToStringFunction stringFunction
  ) {
    return apply(s1, s2, getRatio(), stringFunction);
  }

  public void setRatio(Ratio ratio) {
    this.ratio = ratio;
  }

  public Ratio getRatio() {
    return ratio;
  }
}
