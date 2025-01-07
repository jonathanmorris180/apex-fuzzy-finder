[![Build](https://github.com/jonathanmorris180/apex-fuzzy-finder/actions/workflows/build.yaml/badge.svg)](https://github.com/jonathanmorris180/apex-fuzzy-finder/actions/workflows/build.yaml)
[![Deploy](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tak0000005FRRAA2)

<p align="center">
  <h1 align="center">apex-fuzzy-finder</h2>
</p>

<div align="center">
    Apex port of the <a href="https://github.com/xdrop/fuzzywuzzy">me.xdrop.fuzzywuzzy</a> fuzzy-finding library, which itself is a port of seatgeek's <a href="https://github.com/seatgeek/thefuzz">thefuzz</a> python library.
</div>

## 📋 Installation

Can be easily installed as an unlocked package. See the latest [release](https://github.com/jonathanmorris180/apex-fuzzy-finder/releases) for the installation link.

## ☄ Usage

All interactions with this library should take place through the `FuzzySearch` class's static methods.

> **Note**: Performance on large amounts of data can be slow in the Apex implementation. In particular, you may want to avoid using extract\* methods. Experiment instead with iterating over your data and using direct string comparisons via \*ratio and token\* methods.

#### Simple Ratio

```apex
fuzz.FuzzySearch.ratio('mysmilarstring','myawfullysimilarstirng'); // 72

fuzz.FuzzySearch.ratio('mysmilarstring','mysimilarstring'); // 97
```

#### Partial Ratio

```apex
fuzz.FuzzySearch.partialRatio('similar', 'somewhresimlrbetweenthisstring'); // 71
```

#### Token Sort Ratio

```apex
fuzz.FuzzySearch.tokenSortPartialRatio('order words out of', 'words out of order'); // 100
fuzz.FuzzySearch.tokenSortRatio('order words out of', 'words out of order'); // 100
```

#### Token Set Ratio

```apex
fuzz.FuzzySearch.tokenSetRatio('fuzzy was a bear', 'fuzzy fuzzy fuzzy bear'); // 100
fuzz.FuzzySearch.tokenSetPartialRatio('fuzzy was a bear', 'fuzzy fuzzy fuzzy bear'); // 100
```

#### Weighted Ratio

```apex
fuzz.FuzzySearch.weightedRatio('The quick brown fox jimps ofver the small lazy dog', 'the quick brown fox jumps over the small lazy dog'); // 97
```

#### Extract

```apex
fuzz.FuzzySearch.extractOne('cowboys', new List<String>{'Atlanta Falcons', 'New York Jets', 'New York Giants', 'Dallas Cowboys'}); // (string: Dallas Cowboys, score: 90, index: 3)
```

```apex
fuzz.FuzzySearch.extractTop('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 3); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index:5), (string: plexoogl, score: 43, index: 7)]
```

```apex
fuzz.FuzzySearch.extractAll('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}); // [(string: google, score: 83, index: 0), (string: bing, score: 20, index: 1), (string: facebook, score: 29, index: 2), (string: linkedin, score: 29, index: 3), (string: twitter, score: 15, index: 4), (string: googleplus, score: 63, index: 5), (string: bingnews, score: 29, index: 6), (string: plexoogl, score: 43, index: 7)]
// Only return results > 40
fuzz.FuzzySearch.extractAll('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 40); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7)]
```

```apex
fuzz.FuzzySearch.extractSorted('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7), (string: facebook, score: 29, index: 2), (string: linkedin, score: 29, index: 3), (string: bingnews, score: 29, index: 6), (string: bing, score: 20, index: 1), (string: twitter, score: 15, index: 4)]
// Only return a maximum of 3 results
fuzz.FuzzySearch.extractSorted('goolge', new List<String>{'google', 'bing', 'facebook', 'linkedin', 'twitter', 'googleplus', 'bingnews', 'plexoogl'}, 3); // [(string: google, score: 83, index: 0), (string: googleplus, score: 63, index: 5), (string: plexoogl, score: 43, index: 7)]
```
