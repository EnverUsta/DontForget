class CapelItem {
  final String id;
  final String title;
  final String subtitle;
  String term;
  int level;
  bool isFinished;

  DateTime startTime = DateTime.now();

  CapelItem({
    this.id,
    this.title,
    this.subtitle,
    this.term,
    this.level,
    this.isFinished,
  });
}
