class PaginationApiModel {
  int? page, totalPages, totalResults;
  bool? hasNext, hasPrevious;
  PaginationApiModel({
    this.totalResults,
    this.hasPrevious = true,
    this.page = 1,
    this.hasNext = true,
    this.totalPages,
  });

  factory PaginationApiModel.fromJson(Map<String, dynamic> map) {
    
    return PaginationApiModel(
      totalResults: map['total_results'],
      hasPrevious:  (1 < map["page"]),
      page: map["page"],
      hasNext: (map["page"] < map['total_pages']),
      totalPages: map['total_pages'],
    );
  }
}
