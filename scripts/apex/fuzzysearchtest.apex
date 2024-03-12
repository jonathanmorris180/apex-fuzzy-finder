List<String> choices = new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'};
List<String> moreChoices = new List<String>{'Atlanta Falcons', 'New York Jets', 'New York Giants', 'Dallas Cowboys'};

Integer result = FuzzySearch.ratio('mysimilarstring', 'mymostsimilarstsdsdring');
System.debug('result: ' + result); 

List<ExtractedResult> results = FuzzySearch.extractTop('goolge', choices, 2);


System.debug('results: ' + results);

