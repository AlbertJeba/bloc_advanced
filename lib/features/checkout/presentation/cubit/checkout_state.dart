part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final CheckoutSummaryData? summary;
  final String paymentMethod;
  final String deliveryInstructions;
  final bool isLoading;
  final bool isPlacingOrder;
  final bool isAddingAddress;
  final OrderData? placedOrder;
  final String errorMessage;
  final bool orderSuccess;

  const CheckoutState({
    this.addresses = const [],
    this.selectedAddress,
    this.summary,
    this.paymentMethod = 'COD',
    this.deliveryInstructions = '',
    this.isLoading = false,
    this.isPlacingOrder = false,
    this.isAddingAddress = false,
    this.placedOrder,
    this.errorMessage = '',
    this.orderSuccess = false,
  });

  CheckoutState copyWith({
    List<AddressModel>? addresses,
    AddressModel? selectedAddress,
    CheckoutSummaryData? summary,
    String? paymentMethod,
    String? deliveryInstructions,
    bool? isLoading,
    bool? isPlacingOrder,
    bool? isAddingAddress,
    OrderData? placedOrder,
    String? errorMessage,
    bool? orderSuccess,
  }) {
    return CheckoutState(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      summary: summary ?? this.summary,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      isLoading: isLoading ?? this.isLoading,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      isAddingAddress: isAddingAddress ?? this.isAddingAddress,
      placedOrder: placedOrder ?? this.placedOrder,
      errorMessage: errorMessage ?? this.errorMessage,
      orderSuccess: orderSuccess ?? this.orderSuccess,
    );
  }

  @override
  List<Object?> get props => [
    addresses,
    selectedAddress,
    summary,
    paymentMethod,
    deliveryInstructions,
    isLoading,
    isPlacingOrder,
    isAddingAddress,
    placedOrder,
    errorMessage,
    orderSuccess,
  ];
}
