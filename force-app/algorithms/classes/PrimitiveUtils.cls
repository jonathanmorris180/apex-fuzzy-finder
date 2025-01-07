global class PrimitiveUtils {
  global static Double max(List<Double> elems) {
    if (elems == null || elems.isEmpty()) {
      return 0;
    }

    Double best = elems[0];

    for (Double t : elems) {
      if (t > best) {
        best = t;
      }
    }

    return best;
  }

  global static Integer max(List<Integer> elems) {
    if (elems == null || elems.isEmpty()) {
      return 0;
    }

    Integer best = elems[0];

    for (Integer t : elems) {
      if (t > best) {
        best = t;
      }
    }

    return best;
  }
}
