global class ExtractedResult implements IExtractedResult, Comparable {
  private String str;
  private Integer score;
  private Integer index;

  global ExtractedResult(String str, Integer score, Integer index) {
    this.str = str;
    this.score = score;
    this.index = index;
  }

  global Integer compareTo(Object o) {
    if (o instanceof ExtractedResult) {
      return Collections.compare(
        this.getScore(),
        ((ExtractedResult) o).getScore()
      );
    }
    return 0;
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
}
