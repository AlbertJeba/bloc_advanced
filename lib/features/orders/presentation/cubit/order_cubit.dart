import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/data/models/order_request.dart';
import 'package:bloc_advanced/features/orders/domain/use_case/order_use_case.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderUseCase orderUseCase;

  OrderCubit(this.orderUseCase) : super(const OrderState());

  Future<void> fetchOrders({OrderRequest? request}) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final result = await orderUseCase.getOrders(request: request);

    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (response) {
        final items = response.data?.items ?? [];
        emit(state.copyWith(isLoading: false, orders: items));
      },
    );
  }

  Future<void> fetchOrderDetail(OrderDetailRequest request) async {
    emit(
      state.copyWith(
        isLoadingDetail: true,
        detailErrorMessage: '',
        selectedOrderDetail: null,
      ),
    );

    final result = await orderUseCase.getOrderDetail(request);

    result.fold(
      (error) => emit(
        state.copyWith(
          isLoadingDetail: false,
          detailErrorMessage: error.message,
        ),
      ),
      (response) {
        emit(
          state.copyWith(
            isLoadingDetail: false,
            selectedOrderDetail: response.data,
          ),
        );
      },
    );
  }
}
