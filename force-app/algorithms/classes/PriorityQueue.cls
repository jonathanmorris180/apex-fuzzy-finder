global class PriorityQueue {
  private List<Comparable> elements;

  global PriorityQueue() {
    this.elements = new List<Comparable>();
  }

  global void enqueue(Comparable element) {
    elements.add(element);
    // Sort the elements based on their compareTo method
    elements.sort();
  }

  global Comparable dequeue() {
    if (!elements.isEmpty()) {
      return elements.remove(0);
    }
    return null;
  }

  // Returns the head of this queue or null if this queue is empty
  global Comparable peek() {
    if (!elements.isEmpty()) {
      return elements[0];
    }
    return null;
  }

  global Integer size() {
    return elements.size();
  }

  global Boolean isEmpty() {
    return elements.isEmpty();
  }
}
