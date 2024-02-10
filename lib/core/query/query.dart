class Query {
  int page;
  int itemsPerPage;
  String search;

  Query({
    this.page = 1,
    this.itemsPerPage = 10,
    this.search = "",
  });
}
