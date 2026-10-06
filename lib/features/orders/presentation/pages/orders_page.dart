import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/orders/data/models/order_list_response.dart';
import 'package:bloc_advanced/features/orders/domain/use_case/order_use_case.dart';
import 'package:bloc_advanced/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = OrderCubit(injector<OrderUseCase>())..fetchOrders();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderCubit,
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
            AppStrings.myOrders,
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CustomLoader());
            }

            if (state.errorMessage.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.standard_24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage,
                        style: AppTextStyles.openSansRegular14.copyWith(
                          color: AppColors.colorRed,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimens.standard_16),
                      PrimaryButton(
                        text: AppStrings.retry,
                        onPressed: () => _orderCubit.fetchOrders(),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.orders.isEmpty) {
              return _buildEmptyOrders(context);
            }

            return RefreshIndicator(
              color: AppColors.colorGreen,
              onRefresh: () => _orderCubit.fetchOrders(),
              child: ListView.separated(
                padding: const EdgeInsets.all(Dimens.standard_16),
                itemCount: state.orders.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: Dimens.standard_12),
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return _buildOrderCard(context, order);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standard_32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Dimens.standard_90,
              height: Dimens.standard_90,
              decoration: BoxDecoration(
                color: AppColors.colorGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: Dimens.standard_48,
                color: AppColors.colorGreen,
              ),
            ),
            const SizedBox(height: Dimens.standard_24),
            Text(
              AppStrings.noOrdersYet,
              style: AppTextStyles.openSansBold18.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.standard_8),
            Text(
              AppStrings.noOrdersSubtitle,
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.standard_24),
            PrimaryButton(
              text: AppStrings.startShopping,
              onPressed: () => context.go(RoutesName.homePage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderSummaryItem order) {
    final orderId = order.orderId?.isNotEmpty == true
        ? order.orderId!
        : (order.id ?? '');
    final statusColor = _getStatusColor(order.status ?? '');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withValues(alpha: 0.03),
            blurRadius: Dimens.standard_8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(Dimens.standard_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  order.orderNumber ?? 'Order #$orderId',
                  style: AppTextStyles.openSansBold14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.standard_8,
                  vertical: Dimens.standard_4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Dimens.standard_6),
                ),
                child: Text(
                  order.status ?? 'PLACED',
                  style: AppTextStyles.openSansBold12.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_12),
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: Dimens.standard_16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: Dimens.standard_6),
              Text(
                '${order.itemCount ?? 0} ${AppStrings.items}',
                style: AppTextStyles.openSansRegular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                '₹${order.totalPayable ?? order.grandTotal ?? 0}',
                style: AppTextStyles.openSansBold16.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_8),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: Dimens.standard_16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: Dimens.standard_6),
              Expanded(
                child: Text(
                  order.estimatedDeliveryTime?.isNotEmpty == true
                      ? order.estimatedDeliveryTime!
                      : 'Delivery in 15-20 mins',
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Text(
                order.paymentMethod ?? 'COD',
                style: AppTextStyles.openSansRegular12.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const Divider(
            height: Dimens.standard_20,
            color: AppColors.dividerColor,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.colorGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.standard_10,
                ),
              ),
              onPressed: () {
                context.push(RoutesName.orderDetail, extra: orderId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.trackOrder,
                    style: AppTextStyles.openSansBold14.copyWith(
                      color: AppColors.colorGreen,
                    ),
                  ),
                  const SizedBox(width: Dimens.standard_6),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: Dimens.standard_12,
                    color: AppColors.colorGreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'DELIVERED':
        return AppColors.colorGreen;
      case 'CANCELLED':
        return AppColors.colorRed;
      case 'OUT_FOR_DELIVERY':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF2563EB);
    }
  }
}
