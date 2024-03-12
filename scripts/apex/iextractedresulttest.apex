ExtractedResult result = new ExtractedResult('test', 123, 1);
ExtractedResult result2 = new ExtractedResult('test 2', 456, 2);

List<Comparable> l = new List<Comparable>{result, result2};

l.sort();
System.debug(l);
