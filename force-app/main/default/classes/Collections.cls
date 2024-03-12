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
}
