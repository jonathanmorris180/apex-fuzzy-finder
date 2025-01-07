global class Extractor {
  private Integer cutoff;

  global Extractor() {
    this.cutoff = 0;
  }

  global Extractor(Integer cutoff) {
    this.cutoff = cutoff;
  }

  global Extractor with(Integer cutoff) {
    this.setCutoff(cutoff);
    return this;
  }

  /**
   * Returns the list of choices with their associated scores of similarity in a list
   * of {@link ExtractedResult}
   *
   * @param query The query string
   * @param choices The list of choices
   * @param func The function to apply
   * @return The list of results
   */
  global List<ExtractedResult> extractWithoutOrder(
    String query,
    List<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> yields = new List<ExtractedResult>();
    Integer index = 0;

    for (String s : choices) {
      Integer score = func.apply(query, s);

      if (score >= cutoff) {
        yields.add(new ExtractedResult(s, score, index));
      }
      index++;
    }

    return yields;
  }

  global List<ExtractedResult> extractWithoutOrder(
    String query,
    Set<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> yields = new List<ExtractedResult>();
    Integer index = 0;

    for (String s : choices) {
      Integer score = func.apply(query, s);

      if (score >= cutoff) {
        yields.add(new ExtractedResult(s, score, index));
      }
      index++;
    }

    return yields;
  }

  /**
   * Returns the list of choices with their associated scores of similarity in a list
   * of {@link ExtractedResult}
   *
   * @param query The query string
   * @param choices The list of choices
   * @param toStringFunction The ToStringFunction to be applied to all choices.
   * @param func The function to apply
   * @return The list of results
   */
  global List<BoundExtractedResult> extractWithoutOrder(
    String query,
    List<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> yields = new List<BoundExtractedResult>();
    Integer index = 0;

    for (String t : choices) {
      String s = toStringFunction.apply(t);
      Integer score = func.apply(query, s);

      if (score >= cutoff) {
        yields.add(new BoundExtractedResult(s, score, index));
      }
      index++;
    }

    return yields;
  }

  global List<BoundExtractedResult> extractWithoutOrder(
    String query,
    Set<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> yields = new List<BoundExtractedResult>();
    Integer index = 0;

    for (String t : choices) {
      String s = toStringFunction.apply(t);
      Integer score = func.apply(query, s);

      if (score >= cutoff) {
        yields.add(new BoundExtractedResult(s, score, index));
      }
      index++;
    }

    return yields;
  }

  /**
   * Find the single best match above a score in a list of choices.
   *
   * @param query  A string to match against
   * @param choices A list of choices
   * @param func   Scoring function
   * @return An object containing the best match and it's score
   */
  global ExtractedResult extractOne(
    String query,
    List<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> extracted = extractWithoutOrder(query, choices, func);

    return (ExtractedResult) Collections.max(extracted);
  }

  global ExtractedResult extractOne(
    String query,
    Set<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> extracted = extractWithoutOrder(query, choices, func);

    return (ExtractedResult) Collections.max(extracted);
  }

  /**
   * Find the single best match above a score in a list of choices.
   *
   * @param query  A string to match against
   * @param choices A list of choices
   * @param toStringFunction The ToStringFunction to be applied to all choices.
   * @param func   Scoring function
   * @return An object containing the best match and it's score
   */
  global BoundExtractedResult extractOne(
    String query,
    List<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> extracted = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );

    return (BoundExtractedResult) Collections.max(extracted);
  }

  global BoundExtractedResult extractOne(
    String query,
    Set<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> extracted = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );

    return (BoundExtractedResult) Collections.max(extracted);
  }

  /**
   * Creates a <b>sorted</b> list of {@link ExtractedResult}  which contain the
   * top @param limit most similar choices
   *
   * @param query   The query string
   * @param choices A list of choices
   * @param func    The scoring function
   * @return A list of the results
   */
  global List<ExtractedResult> extractTop(
    String query,
    List<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> best = extractWithoutOrder(query, choices, func);
    best.sort();
    best = this.toExtractedResult(Collections.reverse(best));

    return best;
  }

  global List<ExtractedResult> extractTop(
    String query,
    Set<String> choices,
    Applicable func
  ) {
    List<ExtractedResult> best = extractWithoutOrder(query, choices, func);
    best.sort();
    best = this.toExtractedResult(Collections.reverse(best));

    return best;
  }

  /**
   * Creates a <b>sorted</b> list of {@link ExtractedResult}  which contain the
   * top @param limit most similar choices
   *
   * @param query   The query string
   * @param choices A list of choices
   * @param toStringFunction The ToStringFunction to be applied to all choices.
   * @param func    The scoring function
   * @return A list of the results
   */
  global List<BoundExtractedResult> extractTop(
    String query,
    List<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> best = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );
    best.sort();
    best = this.toBoundExtractedResult(Collections.reverse(best));

    return best;
  }

  global List<BoundExtractedResult> extractTop(
    String query,
    Set<String> choices,
    ToStringFunction toStringFunction,
    Applicable func
  ) {
    List<BoundExtractedResult> best = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );
    best.sort();
    best = this.toBoundExtractedResult(Collections.reverse(best));

    return best;
  }

  /**
   * Creates a <b>sorted</b> list of {@link ExtractedResult} which contain the
   * top @param limit most similar choices
   *
   * @param query   The query string
   * @param choices A list of choices
   * @param limit   Limits the number of results and speeds up
   *                the search (k-top heap sort) is used
   * @return A list of the results
   */
  global List<ExtractedResult> extractTop(
    String query,
    List<String> choices,
    Applicable func,
    Integer numChoices
  ) {
    List<ExtractedResult> best = extractWithoutOrder(query, choices, func);

    List<ExtractedResult> results = this.toExtractedResult(
      Utils.findTopKHeap(best, numChoices)
    );
    results = this.toExtractedResult(Collections.reverse(results));

    return results;
  }

  global List<ExtractedResult> extractTop(
    String query,
    Set<String> choices,
    Applicable func,
    Integer numChoices
  ) {
    List<ExtractedResult> best = extractWithoutOrder(query, choices, func);

    List<ExtractedResult> results = this.toExtractedResult(
      Utils.findTopKHeap(best, numChoices)
    );
    results = this.toExtractedResult(Collections.reverse(results));

    return results;
  }

  private List<ExtractedResult> toExtractedResult(List<Comparable> items) {
    List<ExtractedResult> result = new List<ExtractedResult>();
    for (Comparable c : items) {
      if (c instanceof ExtractedResult) {
        result.add((ExtractedResult) c);
      }
    }
    return result;
  }

  private List<BoundExtractedResult> toBoundExtractedResult(
    List<Comparable> items
  ) {
    List<BoundExtractedResult> result = new List<BoundExtractedResult>();
    for (Comparable c : items) {
      if (c instanceof BoundExtractedResult) {
        result.add((BoundExtractedResult) c);
      }
    }
    return result;
  }

  /**
   * Creates a <b>sorted</b> list of {@link ExtractedResult} which contain the
   * top @param limit most similar choices
   *
   * @param query   The query string
   * @param choices A list of choices
   * @param toStringFunction The ToStringFunction to be applied to all choices.
   * @param limit   Limits the number of results and speeds up
   *                the search (k-top heap sort) is used
   * @return A list of the results
   */
  global List<BoundExtractedResult> extractTop(
    String query,
    List<String> choices,
    ToStringFunction toStringFunction,
    Applicable func,
    Integer numChoices
  ) {
    List<BoundExtractedResult> best = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );

    List<BoundExtractedResult> results = this.toBoundExtractedResult(
      Utils.findTopKHeap(best, numChoices)
    );
    results = this.toBoundExtractedResult(Collections.reverse(results));

    return results;
  }

  global List<BoundExtractedResult> extractTop(
    String query,
    Set<String> choices,
    ToStringFunction toStringFunction,
    Applicable func,
    Integer numChoices
  ) {
    List<BoundExtractedResult> best = extractWithoutOrder(
      query,
      choices,
      toStringFunction,
      func
    );

    List<BoundExtractedResult> results = this.toBoundExtractedResult(
      Utils.findTopKHeap(best, numChoices)
    );
    results = this.toBoundExtractedResult(Collections.reverse(results));

    return results;
  }

  global Integer getCutoff() {
    return cutoff;
  }

  global void setCutoff(Integer cutoff) {
    this.cutoff = cutoff;
  }
}
