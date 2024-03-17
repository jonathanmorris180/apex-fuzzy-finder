@isTest
public class UtilsTest {
  @isTest
  static void itTokenizesBySpaces() {
    String input = 'a b c';
    List<String> expected = new List<String>{ 'a', 'b', 'c' };
    List<String> actual = Utils.tokenize(input);
    System.assertEquals(
      expected,
      actual,
      'It should tokenize the input by splitting on spaces'
    );
  }

  @isTest
  static void itTokenizesBySpacesToSet() {
    String input = 'a b b';
    Set<String> expected = new Set<String>{ 'a', 'b' };
    Set<String> actual = Utils.tokenizeSet(input);
    System.assertEquals(
      expected,
      actual,
      'It should tokenize the input to a set by splitting on spaces'
    );
  }

  @isTest
  static void itSortsAndJoinsList() {
    List<String> input = new List<String>{ 'b', 'a', 'c' };
    String expected = 'abc';
    String actual = Utils.sortAndJoin(input, '');
    System.assertEquals(
      expected,
      actual,
      'It should sort and join the list input'
    );
  }

  @isTest
  static void itSortsAndJoinsSet() {
    Set<String> input = new Set<String>{ 'b', 'a', 'b' };
    String expected = 'ab';
    String actual = Utils.sortAndJoin(input, '');
    System.assertEquals(
      expected,
      actual,
      'It should sort and join the set input'
    );
  }

  @isTest
  static void itComparesIntegers() {
    Integer a = 1;
    Integer b = 2;
    Integer c = 1;
    System.assertEquals(
      -1,
      Utils.compare(a, b),
      'It should return -1 when a < b'
    );
    System.assertEquals(
      1,
      Utils.compare(b, a),
      'It should return 1 when a > b'
    );
    System.assertEquals(
      0,
      Utils.compare(a, c),
      'It should return 0 when a == b'
    );
  }

  @isTest
  static void itGetsTheTopComparables() {
    List<Comparable> comparables = new List<Comparable>{
      new TestComparable('A', 3),
      new TestComparable('D', 1),
      new TestComparable('C', 7),
      new TestComparable('B', 5)
    };

    // Should return the comparables with the highest values and in the correct order
    List<Comparable> expected = new List<Comparable>{
      new TestComparable('A', 3),
      new TestComparable('B', 5),
      new TestComparable('C', 7)
    };

    List<Comparable> actual = Utils.findTopKHeap(comparables, 3);
    System.assertEquals(
      expected.size(),
      actual.size(),
      'Only the top 3 comparables should be returned'
    );

    for (Integer i = 0; i < expected.size(); i++) {
      TestComparable tc = (TestComparable) expected[i];
      TestComparable actualTc = (TestComparable) actual[i];
      System.assertEquals(
        tc.name,
        actualTc.name,
        'Comparable was not returned in the correct order'
      );
    }
  }
}
