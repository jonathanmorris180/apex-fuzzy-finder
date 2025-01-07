global class EditOp {
  public EditType type;
  public Integer spos; // source block pos
  public Integer dpos; // destination block pos
  global override String toString() {
    return type.name() + '(' + spos + ',' + dpos + ')';
  }
}
