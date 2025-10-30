String removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
  return htmlText.replaceAll(exp, '').trim();
}
