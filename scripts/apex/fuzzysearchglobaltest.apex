List<String> choices = new List<String>{
  'google',
  'bing',
  'facebook',
  'linkedin',
  'twitter',
  'googleplus',
  'bingnews',
  'plexoogl'
};
List<String> moreChoices = new List<String>{
  'Atlanta Falcons',
  'New York Jets',
  'New York Giants',
  'Dallas Cowboys'
};

Integer result = fuzz.FuzzySearch.ratio(
  'mysimilarstring',
  'mymostsimilarstsdsdring'
);
System.debug('result: ' + result);

System.debug(
  'partialRatio ' +
  fuzz.FuzzySearch.partialRatio('similar', 'somewhresimlrbetweenthisstring')
); // Should be 71
System.debug(
  'tokenSortPartialRatio ' +
  fuzz.FuzzySearch.tokenSortPartialRatio('mvn', 'wwwwww.mavencentral.comm')
); // Should be 67
System.debug(
  'tokenSortRatio ' +
  fuzz.FuzzySearch.tokenSortRatio('fuzzy was a bear', 'fuzzy fuzzy was a bear')
); // Should be 84
System.debug(
  'tokenSetRatio ' +
  fuzz.FuzzySearch.tokenSetRatio('fuzzy fuzzy fuzzy bear', 'fuzzy was a bear')
); // Should be 100
System.debug(
  'weightedRatio ' +
  fuzz.FuzzySearch.weightedRatio('mvn', 'wwwwww.mavencentral.comm')
); // Should be 60
System.debug('extractAll ' + fuzz.FuzzySearch.extractAll('goolge', choices)); // Should get all of them with the result at index 0 being "google"
System.debug('extractSorted ' + fuzz.FuzzySearch.extractSorted('goolge', choices)); // Should get all of them with first result being "google" and second being "googleplus"
System.debug(
  'extractOne with SimpleRatio ' +
  fuzz.FuzzySearch.extractOne('twiter', choices, new SimpleRatio())
); // Should be "twitter"
System.debug('extractOne ' + fuzz.FuzzySearch.extractOne('cowboys', moreChoices)); // Should be "Dallas Cowboys"

List<ExtractedResult> results = fuzz.FuzzySearch.extractTop('goolge', choices, 2);
List<ExtractedResult> results2 = fuzz.FuzzySearch.extractTop(
  'newyork',
  moreChoices,
  3
);

System.debug('results: ' + results);
System.debug('results2: ' + results2);
