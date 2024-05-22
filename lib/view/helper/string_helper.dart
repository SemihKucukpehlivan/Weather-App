class StringHelper {
  static String capitalizeFirstLetters(String str) {
    if (str.isEmpty) return str;
    return str.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).join(' ');
  }
}
