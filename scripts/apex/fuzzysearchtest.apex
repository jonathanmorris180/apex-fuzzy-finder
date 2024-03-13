List<String> choices = new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'};
List<String> moreChoices = new List<String>{'Atlanta Falcons', 'New York Jets', 'New York Giants', 'Dallas Cowboys'};

Integer result = FuzzySearch.ratio('mysimilarstring', 'mymostsimilarstsdsdring');
System.debug('result: ' + result); 

List<ExtractedResult> results = FuzzySearch.extractTop('goolge', choices, 2);
List<ExtractedResult> results2 = FuzzySearch.extractTop('newyork', moreChoices, 3);


System.debug('results: ' + results);
System.debug('results2: ' + results2);

System.debug('partialRatio ' + FuzzySearch.partialRatio('similar', 'somewhresimlrbetweenthisstring')); // Should be 71
System.debug('tokenSortPartialRatio ' + FuzzySearch.tokenSortPartialRatio('mvn','wwwwww.mavencentral.comm')); // Should be 67
System.debug('tokenSortRatio ' + FuzzySearch.tokenSortRatio('fuzzy was a bear', 'fuzzy fuzzy was a bear')); // Should be 84
System.debug('tokenSetRatio ' + FuzzySearch.tokenSetRatio('fuzzy fuzzy fuzzy bear', 'fuzzy was a bear')); // Should be 100
System.debug('weightedRatio ' + FuzzySearch.weightedRatio('mvn','wwwwww.mavencentral.comm')); // Should be 60
System.debug('extractAll ' + FuzzySearch.extractAll('goolge', choices)); // Should get all of them with the result at index 0 being "google"
System.debug('extractSorted ' + FuzzySearch.extractSorted('goolge', choices)); // Should get all of them with first result being "google" and second being "googleplus"
System.debug('extractOne with SimpleRatio ' + FuzzySearch.extractOne('twiter', choices, new SimpleRatio())); // Should be "twitter"
System.debug('extractOne ' + FuzzySearch.extractOne('cowboys', moreChoices)); // Should be "Dallas Cowboys"

