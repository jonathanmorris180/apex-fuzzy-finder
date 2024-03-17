List<String> oppNames = new List<String>{};
// Add names

public class TestComparable implements Comparable {
  public String name;
  public Integer ratio;
  public TestComparable(String name, Integer ratio) {
    this.name = name;
    this.ratio = ratio;
  }
  public Integer compareTo(Object o) {
    TestComparable other = (TestComparable) o;
    if (other.ratio == this.ratio)
      return 0;
    return other.ratio > this.ratio ? -1 : 1;
  }
}

System.debug('Before: ' + System.now());
Integer highestRatio = 0;
List<TestComparable> results = new List<TestComparable>();
for (String s : oppNames) {
  Integer result = FuzzySearch.tokenSortRatio('african new hpts 22', s); // Seems to give the best results
  results.add(new TestComparable(s, result));
}
results.sort();
List<TestComparable> topResults = new List<TestComparable>();
for (Integer i = 0; i < 10; i++) {
  topResults.add(results[i]);
}
System.debug('results:  ' + topResults);
System.debug('After: ' + System.now());
