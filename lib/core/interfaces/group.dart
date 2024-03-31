class Group<T> {
  final String? id;
  final String title;
  final List<T> items;

  Group({
    this.id,
    required this.title,
    required this.items,
  });
}
