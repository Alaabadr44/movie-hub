abstract class MainRequestEntity<T> {
  int? reqPage;
  MainRequestEntity(this.reqPage);

  MainRequestEntity copyWith(int? newPage);
}
