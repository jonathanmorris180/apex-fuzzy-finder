List<String> oppNames = new List<String>{
  // Add nameq
};

System.debug('Before: ' + System.now());
List<ExtractedResult> results = fuzz.FuzzySearch.extractSorted('Ad Credit', oppNames, 90);
System.debug('results: ' + results);
System.debug('After: ' + System.now());
