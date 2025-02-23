class TranslatePath {
  String transliteratePersianToEnglish(String persianText) {
    Map<String, String> transliterationMap = {
      'ا': 'a',
      'ب': 'b',
      'پ': 'p',
      'ت': 't',
      'ث': 'th',
      'ج': 'j',
      'چ': 'ch',
      'ح': 'h',
      'خ': 'kh',
      'د': 'd',
      'ذ': 'z',
      'ر': 'r',
      'ز': 'z',
      'ژ': 'zh',
      'س': 's',
      'ش': 'sh',
      'ص': 's',
      'ض': 'z',
      'ط': 't',
      'ظ': 'z',
      'ع': 'a',
      'غ': 'gh',
      'ف': 'f',
      'ق': 'gh',
      'ک': 'k',
      'گ': 'g',
      'ل': 'l',
      'م': 'm',
      'ن': 'n',
      'و': 'v',
      'ه': 'h',
      'ی': 'y',
      'ئ': 'e',
      'آ': 'aa',
      'او': 'oo'
    };

    String result = '';
    for (int i = 0; i < persianText.length; i++) {
      String char = persianText[i];
      if (transliterationMap.containsKey(char)) {
        result += transliterationMap[char]!;
      } else {
        result += char;
      }
    }
    return result;
  }
}