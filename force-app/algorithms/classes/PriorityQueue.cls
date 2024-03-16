public class PriorityQueue {
  private List<Comparable> elements;

  public PriorityQueue() {
    this.elements = new List<Comparable>();
  }

  public void enqueue(Comparable element) {
    elements.add(element);
    // Sort the elements based on their compareTo method
    elements.sort();
  }

  public Comparable dequeue() {
    if (!elements.isEmpty()) {
      return elements.remove(0);
    }
    return null;
  }

  // Returns the head of this queue or null if this queue is empty
  public Comparable peek() {
    if (!elements.isEmpty()) {
      return elements[0];
    }
    return null;
  }

  public Integer size() {
    return elements.size();
  }

  public Boolean isEmpty() {
    return elements.isEmpty();
  }
}
