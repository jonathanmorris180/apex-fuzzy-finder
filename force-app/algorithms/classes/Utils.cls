public class Utils {


    static List<String> tokenize(String input){

        return input.split('\\s+');

    }

    public static Set<String> tokenizeSet(String input){

        return new Set<String>(tokenize(input));

    }

    public static String sortAndJoin(List<String> col, String sep){

        col.sort();

        return String.join(col, '');

    }

    public static String sortAndJoin(Set<String> col, String sep){

        return sortAndJoin(new List<String>(col), sep);

    }

    public static Integer compare(Integer a, Integer b) {
      return a == b ? 0 : (a < b ? -1 : 1);
    }

    public static List<Comparable> findTopKHeap(List<Comparable> arr, Integer k) {
        PriorityQueue pq = new PriorityQueue();

        for (Comparable x : arr) {
            if (pq.size() < k) {
                pq.enqueue(x);
            } else if (x.compareTo(pq.peek()) > 0) {
                pq.dequeue();
                pq.enqueue(x);
            }
        }

        List<Comparable> res = new List<Comparable>();
        while (k-- > 0 && !pq.isEmpty()) {
            Comparable polled = pq.dequeue();
            if (polled != null) {
                res.add(polled);
            }
        }

        return res;
    }


}
