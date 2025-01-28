extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeEachWord {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalizeFirst).join(' ');
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  String get removeHtmlTags {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  // For handling post content
  bool get hasUrl {
    final urlRegExp = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})',
    );
    return urlRegExp.hasMatch(this);
  }

  List<String> extractUrls() {
    final urlRegExp = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})',
    );
    return urlRegExp.allMatches(this).map((match) => match.group(0)!).toList();
  }
}