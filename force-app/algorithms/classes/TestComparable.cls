@isTest
public class TestComparable implements Comparable {
  public String name;
  public Integer ratio;
  public TestComparable(String name, Integer ratio) {
    this.name = name;
    this.ratio = ratio;
  }
  public Integer compareTo(Object o) {
    TestComparable other = (TestComparable) o;
    if (other.ratio == this.ratio) {
      return 0;
    }
    return other.ratio > this.ratio ? -1 : 1;
  }

  public Boolean equals(Object o) {
    TestComparable other = (TestComparable) o;
    return this.ratio == other.ratio && this.name == other.name;
  }

  public Integer hashCode() {
    return this.ratio.hashCode();
  }
}
