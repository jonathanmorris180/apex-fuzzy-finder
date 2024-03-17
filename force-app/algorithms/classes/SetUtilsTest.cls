@isTest
public class SetUtilsTest {
  @isTest
  static void itGetsTheIntersection() {
    Set<String> set1 = new Set<String>{ 'a', 'b', 'c' };
    Set<String> set2 = new Set<String>{ 'b', 'c', 'd' };
    Set<String> expected = new Set<String>{ 'b', 'c' };
    System.assertEquals(
      expected,
      SetUtils.intersection(set1, set2),
      'Did not generate the expected intersection of two sets'
    );
  }

  @isTest
  static void itGetsTheDifference() {
    Set<String> set1 = new Set<String>{ 'a', 'b', 'c' };
    Set<String> set2 = new Set<String>{ 'b', 'c', 'd' };
    Set<String> expected = new Set<String>{ 'a' };
    System.assertEquals(
      expected,
      SetUtils.difference(set1, set2),
      'It should keep only the elements that are in the first set but not in the second'
    );
  }
}
