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
    System.assertEquals(2, queue.size(), 'Test queue should have 2 elements');
    TestComparable firstElement = (TestComparable) queue.peek();
    System.assert(!queue.isEmpty(), 'Queue should not be empty');
    System.assertEquals(
      'B',
      firstElement.name,
      'First element should be B after sorting'
    );
    System.assertEquals(
      2,
      queue.size(),
      'Queue should have 2 elements as nothing has been dequeued'
    );
  }

  @isTest
  static void itDequeuesElements() {
    PriorityQueue queue = getTestQueue();
    System.assertEquals(2, queue.size(), 'Test queue should have 2 elements');
    TestComparable firstElement = (TestComparable) queue.dequeue();
    System.assert(!queue.isEmpty(), 'Queue should not be empty');
    System.assertEquals(
      'B',
      firstElement.name,
      'First element should be B after sorting'
    );
    System.assertEquals(
      1,
      queue.size(),
      'Queue should have 1 element after dequeuing'
    );
  }
}
