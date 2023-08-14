// ignore_for_file: prefer_final_fields

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../resources/data_state.dart';
import '../../resources/pagination_api_model.dart';
import '../../use-case/main_use_cases.dart';

part 'pagination_bloc_state.dart';

class PaginationBloc<PaginateApiUseCase extends MainPaginateListUseCase, Entity>
    extends Cubit<PaginationBlocState> {
  PaginateApiUseCase useCase;

  PaginationApiModel pagination = PaginationApiModel();
  List<Entity> items = [];
  RefreshController? _refreshController;

  RefreshController? get refreshController => _refreshController;

  static PaginationBloc get(context) =>
      BlocProvider.of<PaginationBloc>(context);
  PaginationBloc(this.useCase, [this._refreshController])
      : super(PaginationBlocInitial());

  @override
  Future<void> close() {
    _refreshController?.dispose();
    return super.close();
  }

  bool get canRefresh => pagination.hasPrevious == true;

  bool get canFetchDataMore => pagination.hasNext == true;

  _restData() {
    pagination.page = 1;
    pagination.hasPrevious = false;
    items.clear();
  }

  beReadyForSearch({required bool Function() getReadyForSearch}) async {
    // for can load Again from page one
    pagination.hasPrevious = true;
    if (getReadyForSearch()) {
      await onRefreshData();
    }
  }

  onRefreshData() async {
    if (!canRefresh) {
      _refreshController?.refreshCompleted();
    } else {
      emit(PaginationLoading());
      _restData();
      await _handelRes(
        onSusses: () {
          _refreshController?.refreshCompleted();

          emit(PaginationLoaded<Entity>(items));
        },
        onError: (error) {
          _refreshController?.refreshFailed();
          emit(PaginationError(
              error ?? AppGlobalConstants.notFoundDataDefaultMsg));
        },
        onNoMoreData: () {
          _refreshController?.loadNoData();
          emit(PaginationNoMoreData(items));
        },
        onEmptyResList: () {
          emit(PaginationNoDataFoundState());
        },
      );
    }
  }

  fetchData() async {
    if (!canFetchDataMore) {
      _refreshController?.loadNoData();
      emit(PaginationNoMoreData(items));
    } else {
      // emit(PaginationLoading());

      pagination.page = pagination.page! + 1;

      await _handelRes(
        onSusses: () {
          _refreshController?.loadComplete();
          emit(PaginationLoaded<Entity>(items));
        },
        onError: (error) {
          _refreshController?.loadFailed();
          emit(PaginationError(
              error ?? AppGlobalConstants.notFoundDataDefaultMsg));
        },
        onNoMoreData: () {
          _refreshController?.loadNoData();
          emit(PaginationNoMoreData(items));
        },
        onEmptyResList: () {
          // TODO:  show toast here no data found
        },
      );
    }
  }

  _handelRes({
    Function()? onSusses,
    Function(String? error)? onError,
    Function()? onNoMoreData,
    Function()? onEmptyResList,
  }) async {
    useCase.req = useCase.req?.copyWith(pagination.page);
    var res = await useCase.call(parm: useCase.req);
    final isReturnData = res.data != null;
    if (!isReturnData) {
      onError?.call(res.error?.message);
    } else {
      _handelSucsesCase(
        res,
        onNoMoreData: () => onNoMoreData?.call(),
        onSusses: () => onSusses?.call(),
        onEmptyResList: () => onEmptyResList?.call(),
      );
      onSusses?.call();
    }
  }

  _handelSucsesCase(
    DataState<(PaginationApiModel, List<dynamic>)> res, {
    Function()? onNoMoreData,
    Function()? onSusses,
    Function()? onEmptyResList,
  }) {
    pagination = res.data!.$1;
    var resList = res.data?.$2;

    resList = resList?.cast<Entity>() ?? <Entity>[];

    if (resList.isEmpty) {
      onEmptyResList?.call();
      return;
    }

    if (items.isNotEmpty) {
      items = items + (resList as List<Entity>);
    } else {
      items = (resList as List<Entity>);
    }
    if (pagination.hasNext == false) {
      onNoMoreData?.call();
      return;
    }
    onSusses?.call();
  }

  void get showEmptyScreen => _showEmptyScreen();
  _showEmptyScreen() {
    emit(PaginationBlocInitial());
  }

  void get showLoadingScreen => _showLoadingScreen();
  _showLoadingScreen() {
    emit(PaginationLoading());
  }
}
