import 'dart:math';
import 'dart:convert';

class NaiveBayes {
  var _vocabulary = {};
  var _vocabularySize = 0;
  var _totalDocuments = 0;
  var _docCount = {};
  var _wordCount = {};
  var _wordFrequencyCount = {};
  var _categories = {};

  NaiveBayes();

  NaiveBayes.fromJson(String jsonStr) {
    var parsed = jsonDecode(jsonStr);
    _vocabulary = parsed['vocabulary'];
    _vocabularySize = parsed['vocabularySize'];
    _totalDocuments = parsed['totalDocuments'];
    _docCount = parsed['docCount'];
    _wordCount = parsed['wordCount'];
    _wordFrequencyCount = parsed['wordFrequencyCount'];
    _categories = parsed['categories'];
  }

  void initializeCategory(String categoryName) {
    if (_categories[categoryName] == null) {
      _docCount[categoryName] = 0;
      _wordCount[categoryName] = 0;
      _wordFrequencyCount[categoryName] = {};
      _categories[categoryName] = true;
    }
  }

  void learn(List<String> tokens, String category) {
    initializeCategory(category);
    _docCount[category]++;
    _totalDocuments++;
    var frequencyMap = frequencyTable(tokens);
    for (String token in frequencyMap.keys) {
      if (_vocabulary[token] == null) {
        _vocabulary[token] = true;
        _vocabularySize++;
      }
      var frequencyInText = frequencyMap[token];
      if (_wordFrequencyCount[category][token] == null) {
        _wordFrequencyCount[category][token] = frequencyInText;
      } else {
        _wordFrequencyCount[category][token] += frequencyInText;
      }
      _wordCount[category] += frequencyInText;
    }
  }

  Map frequencyTable(List tokens) {
    var t = {};
    tokens.forEach((token) => t[token] == null ? t[token] = 1 : t[token]++);
    return t;
  }

  double tokenProbability(String token, String category) {
    var wordFrequencyCountVal = _wordFrequencyCount[category][token] ?? 0;
    var wordCountVal = _wordCount[category];
    return (wordFrequencyCountVal + 1) / (wordCountVal + _vocabularySize);
  }

  String categorize(List<String> tokens) {
    var probabilityList = probabilities(tokens);
    probabilityList.sort((a, b) => b['value'].compareTo(a['value']));
    return probabilityList.isEmpty ? null : probabilityList.first['category'];
  }

  List probabilities(List<String> tokens) {
    var ret = [];
    var frequencyMap = frequencyTable(tokens);
    for (String category in _categories.keys) {
      var logProbability = log(_docCount[category] / _totalDocuments);
      frequencyMap.keys.forEach((token) => logProbability +=
          frequencyMap[token] * log(tokenProbability(token, category)));
      ret.add({'category': category, 'value': logProbability});
    }
    return ret;
  }

  String toJson() {
    var state = {};
    state['vocabulary'] = _vocabulary;
    state['vocabularySize'] = _vocabularySize;
    state['totalDocuments'] = _totalDocuments;
    state['docCount'] = _docCount;
    state['wordCount'] = _wordCount;
    state['wordFrequencyCount'] = _wordFrequencyCount;
    state['categories'] = _categories;
    return jsonEncode(state);
  }
}
