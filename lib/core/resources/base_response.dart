import 'pagination_api_model.dart';

abstract class BaseResponse<T> {
  T? result;

  PaginationApiModel? pagination;

  BaseResponse({
    this.pagination,
    this.result,
  });

  // BaseResponse.fromJson(Map<String, dynamic> map) {
  //   paging = AppPaginationModel.fromJson(map);
  //       debugPrint(" ****** map $paging ");

  // }
}
