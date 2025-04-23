extension Tcase on String {
  String get tcase => replaceFirst(
        this[0],
        this[0].toUpperCase(),
      );
}
