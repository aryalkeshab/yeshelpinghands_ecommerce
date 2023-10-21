class StringCapitalize {
  static String capitalizeSentence(String sentence) {
    var words = sentence.split(' ');

    var capitalizedWords = words.map(
        (word) => '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}');
    return capitalizedWords.join(' ');
  }
}
