class PagedResponse<T> {
  List<T> items;
  bool isNextPageAvailable;
  int perPage;
  int totalCount;

  PagedResponse({
    required this.items,
    required this.isNextPageAvailable,
    required this.perPage,
    required this.totalCount,
  });
}
