<p align="center">
  <h1 align="center">apex-fuzzy-finder</h2>
</p>

<div align="center">
    Apex port of the <a href="https://github.com/xdrop/fuzzywuzzy">me.xdrop.fuzzywuzzy</a> apex fuzzy-finding library, which itself is a port of seatgeek's <a href="https://github.com/seatgeek/thefuzz">thefuzz</a> python library.
</div>

## 📋 Installation

Can be easily installed as an unlocked package via this link.

## ☄ Usage

All interactions with this library take place through the `FuzzySearch` class.

> **Note**: Performance on large amounts of data can be slow in the Apex implementation. In particular, you may want to avoid using extract\* methods. Experiment instead with iterating over your data and using direct string comparisons via \*ratio and token\* methods.

#### Simple Ratio

```apex
FuzzySearch.ratio('mysmilarstring','myawfullysimilarstirng'); // 72

FuzzySearch.ratio('mysmilarstring','mysimilarstring'); // 97
```

#### Partial Ratio

```apex
FuzzySearch.partialRatio('similar', 'somewhresimlrbetweenthisstring'); // 71
```

#### Token Sort Ratio

```apex
FuzzySearch.tokenSortPartialRatio('order words out of', 'words out of order'); // 100
FuzzySearch.tokenSortRatio('order words out of', 'words out of order'); // 100
```

#### Token Set Ratio

```apex
FuzzySearch.tokenSetRatio('fuzzy was a bear', 'fuzzy fuzzy fuzzy bear'); // 100
FuzzySearch.tokenSetPartialRatio('fuzzy was a bear', 'fuzzy fuzzy fuzzy bear'); // 100
```

#### Weighted Ratio

```apex
FuzzySearch.weightedRatio('The quick brown fox jimps ofver the small lazy dog', 'the quick brown fox jumps over the small lazy dog'); // 97
```

#### Extract

```apex
FuzzySearch.extractOne('cowboys', new List<String>{'Atlanta Falcons', 'New York Jets', 'New York Giants', 'Dallas Cowboys'}); // (string: Dallas Cowboys, score: 90, index: 3)
```

```apex
FuzzySearch.extractTop('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 3); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index:5), (string: plexoogl, score: 43, index: 7)]
```

```apex
FuzzySearch.extractAll('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}); // [(string: google, score: 83, index: 0), (string: bing, score: 20, index: 1), (string: facebook, score: 29, index: 2), (string: linkedin, score: 29, index: 3), (string: twitter, score: 15, index: 4), (string: googleplus, score: 63, index: 5), (string: bingnews, score: 29, index: 6), (string: plexoogl, score: 43, index: 7)]
// Only return results > 40
FuzzySearch.extractAll('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 40); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7)]
```

```apex
FuzzySearch.extractSorted('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7), (string: facebook, score: 29, index: 2), (string: linkedin, score: 29, index: 3), (string: bingnews, score: 29, index: 6), (string: bing, score: 20, index: 1), (string: twitter, score: 15, index: 4)]
// Only return results > 3
FuzzySearch.extractSorted('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 3); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7)]
```
