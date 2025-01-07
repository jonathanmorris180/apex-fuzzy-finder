global class BoundExtractedResult implements IExtractedResult, Comparable {
  private String str;
  private Integer score;
  private Integer index;

  global BoundExtractedResult(String str, Integer score, Integer index) {
    this.str = str;
    this.score = score;
    this.index = index;
  }

  global String getString() {
    return str;
  }

  global void setString(String str) {
    this.str = str;
  }

  global Integer getScore() {
    return score;
  }

  global Integer getIndex() {
    return index;
  }

  global override String toString() {
    return '(string: ' + str + ', score: ' + score + ', index: ' + index + ')';
  }

  global Integer compareTo(Object o) {
    if (o instanceof BoundExtractedResult) {
      return Collections.compare(
        this.getScore(),
        ((BoundExtractedResult) o).getScore()
      );
    }
    return 0;
  }

  global Integer compare(Integer a, Integer b) {
    return a == b ? 0 : (a < b ? -1 : 1);
  }
}
