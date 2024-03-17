public class OpCode {
  public EditType type;
  public Integer sbeg;
  public Integer send;
  public Integer dbeg;
  public Integer dend;

  public override String toString() {
    return type.name() +
      '(' +
      sbeg +
      ',' +
      send +
      ',' +
      dbeg +
      ',' +
      dend +
      ')';
  }
}
