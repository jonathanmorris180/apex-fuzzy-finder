List<String> oppNames = new List<String>{
  // Add names
};

public class TestComparator implements Comparable {
    public String name;
    public Integer ratio;
    public TestComparator(String name, Integer ratio) {
        this.name = name;
        this.ratio = ratio;
    }
    public Integer compareTo(Object o) {
        TestComparator other = (TestComparator) o;
        if (other.ratio == this.ratio) return 0;
        return other.ratio > this.ratio ? 1 : -1;
    }
}

System.debug(
'Before: ' + System.now());
Integer highestRatio = 0;
List<TestComparator> results = new List<TestComparator>();
for (String s : oppNames) {
    Integer result = FuzzySearch.tokenSortRatio('african new hpts 22', s); // Seems to give the best results
    // highestRatio = Math.max(highestRatio, result);
    results.add(new TestComparator(s, result));
}
results.sort();
List<TestComparator> topResults = new List<TestComparator>();
for (Integer i = 0; i < 10; i++) {
    topResults.add(results[i]);
}
System.debug(
'results:  ' + topResults);
System.debug('After: ' + System.now());
