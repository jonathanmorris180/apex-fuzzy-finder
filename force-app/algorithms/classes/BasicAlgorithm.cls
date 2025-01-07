global abstract class BasicAlgorithm implements Applicable {
  private ToStringFunction stringFunction;

  global BasicAlgorithm() {
    this.stringFunction = new DefaultStringFunction();
  }

  global BasicAlgorithm(ToStringFunction stringFunction) {
    this.stringFunction = stringFunction;
  }

  global abstract Integer apply(
    String s1,
    String s2,
    ToStringFunction stringProcessor
  );

  global Integer apply(String s1, String s2) {
    return apply(s1, s2, this.stringFunction);
  }

  global BasicAlgorithm with(ToStringFunction stringFunction) {
    setStringFunction(stringFunction);
    return this;
  }

  global BasicAlgorithm noProcessor() {
    this.stringFunction = new NoProcessToStringFunction();
    return this;
  }

  void setStringFunction(ToStringFunction stringFunction) {
    this.stringFunction = stringFunction;
  }

  global ToStringFunction getStringFunction() {
    return stringFunction;
  }
}
