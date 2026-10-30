import '../models/vocabulary_word.dart';

abstract final class VocabularyCatalog {
  static const words = <VocabularyWord>[
    VocabularyWord(
      id: 'as-many-as',
      word: 'as many as',
      subtitle: 'as many as',
    ),
    VocabularyWord(
      id: 'city-break',
      word: 'City break',
      subtitle: 'City break',
    ),
    VocabularyWord(
      id: 'cosmopolitan',
      word: 'Cosmopolitan',
      subtitle: 'Cosmopolitan',
    ),
    VocabularyWord(id: 'crowded', word: 'Crowded', subtitle: 'Crowded'),
    VocabularyWord(id: 'embassy', word: 'Embassy', subtitle: 'Embassy'),
    VocabularyWord(id: 'getaway', word: 'Getaway', subtitle: 'Getaway'),
    VocabularyWord(
      id: 'disappointing',
      word: 'Disappointing',
      subtitle: 'Disappointing',
    ),
    VocabularyWord(
      id: 'jaw-dropping',
      word: 'Jaw-dropping',
      subtitle: 'Jaw-dropping',
    ),
    VocabularyWord(id: 'lively', word: 'Lively', subtitle: 'Lively'),
  ];
}
