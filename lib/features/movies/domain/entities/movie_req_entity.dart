import '../../../../core/resources/main_req_entity.dart';

class MovieRequestEntity extends MainRequestEntity<MovieRequestEntity> {
  int? page;
  String? q;
  MovieRequestEntity({
    this.page,
    this.q,
  }) : super(page);

  @override
  MainRequestEntity<MovieRequestEntity> copyWith(int? newPage,
      {String? query}) {
    return MovieRequestEntity(
      page: newPage ?? page,
      q: q ?? query,
    );
  }
}
