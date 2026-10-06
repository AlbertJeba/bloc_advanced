import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/checkout/data/models/create_address_request.dart';
import 'package:bloc_advanced/features/checkout/domain/use_case/checkout_use_case.dart';
import 'package:bloc_advanced/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CheckoutCubit _checkoutCubit;
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkoutCubit = CheckoutCubit(injector<CheckoutUseCase>())..init();
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    _checkoutCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _checkoutCubit,
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.colorRed,
              ),
            );
          }
          if (state.orderSuccess && state.placedOrder != null) {
            context.go(RoutesName.orderSuccess, extra: state.placedOrder);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.appBackGround,
            appBar: AppBar(
              backgroundColor: AppColors.surfaceColor,
              elevation: Dimens.standard_0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary,
                  size: Dimens.standard_20,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                AppStrings.checkout,
                style: AppTextStyles.openSansBold18.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            body: state.isLoading
                ? const Center(child: CustomLoader())
                : ListView(
                    padding: const EdgeInsets.all(Dimens.standard_16),
                    children: [
                      // Delivery Address Section
                      _buildAddressSection(context, state),
                      const SizedBox(height: Dimens.standard_16),

                      // Delivery Instructions
                      _buildInstructionsSection(context),
                      const SizedBox(height: Dimens.standard_16),

                      // Payment Method Section
                      _buildPaymentSection(state),
                      const SizedBox(height: Dimens.standard_16),

                      // Bill Summary
                      if (state.summary != null) ...[
                        _buildBillSummary(state),
                        const SizedBox(height: Dimens.standard_24),
                      ],
                    ],
                  ),
            bottomNavigationBar: _buildBottomBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context, CheckoutState state) {
    final selected = state.selectedAddress;

    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.colorGreen,
                    size: Dimens.standard_20,
                  ),
                  const SizedBox(width: Dimens.standard_8),
                  Text(
                    AppStrings.deliveryAddress,
                    style: AppTextStyles.openSansBold16.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => _showAddressPicker(context, state),
                child: Text(
                  selected == null ? AppStrings.addAddress : AppStrings.change,
                  style: AppTextStyles.openSansBold14.copyWith(
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_8),
          if (selected != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.standard_8,
                vertical: Dimens.standard_4,
              ),
              decoration: BoxDecoration(
                color: AppColors.colorGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimens.standard_4),
              ),
              child: Text(
                (selected.type ?? AppStrings.home).toUpperCase(),
                style: AppTextStyles.openSansBold12.copyWith(
                  color: AppColors.colorGreen,
                ),
              ),
            ),
            const SizedBox(height: Dimens.standard_8),
            Text(
              '${selected.addressLine1 ?? ''}, ${selected.addressLine2 ?? ''}',
              style: AppTextStyles.openSansBold14.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            if (selected.landmark != null && selected.landmark!.isNotEmpty)
              Text(
                '${AppStrings.landmark}: ${selected.landmark}',
                style: AppTextStyles.openSansRegular12.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            Text(
              '${selected.city ?? ''}, ${selected.state ?? ''} - ${selected.pincode ?? ''}',
              style: AppTextStyles.openSansRegular12.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (selected.phone != null && selected.phone!.isNotEmpty)
              Text(
                '${AppStrings.phone}: ${selected.phone}',
                style: AppTextStyles.openSansRegular12.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
          ] else ...[
            Text(
              AppStrings.noDeliveryAddressSaved,
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstructionsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_note,
                color: AppColors.textPrimary,
                size: Dimens.standard_20,
              ),
              const SizedBox(width: Dimens.standard_8),
              Text(
                AppStrings.deliveryInstructions,
                style: AppTextStyles.openSansBold16.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_12),
          TextField(
            controller: _instructionsController,
            onChanged: (val) => _checkoutCubit.updateDeliveryInstructions(val),
            decoration: InputDecoration(
              hintText: AppStrings.instructionsHint,
              hintStyle: AppTextStyles.openSansRegular12.copyWith(
                color: AppColors.textSecondary,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimens.standard_12,
                vertical: Dimens.standard_10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimens.standard_8),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(CheckoutState state) {
    final options = [
      {
        'key': 'COD',
        'title': AppStrings.cashOnDelivery,
        'subtitle': AppStrings.cashOnDeliverySub,
      },
      {
        'key': 'UPI',
        'title': AppStrings.upiInstant,
        'subtitle': AppStrings.upiInstantSub,
      },
      {
        'key': 'CARD',
        'title': AppStrings.cardPayment,
        'subtitle': AppStrings.cardPaymentSub,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.payment,
                color: AppColors.textPrimary,
                size: Dimens.standard_20,
              ),
              const SizedBox(width: Dimens.standard_8),
              Text(
                AppStrings.paymentMethod,
                style: AppTextStyles.openSansBold16.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_12),
          ...options.map((opt) {
            final isSelected = state.paymentMethod == opt['key'];
            return InkWell(
              onTap: () => _checkoutCubit.selectPaymentMethod(opt['key']!),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.standard_8,
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected
                          ? AppColors.colorGreen
                          : AppColors.colorGrey,
                      size: Dimens.standard_20,
                    ),
                    const SizedBox(width: Dimens.standard_12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt['title']!,
                            style: AppTextStyles.openSansBold14.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            opt['subtitle']!,
                            style: AppTextStyles.openSansRegular12.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBillSummary(CheckoutState state) {
    final summary = state.summary!;

    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.billSummary,
            style: AppTextStyles.openSansBold16.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Dimens.standard_12),
          _buildRow(
            '${AppStrings.itemTotal} (${summary.itemCount ?? 0})',
            '₹${summary.subtotal ?? 0}',
          ),
          const SizedBox(height: Dimens.standard_8),
          _buildRow(
            AppStrings.deliveryFee,
            (summary.deliveryFee == null || summary.deliveryFee == 0)
                ? AppStrings.free
                : '₹${summary.deliveryFee}',
            valueColor:
                (summary.deliveryFee == null || summary.deliveryFee == 0)
                ? AppColors.colorGreen
                : null,
          ),
          if (summary.discount != null && summary.discount! > 0) ...[
            const SizedBox(height: Dimens.standard_8),
            _buildRow(
              AppStrings.totalSavings,
              '- ₹${summary.discount}',
              valueColor: AppColors.colorGreen,
            ),
          ],
          const SizedBox(height: Dimens.standard_8),
          _buildRow(AppStrings.taxesCharges, '₹${summary.taxes ?? 0}'),
          const Divider(
            height: Dimens.standard_24,
            color: AppColors.dividerColor,
          ),
          _buildRow(
            AppStrings.toPay,
            '₹${summary.grandTotal ?? 0}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTextStyles.openSansBold14
              : AppTextStyles.openSansRegular14.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
        Text(
          value,
          style: isBold
              ? AppTextStyles.openSansBold16.copyWith(
                  color: valueColor ?? AppColors.textPrimary,
                )
              : AppTextStyles.openSansBold14.copyWith(
                  color: valueColor ?? AppColors.textPrimary,
                ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, CheckoutState state) {
    final total = state.summary?.grandTotal ?? 0;

    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withValues(alpha: 0.08),
            blurRadius: Dimens.standard_10,
            offset: const Offset(Dimens.standard_0, -Dimens.standard_4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.totalToPay,
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '₹$total',
                  style: AppTextStyles.openSansBold20.copyWith(
                    color: AppColors.colorGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(width: Dimens.standard_24),
            Expanded(
              child: PrimaryButton(
                text: AppStrings.placeOrder,
                isLoading: state.isPlacingOrder,
                suffixIcon: const Icon(
                  Icons.arrow_forward,
                  size: Dimens.standard_18,
                  color: AppColors.colorWhite,
                ),
                onPressed: state.isPlacingOrder
                    ? null
                    : () => _checkoutCubit.placeOrder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressPicker(BuildContext context, CheckoutState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.standard_16),
        ),
      ),
      builder: (bottomSheetContext) {
        return Container(
          padding: const EdgeInsets.all(Dimens.standard_16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(bottomSheetContext).size.height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.selectDeliveryAddress,
                    style: AppTextStyles.openSansBold16.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: () => Navigator.of(bottomSheetContext).pop(),
                  ),
                ],
              ),
              const Divider(color: AppColors.dividerColor),
              Expanded(
                child: ListView.separated(
                  itemCount: state.addresses.length,
                  separatorBuilder: (_, _) =>
                      const Divider(color: AppColors.dividerColor),
                  itemBuilder: (_, index) {
                    final addr = state.addresses[index];
                    final isSelected = state.selectedAddress?.id == addr.id;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppColors.colorGreen
                            : AppColors.colorGrey,
                      ),
                      title: Text(
                        '${addr.type?.toUpperCase() ?? AppStrings.home.toUpperCase()} - ${addr.addressLine1 ?? ''}',
                        style: AppTextStyles.openSansBold14,
                      ),
                      subtitle: Text(
                        '${addr.city ?? ''}, ${addr.state ?? ''} - ${addr.pincode ?? ''}',
                        style: AppTextStyles.openSansRegular12,
                      ),
                      onTap: () {
                        _checkoutCubit.selectAddress(addr);
                        Navigator.of(bottomSheetContext).pop();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: Dimens.standard_12),
              PrimaryButton(
                text: AppStrings.addNewAddress,
                isOutlined: true,
                prefixIcon: const Icon(
                  Icons.add,
                  color: AppColors.colorGreen,
                  size: Dimens.standard_18,
                ),
                onPressed: () {
                  Navigator.of(bottomSheetContext).pop();
                  _showAddAddressDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    final line1Ctrl = TextEditingController();
    final line2Ctrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final pinCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    String addressType = 'Home';

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.surfaceColor,
          title: Text(
            AppStrings.newAddress,
            style: AppTextStyles.openSansBold16,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: addressType,
                  items: [
                    DropdownMenuItem(
                      value: 'Home',
                      child: Text(AppStrings.home),
                    ),
                    DropdownMenuItem(
                      value: 'Work',
                      child: Text(AppStrings.work),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text(AppStrings.other),
                    ),
                  ],
                  onChanged: (v) =>
                      setDialogState(() => addressType = v ?? 'Home'),
                  decoration: InputDecoration(labelText: AppStrings.type),
                ),
                TextField(
                  controller: line1Ctrl,
                  decoration: InputDecoration(
                    labelText: AppStrings.houseStreet,
                  ),
                ),
                TextField(
                  controller: line2Ctrl,
                  decoration: InputDecoration(labelText: AppStrings.areaColony),
                ),
                TextField(
                  controller: cityCtrl,
                  decoration: InputDecoration(labelText: AppStrings.city),
                ),
                TextField(
                  controller: stateCtrl,
                  decoration: InputDecoration(labelText: AppStrings.state),
                ),
                TextField(
                  controller: pinCtrl,
                  decoration: InputDecoration(labelText: AppStrings.pinCode),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: phoneCtrl,
                  decoration: InputDecoration(
                    labelText: AppStrings.phoneNumber,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.openSansRegular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            PrimaryButton(
              width: Dimens.standard_140,
              height: Dimens.standard_40,
              borderRadius: Dimens.standard_8,
              text: AppStrings.saveAddress,
              textStyle: AppTextStyles.openSansBold14,
              onPressed: () {
                if (line1Ctrl.text.trim().isEmpty ||
                    pinCtrl.text.trim().isEmpty) {
                  return;
                }
                Navigator.of(dialogCtx).pop();
                _checkoutCubit.addNewAddress(
                  CreateAddressRequest(
                    type: addressType,
                    addressLine1: line1Ctrl.text.trim(),
                    addressLine2: line2Ctrl.text.trim(),
                    city: cityCtrl.text.trim(),
                    state: stateCtrl.text.trim(),
                    pincode: pinCtrl.text.trim(),
                    phone: phoneCtrl.text.trim(),
                    isDefault: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
