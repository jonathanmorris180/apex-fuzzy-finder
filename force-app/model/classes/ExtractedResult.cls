public class ExtractedResult implements IExtractedResult, Comparable {
  private String str;
  private Integer score;
  private Integer index;

  public ExtractedResult(String str, Integer score, Integer index) {
    this.str = str;
    this.score = score;
    this.index = index;
  }

  public Integer compareTo(Object o) {
    if (o instanceof ExtractedResult) {
      return Collections.compare(
        this.getScore(),
        ((ExtractedResult) o).getScore()
      );
    }
    return 0;
  }

  public String getString() {
    return str;
  }

  public void setString(String str) {
    this.str = str;
  }

  public Integer getScore() {
    return score;
  }

  public Integer getIndex() {
    return index;
  }

  public override String toString() {
    return '(string: ' + str + ', score: ' + score + ', index: ' + index + ')';
  }
}
