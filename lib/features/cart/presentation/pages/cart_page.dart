import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/cart/data/models/cart_response.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';
import 'package:bloc_advanced/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = CartCubit(injector<CartUseCase>())..fetchCart();
  }

  @override
  void dispose() {
    _cartCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cartCubit,
      child: Scaffold(
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
            AppStrings.myCart,
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final hasItems = (state.cartData?.items?.isNotEmpty ?? false);
                if (!hasItems) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.colorRed,
                  ),
                  tooltip: AppStrings.clearCart,
                  onPressed: () => _showClearCartDialog(context),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CustomLoader());
            }

            final cartData = state.cartData;
            final items = cartData?.items ?? [];

            if (items.isEmpty) {
              return _buildEmptyCart(context);
            }

            return Column(
              children: [
                // Delivery guarantee banner
                Container(
                  color: AppColors.colorGreen.withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.standard_16,
                    vertical: Dimens.standard_10,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.bolt,
                        color: AppColors.colorGreen,
                        size: Dimens.standard_20,
                      ),
                      const SizedBox(width: Dimens.standard_8),
                      Text(
                        AppStrings.deliveryInMins,
                        style: AppTextStyles.openSansBold12.copyWith(
                          color: AppColors.colorGreen,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(Dimens.standard_16),
                    children: [
                      // Cart Items Card
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(
                            Dimens.standard_12,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: Dimens.standard_1,
                            indent: Dimens.standard_16,
                            endIndent: Dimens.standard_16,
                            color: AppColors.dividerColor,
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return _buildCartItemTile(item, state);
                          },
                        ),
                      ),

                      const SizedBox(height: Dimens.standard_16),

                      // Bill Details Card
                      _buildBillDetails(cartData!),
                      const SizedBox(height: Dimens.standard_24),
                    ],
                  ),
                ),

                // Bottom Checkout Bar
                _buildBottomCheckoutBar(context, cartData),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItemTile(CartItemModel item, CartState state) {
    final isUpdating = state.updatingProductId == item.productId;

    return Padding(
      padding: const EdgeInsets.all(Dimens.standard_16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.standard_8),
            child: CustomNetworkImage(
              imageUrl: item.imageUrl ?? '',
              width: Dimens.standard_56,
              height: Dimens.standard_56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Dimens.standard_12),

          // Name & Pack size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName ?? '',
                  style: AppTextStyles.openSansBold14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimens.standard_4),
                Text(
                  item.packSize ?? '',
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: Dimens.standard_6),
                Row(
                  children: [
                    Text(
                      '₹${item.unitPrice ?? 0}',
                      style: AppTextStyles.openSansBold14.copyWith(
                        color: AppColors.colorGreen,
                      ),
                    ),
                    if (item.mrp != null &&
                        item.unitPrice != null &&
                        item.mrp! > item.unitPrice!) ...[
                      const SizedBox(width: Dimens.standard_6),
                      Text(
                        '₹${item.mrp}',
                        style: AppTextStyles.openSansRegular12.copyWith(
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Stepper Quantity Control
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorLightGrey),
              borderRadius: BorderRadius.circular(Dimens.standard_8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: Dimens.standard_16),
                  onPressed: isUpdating
                      ? null
                      : () {
                          final currentQty = item.quantity ?? 1;
                          _cartCubit.updateQuantity(
                            item.productId ?? '',
                            currentQty - 1,
                          );
                        },
                ),
                if (isUpdating)
                  const SizedBox(
                    width: Dimens.standard_16,
                    height: Dimens.standard_16,
                    child: CustomLoader(
                      size: Dimens.standard_16,
                      strokeWidth: Dimens.standard_2,
                      isCentered: false,
                    ),
                  )
                else
                  Text(
                    '${item.quantity ?? 1}',
                    style: AppTextStyles.openSansBold14,
                  ),
                IconButton(
                  icon: const Icon(Icons.add, size: Dimens.standard_16),
                  onPressed: isUpdating
                      ? null
                      : () {
                          final currentQty = item.quantity ?? 1;
                          _cartCubit.updateQuantity(
                            item.productId ?? '',
                            currentQty + 1,
                          );
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetails(CartData cart) {
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
            AppStrings.billDetails,
            style: AppTextStyles.openSansBold16.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Dimens.standard_12),
          _buildBillRow(AppStrings.itemTotal, '₹${cart.subtotal ?? 0}'),
          const SizedBox(height: Dimens.standard_8),
          _buildBillRow(
            AppStrings.deliveryFee,
            (cart.deliveryFee == 0)
                ? AppStrings.free
                : '₹${cart.deliveryFee ?? 0}',
            valueColor: (cart.deliveryFee == 0)
                ? AppColors.colorGreen
                : AppColors.textPrimary,
          ),
          if (cart.savings != null && cart.savings! > 0) ...[
            const SizedBox(height: Dimens.standard_8),
            _buildBillRow(
              AppStrings.totalSavings,
              '- ₹${cart.savings}',
              valueColor: AppColors.colorGreen,
            ),
          ],
          const Divider(
            height: Dimens.standard_24,
            color: AppColors.dividerColor,
          ),
          _buildBillRow(
            AppStrings.toPay,
            '₹${cart.grandTotal ?? 0}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
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

  Widget _buildBottomCheckoutBar(BuildContext context, CartData cart) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.standard_16,
        vertical: Dimens.standard_12,
      ),
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
                  AppStrings.total,
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '₹${cart.grandTotal ?? 0}',
                  style: AppTextStyles.openSansBold20.copyWith(
                    color: AppColors.colorGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(width: Dimens.standard_24),
            Expanded(
              child: PrimaryButton(
                text: AppStrings.proceedToPay,
                suffixIcon: const Icon(
                  Icons.arrow_forward,
                  size: Dimens.standard_18,
                  color: AppColors.colorWhite,
                ),
                onPressed: () => context.push(RoutesName.checkout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standard_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.remove_shopping_cart_outlined,
              size: Dimens.standard_80,
              color: AppColors.colorLightGrey,
            ),
            const SizedBox(height: Dimens.standard_16),
            Text(
              AppStrings.yourCartEmpty,
              style: AppTextStyles.openSansBold20.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: Dimens.standard_8),
            Text(
              AppStrings.cartEmptySubtitle,
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.standard_24),
            PrimaryButton(
              text: AppStrings.startShopping,
              width: Dimens.standard_180,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(AppStrings.clearCart, style: AppTextStyles.openSansBold16),
        content: Text(
          AppStrings.clearCartConfirm,
          style: AppTextStyles.openSansRegular14,
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
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              _cartCubit.clearCart();
            },
            child: Text(
              AppStrings.clear,
              style: AppTextStyles.openSansBold14.copyWith(
                color: AppColors.colorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
