import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/features/checkout/data/models/address_model.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/checkout_summary_response.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_address_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_order_request.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';
import 'package:bloc_advanced/features/checkout/domain/use_case/checkout_use_case.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUseCase _checkoutUseCase;

  CheckoutCubit(this._checkoutUseCase) : super(const CheckoutState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final addressResult = await _checkoutUseCase.getAddresses();

    addressResult.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (addressResponse) async {
        final addresses = addressResponse.data?.items ?? [];
        final defaultAddress =
            addresses.where((a) => a.isDefault == true).firstOrNull ??
            addresses.firstOrNull;

        emit(
          state.copyWith(addresses: addresses, selectedAddress: defaultAddress),
        );

        if (defaultAddress != null && defaultAddress.id != null) {
          await _fetchSummary(defaultAddress.id!);
        } else {
          emit(state.copyWith(isLoading: false));
        }
      },
    );
  }

  Future<void> selectAddress(AddressModel address) async {
    if (state.selectedAddress?.id == address.id) return;
    emit(state.copyWith(selectedAddress: address, isLoading: true));
    if (address.id != null) {
      await _fetchSummary(address.id!);
    }
  }

  Future<void> _fetchSummary(String addressId) async {
    final result = await _checkoutUseCase.getCheckoutSummary(
      CheckoutSummaryRequest(addressId: addressId),
    );

    result.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, errorMessage: error.message)),
      (summaryResponse) {
        emit(state.copyWith(isLoading: false, summary: summaryResponse.data));
      },
    );
  }

  void selectPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: method));
  }

  void updateDeliveryInstructions(String text) {
    emit(state.copyWith(deliveryInstructions: text));
  }

  Future<void> addNewAddress(CreateAddressRequest request) async {
    emit(state.copyWith(isAddingAddress: true, errorMessage: ''));

    final result = await _checkoutUseCase.createAddress(request);

    result.fold(
      (error) => emit(
        state.copyWith(isAddingAddress: false, errorMessage: error.message),
      ),
      (response) async {
        final addresses = response.data?.items ?? [];
        final newAddress = addresses.lastOrNull ?? addresses.firstOrNull;

        emit(
          state.copyWith(
            isAddingAddress: false,
            addresses: addresses,
            selectedAddress: newAddress,
          ),
        );

        if (newAddress != null && newAddress.id != null) {
          await _fetchSummary(newAddress.id!);
        }
      },
    );
  }

  Future<void> placeOrder() async {
    if (state.selectedAddress == null || state.selectedAddress?.id == null) {
      emit(state.copyWith(errorMessage: 'Please select a delivery address'));
      return;
    }

    emit(state.copyWith(isPlacingOrder: true, errorMessage: ''));

    final request = CreateOrderRequest(
      addressId: state.selectedAddress!.id,
      paymentMethod: state.paymentMethod,
      deliveryInstructions: state.deliveryInstructions,
    );

    final result = await _checkoutUseCase.placeOrder(request);

    result.fold(
      (error) => emit(
        state.copyWith(isPlacingOrder: false, errorMessage: error.message),
      ),
      (orderResponse) {
        emit(
          state.copyWith(
            isPlacingOrder: false,
            orderSuccess: true,
            placedOrder: orderResponse.data,
          ),
        );
      },
    );
  }
}
