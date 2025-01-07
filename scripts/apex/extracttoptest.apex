List<String> oppNames = new List<String>{
  // Add names
};

System.debug('Before: ' + System.now());
List<ExtractedResult> results = fuzz.FuzzySearch.extractTop('Ad Credit', oppNames, 10);
System.debug('After: ' + System.now());
