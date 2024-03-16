public class PrimitiveUtils {
  public static Double max(List<Double> elems) {
    if (elems.size() == 0)
      return 0;

    Double best = elems[0];

    for (Double t : elems) {
      if (t > best) {
        best = t;
      }
    }

    return best;
  }

  public static Integer max(List<Integer> elems) {
    if (elems.size() == 0)
      return 0;

    Integer best = elems[0];

    for (Integer t : elems) {
      if (t > best) {
        best = t;
      }
    }

    return best;
  }
}
