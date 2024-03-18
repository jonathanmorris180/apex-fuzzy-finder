@isTest
public class FuzzySearchTest {
  private static final List<String> COMPANY_NAMES = new List<String>{
    'google',
    'bing',
    'facebook',
    'linkedin',
    'twitter',
    'googleplus',
    'bingnews',
    'plexoogl'
  };
  private static final List<String> TEAM_NAMES = new List<String>{
    'Atlanta Falcons',
    'New York Jets',
    'New York Giants',
    'Dallas Cowboys'
  };
  private static final String TEST_ERROR = 'Does not match expected output from me.xdrop.fuzzywuzzy library. See https://github.com/xdrop/fuzzywuzzy/blob/master/README.md.';

  @isTest
  static void itGetsBasicRatio() {
    Integer result1 = FuzzySearch.ratio(
      'mysmilarstring',
      'myawfullysimilarstirng'
    );
    Integer result2 = FuzzySearch.ratio(
      'mysmilarstring',
      'mysimilarstring',
      new NoProcessToStringFunction()
    );
    System.assertEquals(72, result1, TEST_ERROR);
    System.assertEquals(97, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsPartialRatio() {
    Integer result1 = FuzzySearch.partialRatio(
      'similar',
      'somewhresimlrbetweenthisstring'
    );
    Integer result2 = FuzzySearch.partialRatio(
      'similar',
      'somewhresimlrbetweenthisstring',
      new NoProcessToStringFunction()
    );
    System.assertEquals(71, result1, TEST_ERROR);
    System.assertEquals(71, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsTokenSortRatio() {
    Integer result1 = FuzzySearch.tokenSortRatio(
      'fuzzy was a bear',
      'fuzzy fuzzy was a bear'
    );
    Integer result2 = FuzzySearch.tokenSortRatio(
      'fuzzy was a bear',
      'fuzzy fuzzy was a bear',
      new NoProcessToStringFunction()
    );
    System.assertEquals(84, result1, TEST_ERROR);
    System.assertEquals(84, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsTokeSortPartialRatio() {
    Integer result1 = FuzzySearch.tokenSortPartialRatio(
      'mvn',
      'wwwwww.mavencentral.comm'
    );
    Integer result2 = FuzzySearch.tokenSortPartialRatio(
      'mvn',
      'wwwwww.mavencentral.comm',
      new NoProcessToStringFunction()
    );
    System.assertEquals(67, result1, TEST_ERROR);
    System.assertEquals(67, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsTokenSetRatio() {
    Integer result1 = FuzzySearch.tokenSetRatio(
      'fuzzy fuzzy fuzzy bear',
      'fuzzy was a bear'
    );
    Integer result2 = FuzzySearch.tokenSetRatio(
      'fuzzy fuzzy fuzzy bear',
      'fuzzy was a bear',
      new NoProcessToStringFunction()
    );
    System.assertEquals(100, result1, TEST_ERROR);
    System.assertEquals(100, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsTokenSetPartialRatio() {
    Integer result1 = FuzzySearch.tokenSetPartialRatio(
      'fuzzy fuzzy fuzzy bear',
      'fuzzy was a bear'
    );
    Integer result2 = FuzzySearch.tokenSetPartialRatio(
      'fuzzy fuzzy fuzzy bear',
      'fuzzy was a bear',
      new NoProcessToStringFunction()
    );
    System.assertEquals(100, result1, TEST_ERROR);
    System.assertEquals(100, result2, TEST_ERROR);
  }

  @isTest
  static void itGetsWeightedRatio() {
    Integer result1 = FuzzySearch.weightedRatio(
      'mvn',
      'wwwwww.mavencentral.comm'
    );
    Integer result2 = FuzzySearch.weightedRatio(
      'mvn',
      'wwwwww.mavencentral.comm',
      new NoProcessToStringFunction()
    );
    System.assertEquals(60, result1, TEST_ERROR);
    System.assertEquals(60, result2, TEST_ERROR);
  }

  @isTest
  static void itExtractsAll() {
    List<ExtractedResult> results = FuzzySearch.extractAll(
      'goolge',
      COMPANY_NAMES
    );
    System.assertEquals(
      COMPANY_NAMES.size(),
      results.size(),
      'It should return all results'
    );
    System.assertEquals(
      'google',
      results[0].getString(),
      'It should return the most similar result first'
    );
    System.assertEquals(
      83,
      results[0].getScore(),
      'The result for google should have a score of 83'
    );
  }

  @isTest
  static void itExtractsSorted() {
    List<ExtractedResult> result1 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES
    );
    List<ExtractedResult> result2 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES)
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction()
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction()
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2,
        result3,
        result4
      }
    ) {
      System.assertEquals(
        COMPANY_NAMES.size(),
        result.size(),
        'It should return all results'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
      System.assertEquals(
        83,
        result[0].getScore(),
        'The result for google should have a score of 83'
      );
    }
  }

  @isTest
  static void itExtractsSortedWithApplicable() {
    List<ExtractedResult> result1 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new SimpleRatio()
    );
    List<ExtractedResult> result2 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new SimpleRatio()
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      new SimpleRatio()
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      new SimpleRatio()
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2,
        result3,
        result4
      }
    ) {
      System.assertEquals(
        COMPANY_NAMES.size(),
        result.size(),
        'It should return all results'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
      System.assertEquals(
        83,
        result[0].getScore(),
        'The result for google should have a score of 83'
      );
    }
  }

  @isTest
  static void itExtractsSortedWithApplicableCutoff() {
    List<ExtractedResult> result1 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new SimpleRatio(),
      80
    );
    List<ExtractedResult> result2 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new SimpleRatio(),
      80
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      80
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      80
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2,
        result3,
        result4
      }
    ) {
      System.assertEquals(
        1,
        result.size(),
        'It should only return one result since the cutoff is 80'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
    }
  }

  @isTest
  static void itExtractsSortedWithCutoff() {
    List<ExtractedResult> result1 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      80
    );
    List<ExtractedResult> result2 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      80
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractSorted(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      80
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractSorted(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      80
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2,
        result3,
        result4
      }
    ) {
      System.assertEquals(
        1,
        result.size(),
        'It should only return one result since the cutoff is 80'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
    }
  }

  @isTest
  static void itExtractsOne() {
    ExtractedResult result = FuzzySearch.extractOne('twiter', COMPANY_NAMES);
    System.assertEquals(
      'twitter',
      result.getString(),
      'It should return the most similar result'
    );
    System.assertEquals(
      92,
      result.getScore(),
      'The result for twitter should have a score of 92'
    );
  }

  @isTest
  static void itExtractsTop() {
    List<ExtractedResult> result1 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      3
    );
    List<ExtractedResult> result2 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      3
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      3
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      3
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2
      }
    ) {
      System.assertEquals(
        3,
        result.size(),
        'It should return the top 3 results'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
      System.assertEquals(
        'googleplus',
        result[1].getString(),
        'The second most similar result should be googleplus'
      );
      System.assertEquals(
        'plexoogl',
        result[2].getString(),
        'The third most similar result should be plexoogl'
      );
    }
  }

  /**
   * Overloaded method that takes an Applicable with number of choices to return
   * and a ratio cutoff (e.g., only return matches that are 80+)
   */
  @isTest
  static void itExtractsTopWithApplicableChoicesCutoff() {
    List<ExtractedResult> result1 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new SimpleRatio(),
      3,
      80
    );
    List<ExtractedResult> result2 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new SimpleRatio(),
      3,
      80
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      3,
      80
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      3,
      80
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2
      }
    ) {
      System.assertEquals(
        1,
        result.size(),
        'It should only return one result since the cutoff is 80'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
    }
  }

  /**
   * This uses the weighted ratio by default
   */
  @isTest
  static void itExtractsTopWithChoicesCutoff() {
    List<ExtractedResult> result1 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      3,
      0
    );
    List<ExtractedResult> result2 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      3,
      0
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      3,
      0
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      3,
      0
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2
      }
    ) {
      System.assertEquals(
        3,
        result.size(),
        'It should return the top 3 results'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
      System.assertEquals(
        'googleplus',
        result[1].getString(),
        'The second most similar result should be googleplus'
      );
      System.assertEquals(
        'plexoogl',
        result[2].getString(),
        'The third most similar result should be plexoogl'
      );
    }
  }

  /**
   * Overloaded method that takes an Applicable with number of choices to return
   */
  @isTest
  static void itExtractsTopWithApplicableChoices() {
    List<ExtractedResult> result1 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new SimpleRatio(),
      3
    );
    List<ExtractedResult> result2 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new SimpleRatio(),
      3
    );
    List<BoundExtractedResult> result3 = FuzzySearch.extractTop(
      'goolge',
      COMPANY_NAMES,
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      3
    );
    List<BoundExtractedResult> result4 = FuzzySearch.extractTop(
      'goolge',
      new Set<String>(COMPANY_NAMES),
      new NoProcessToStringFunction(),
      new SimpleRatio(),
      3
    );
    for (
      List<IExtractedResult> result : new List<List<IExtractedResult>>{
        result1,
        result2
      }
    ) {
      System.assertEquals(
        3,
        result.size(),
        'It should return the top 3 results'
      );
      System.assertEquals(
        'google',
        result[0].getString(),
        'It should return the most similar result first'
      );
      System.assertEquals(
        'googleplus',
        result[1].getString(),
        'The second most similar result should be googleplus'
      );
      System.assertEquals(
        'plexoogl',
        result[2].getString(),
        'The third most similar result should be plexoogl'
      );
    }
  }
}
