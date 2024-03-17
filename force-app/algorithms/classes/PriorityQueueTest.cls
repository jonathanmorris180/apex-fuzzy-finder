@isTest
public class PriorityQueueTest {
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
