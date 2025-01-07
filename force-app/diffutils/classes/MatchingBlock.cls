global class MatchingBlock {
  public Integer spos;
  public Integer dpos;
  public Integer length;

  global override String toString() {
    return '(' + spos + ',' + dpos + ',' + length + ')';
  }
}
