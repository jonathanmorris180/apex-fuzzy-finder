public class Collections {

    public static Integer max(Integer[] arr) {
        Integer max = arr[0];
        for (Integer i = 1; i < arr.size(); i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }

    public static List<Comparable> reverse(List<Comparable> l) {
        if (l == null || l.size() <= 1) {
            return l; 
        }

        List<Comparable> reversed = new List<Comparable>();
        for (Integer i = l.size() - 1; i >= 0; i--) {
            reversed.add(l.get(i));
        }
        return reversed;
    }

    public static Comparable max(Comparable[] arr) {
        Comparable max = arr[0];
        for (Integer i = 1; i < arr.size(); i++) {
            if (arr[i].compareTo(max) > 0) {
                max = arr[i];
            }
        }
        return max;
    }

    public static void reverse(List<Comparable> l) {
        if (l == null || l.size() <= 1) {
            return; // No need to reverse if the list is null, empty, or contains a single element
        }

        Integer start = 0;
        Integer listEnd = l.size() - 1;

        while (start < listEnd) {
            // Swap the elements at start and end
            Comparable temp = l.get(start);
            l.set(start, l.get(listEnd));
            l.set(listEnd, temp);

            // Move towards the center of the list
            start++;
            listEnd--;
        }
    }
}
