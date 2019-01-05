# `naive_bayes`: A Naive-Bayes Classifier for Dart [WIP]

`naive_bayes` takes a document (piece of text), and tells you what category that document belongs to.

from @[ttezel](https://github.com/ttezel)'s [bayes](https://github.com/ttezel/bayes).js and @[pwlmaciejewski](https://github.com/pwlmaciejewski)'s [pull request](https://github.com/ttezel/bayes/pull/7).

## What can I use this for?

You can use this for categorizing any text content into any arbitrary set of **categories**. For example:

- is an email **spam**, or **not spam** ?
- is a news article about **technology**, **politics**, or **sports** ?
- is a piece of text expressing **positive** emotions, or **negative** emotions?

![cat](http://i.imgur.com/bQG1uvQ.gif)

## Usage

```javascript
var classifier = NaiveBayes();

classifier
// teach it positive phrases
  ..learn(
    ['amazing', 'awesome', 'movie', 'Yeah', 'Oh', 'boy'],
    'positive',
  )
  ..learn(
    ['Sweet', 'this', 'is', 'incredibly', 'amazing', 'perfect', 'great'],
    'positive',
  )
// teach it a negative phrase
  ..learn(
    ['terrible', 'shitty', 'thing', 'Damn', 'Sucks'],
    'negative',
  );

// now ask it to categorize a document it has never seen before

classifier.categorize(['awesome', 'cool', 'amazing', 'Yay']);
// => 'positive'

classifier.probabilities(['awesome', 'cool', 'amazing', 'Yay']);
// => [{category: positive, value: -12.218495165528731}, {category: negative, value: -13.462782102101373}]

// serialize the classifier's state as a JSON string.
var stateJson = classifier.toJson()

// load the classifier back from its JSON representation.
var revivedClassifier = NaiveBayes.fromJson(stateJson)

```

## References

Naive-Bayes Classifier for node.js

[https://github.com/ttezel/bayes](https://github.com/ttezel/bayes)

[pull request] New method: .probabilities()

[https://github.com/ttezel/bayes/pull/7](https://github.com/ttezel/bayes/pull/7)
