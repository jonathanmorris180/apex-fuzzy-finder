@isTest
public class CollectionsTest {
  @isTest
  static void itGetsTheMaxInteger() {
    List<Integer> numbers = new List<Integer>{ 1, 2, 3, 4, 5 };
    Integer max = Collections.max(numbers);
    System.assertEquals(5, max, 'The max should be 5');
  }

  @isTest
  static void itGetsTheMaxDouble() {
    List<Double> numbers = new List<Double>{ 1.0, 2.0, 3.0, 4.0, 5.0 };
    Double max = Collections.max(numbers);
    System.assertEquals(5.0, max, 'The max should be 5.0');
  }

  @isTest
  static void itReversesComparables() {
    List<Comparable> testComparables = new List<Comparable>{
      new TestComparable('A', 3),
      new TestComparable('B', 5),
      new TestComparable('C', 7)
    };
    List<Comparable> expected = new List<Comparable>{
      new TestComparable('C', 7),
      new TestComparable('B', 5),
      new TestComparable('A', 3)
    };

    List<Comparable> reversed = Collections.reverse(testComparables);
    System.assertEquals(
      expected,
      reversed,
      'The reversed list should be 7, 5, 3'
    );
  }

  @isTest
  static void itGetsTheMaxComparable() {
    List<Comparable> testComparables = new List<Comparable>{
      new TestComparable('A', 3),
      new TestComparable('B', 5),
      new TestComparable('C', 7)
    };
    TestComparable max = (TestComparable) Collections.max(testComparables);
    System.assertEquals(new TestComparable('C', 7), max, 'The max should be 7');
  }
}
