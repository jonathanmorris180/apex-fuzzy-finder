@isTest
public class PrimitiveUtilsTest {
  @isTest
  static void itGetsTheMaxDoubleValue() {
    Double[] values = new List<Double>{ 1.0, 3.0, 2.0, 5.0, 4.0 };
    Double max = PrimitiveUtils.max(values);
    System.assertEquals(5.0, max);
  }

  @isTest
  static void itGetsTheMaxIntegerValue() {
    Integer[] values = new List<Integer>{ 1, 3, 2, 5, 4 };
    Integer max = PrimitiveUtils.max(values);
    System.assertEquals(5, max);
  }

  @isTest
  static void itReturnsZeroWhenNullOrEmpty() {
    Integer[] empty = new List<Integer>();
    Integer emptyMax = PrimitiveUtils.max(empty);
    System.assertEquals(0, emptyMax);

    Integer[] nullList = null;
    Integer nullMax = PrimitiveUtils.max(nullList);
    System.assertEquals(0, nullMax);
  }
}
