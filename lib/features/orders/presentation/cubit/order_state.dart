part of 'order_cubit.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final List<OrderSummaryItem> orders;
  final bool isLoadingDetail;
  final String detailErrorMessage;
  final OrderDetailData? selectedOrderDetail;

  const OrderState({
    this.isLoading = false,
    this.errorMessage = '',
    this.orders = const [],
    this.isLoadingDetail = false,
    this.detailErrorMessage = '',
    this.selectedOrderDetail,
  });

  OrderState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<OrderSummaryItem>? orders,
    bool? isLoadingDetail,
    String? detailErrorMessage,
    OrderDetailData? selectedOrderDetail,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      orders: orders ?? this.orders,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      detailErrorMessage: detailErrorMessage ?? this.detailErrorMessage,
      selectedOrderDetail: selectedOrderDetail ?? this.selectedOrderDetail,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    orders,
    isLoadingDetail,
    detailErrorMessage,
    selectedOrderDetail,
  ];
}
