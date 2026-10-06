import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/features/checkout/data/models/order_response.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessPage extends StatelessWidget {
  final OrderData? order;

  const OrderSuccessPage({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final orderNum = order?.orderNumber ?? 'ORD-SUCCESS';
    final total = order?.totalPayable ?? 0;
    final deliveryTime = order?.estimatedDeliveryTime ?? '15-20 mins';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go(RoutesName.homePage);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surfaceColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.standard_24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: Dimens.standard_90,
                  height: Dimens.standard_90,
                  decoration: BoxDecoration(
                    color: AppColors.colorGreen.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: Dimens.standard_60,
                    color: AppColors.colorGreen,
                  ),
                ),
                const SizedBox(height: Dimens.standard_24),
                Text(
                  AppStrings.orderSuccessTitle,
                  style: AppTextStyles.openSansBold20.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimens.standard_8),
                Text(
                  AppStrings.orderSuccessSubtitle,
                  style: AppTextStyles.openSansRegular14.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimens.standard_24),

                // Order details box
                Container(
                  padding: const EdgeInsets.all(Dimens.standard_16),
                  decoration: BoxDecoration(
                    color: AppColors.appBackGround,
                    borderRadius: BorderRadius.circular(Dimens.standard_12),
                    border: Border.all(color: AppColors.dividerColor),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        AppStrings.orderNumber,
                        orderNum,
                        isBold: true,
                      ),
                      const Divider(
                        height: Dimens.standard_20,
                        color: AppColors.dividerColor,
                      ),
                      _buildDetailRow(
                        AppStrings.estimatedDelivery,
                        deliveryTime,
                        valueColor: AppColors.colorGreen,
                      ),
                      const SizedBox(height: Dimens.standard_8),
                      _buildDetailRow(
                        AppStrings.totalPaid,
                        '₹$total',
                        isBold: true,
                      ),
                      const SizedBox(height: Dimens.standard_8),
                      _buildDetailRow(
                        AppStrings.paymentMode,
                        order?.paymentMethod ?? 'COD',
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Done button
                PrimaryButton(
                  text: AppStrings.backToHome,
                  onPressed: () => context.go(RoutesName.homePage),
                ),
                const SizedBox(height: Dimens.standard_16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
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
          style: AppTextStyles.openSansRegular14.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: isBold
              ? AppTextStyles.openSansBold14.copyWith(
                  color: valueColor ?? AppColors.textPrimary,
                )
              : AppTextStyles.openSansRegular14.copyWith(
                  color: valueColor ?? AppColors.textPrimary,
                ),
        ),
      ],
    );
  }
}
