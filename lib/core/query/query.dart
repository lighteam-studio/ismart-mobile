class Query {
  int page;
  int itemsPerPage;
  String search;

  get offset {
    return (itemsPerPage * page) - itemsPerPage;
  }

  Query({
    this.page = 1,
    this.itemsPerPage = 20,
    this.search = "",
  });
}
