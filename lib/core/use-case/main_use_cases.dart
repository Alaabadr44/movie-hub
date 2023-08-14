import '../../injection_container.dart';
import '../blocs/app-network-manger-cubit/app_network_manger_bloc.dart';
import '../resources/data_state.dart';
import '../resources/main_req_entity.dart';
import '../resources/pagination_api_model.dart';

abstract class MainUseCase<T, P> {
  Future<T> call({P params});
}

// main_paginate_list_use_case
abstract class MainPaginateListUseCase<E, P extends MainRequestEntity?> {
  P? req;

  MainPaginateListUseCase(this.req);
  Future<DataState<(PaginationApiModel, List<E>)>> call({P? parm});
}

abstract class NetWorkPaginateListUseCase<E, P extends MainRequestEntity?>
    implements MainPaginateListUseCase<E, P> {
  @override
  P? req;

  @override
  Future<DataState<(PaginationApiModel, List<E>)>> call({P? parm}) {
    if (sl<AppNetworkMangerCubit>().isConnected == true) {
      return call(parm: parm);
    } else {
      return Future.value(const DataFailedErrorMsg("No Internet"));
    }
  }
}
