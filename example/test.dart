import 'package:naive_bayes/naive_bayes.dart';

main() {
  var classifier = NaiveBayes();
  classifier
      .learn(['amazing', 'awesome', 'movie', 'Yeah', 'Oh', 'boy'], 'positive');
  classifier.learn(
      ['Sweet', 'this', 'is', 'incredibly', 'amazing', 'perfect', 'great'],
      'positive');
  classifier
      .learn(['terrible', 'shitty', 'thing', 'Damn', 'Sucks'], 'negative');
  print(classifier.probabilities(['awesome', 'cool', 'amazing', 'Yay']));
  print(classifier.categorize(['awesome', 'cool', 'amazing', 'Yay']));
}
