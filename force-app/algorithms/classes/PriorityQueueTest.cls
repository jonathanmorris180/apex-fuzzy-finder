@isTest
public class PriorityQueueTest {
  class TestComparable implements Comparable {
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
  }

  private static PriorityQueue getTestQueue() {
    PriorityQueue queue = new PriorityQueue();
    queue.enqueue(new TestComparable('A', 50));
    queue.enqueue(new TestComparable('B', 10));
    return queue;
  }

  @isTest
  static void itEnqueuesElements() {
    PriorityQueue queue = getTestQueue();
    System.assertEquals(2, queue.size());
    TestComparable firstElement = (TestComparable) queue.peek();
    System.assertEquals('B', firstElement.name);
  }
}
