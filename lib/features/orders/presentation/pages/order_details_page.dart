import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_request.dart';
import 'package:bloc_advanced/features/orders/data/models/order_detail_response.dart';
import 'package:bloc_advanced/features/orders/domain/use_case/order_use_case.dart';
import 'package:bloc_advanced/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = OrderCubit(injector<OrderUseCase>())
      ..fetchOrderDetail(OrderDetailRequest(orderId: widget.orderId));
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
            AppStrings.trackOrder,
            style: AppTextStyles.openSansBold18.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state.isLoadingDetail) {
              return const Center(child: CustomLoader());
            }

            if (state.detailErrorMessage.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.standard_24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.detailErrorMessage,
                        style: AppTextStyles.openSansRegular14.copyWith(
                          color: AppColors.colorRed,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimens.standard_16),
                      PrimaryButton(
                        text: AppStrings.retry,
                        onPressed: () =>
                            _orderCubit.fetchOrderDetail(OrderDetailRequest(orderId: widget.orderId)),
                      ),
                    ],
                  ),
                ),
              );
            }

            final order = state.selectedOrderDetail;
            if (order == null) {
              return const SizedBox.shrink();
            }

            return ListView(
              padding: const EdgeInsets.all(Dimens.standard_16),
              children: [
                // Order Header Card
                _buildHeaderCard(order),
                const SizedBox(height: Dimens.standard_16),

                // Order Timeline
                if (order.timeline != null && order.timeline!.isNotEmpty) ...[
                  _buildTimelineCard(order.timeline!),
                  const SizedBox(height: Dimens.standard_16),
                ],

                // Driver Info
                if (order.driver != null &&
                    order.driver?.name?.isNotEmpty == true) ...[
                  _buildDriverCard(order.driver!),
                  const SizedBox(height: Dimens.standard_16),
                ],

                // Items list
                if (order.items != null && order.items!.isNotEmpty) ...[
                  _buildItemsCard(order.items!),
                  const SizedBox(height: Dimens.standard_16),
                ],

                // Delivery Address
                if (order.address != null) ...[
                  _buildAddressCard(order.address!),
                  const SizedBox(height: Dimens.standard_16),
                ],

                // Bill Breakdown
                _buildBillCard(order),
                const SizedBox(height: Dimens.standard_24),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard(OrderDetailData order) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  order.orderNumber ?? 'Order #${widget.orderId}',
                  style: AppTextStyles.openSansBold16.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.standard_10,
                  vertical: Dimens.standard_4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.colorGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Dimens.standard_6),
                ),
                child: Text(
                  order.status ?? 'PLACED',
                  style: AppTextStyles.openSansBold12.copyWith(
                    color: AppColors.colorGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.standard_8),
          Text(
            order.estimatedDeliveryTime?.isNotEmpty == true
                ? '${AppStrings.estimatedDelivery}: ${order.estimatedDeliveryTime}'
                : '${AppStrings.estimatedDelivery}: 15-20 mins',
            style: AppTextStyles.openSansRegular14.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(List<OrderTimelineItem> timeline) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.orderTimeline,
            style: AppTextStyles.openSansBold16.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Dimens.standard_16),
          ...List.generate(timeline.length, (index) {
            final item = timeline[index];
            final isDone = item.completed == true;
            final isLast = index == timeline.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: Dimens.standard_24,
                      height: Dimens.standard_24,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.colorGreen
                            : AppColors.cardBackground,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDone
                              ? AppColors.colorGreen
                              : AppColors.dividerColor,
                          width: 2,
                        ),
                      ),
                      child: isDone
                          ? const Icon(
                              Icons.check,
                              size: Dimens.standard_14,
                              color: AppColors.colorWhite,
                            )
                          : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: Dimens.standard_32,
                        color: isDone
                            ? AppColors.colorGreen
                            : AppColors.dividerColor,
                      ),
                  ],
                ),
                const SizedBox(width: Dimens.standard_12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimens.standard_2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label ?? item.status ?? '',
                          style: isDone
                              ? AppTextStyles.openSansBold14.copyWith(
                                  color: AppColors.textPrimary,
                                )
                              : AppTextStyles.openSansRegular14.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                        ),
                        if (item.timestamp != null &&
                            item.timestamp!.isNotEmpty)
                          Text(
                            item.timestamp!,
                            style: AppTextStyles.openSansRegular10.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDriverCard(OrderDriver driver) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: Dimens.standard_48,
            height: Dimens.standard_48,
            decoration: BoxDecoration(
              color: AppColors.colorGreen.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: AppColors.colorGreen,
              size: Dimens.standard_28,
            ),
          ),
          const SizedBox(width: Dimens.standard_16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.deliveryPartner,
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  driver.name ?? 'Delivery Partner',
                  style: AppTextStyles.openSansBold14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (driver.vehicle != null && driver.vehicle!.isNotEmpty)
                  Text(
                    driver.vehicle!,
                    style: AppTextStyles.openSansRegular12.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (driver.phone != null && driver.phone!.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.phone, color: AppColors.colorGreen),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildItemsCard(List<OrderItemDetail> items) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.items} (${items.length})',
            style: AppTextStyles.openSansBold16.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Dimens.standard_12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.standard_6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName ?? 'Item',
                          style: AppTextStyles.openSansBold14.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${item.packSize ?? ""} × ${item.quantity ?? 1}',
                          style: AppTextStyles.openSansRegular12.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${item.totalPrice ?? ((item.unitPrice ?? 0) * (item.quantity ?? 1))}',
                    style: AppTextStyles.openSansBold14.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(OrderDeliveryAddress address) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.deliveryAddress,
            style: AppTextStyles.openSansBold16.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Dimens.standard_8),
          Text(
            address.tag ?? 'Home',
            style: AppTextStyles.openSansBold14.copyWith(
              color: AppColors.colorGreen,
            ),
          ),
          const SizedBox(height: Dimens.standard_4),
          Text(
            address.formattedAddress ?? '',
            style: AppTextStyles.openSansRegular14.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillCard(OrderDetailData order) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        border: Border.all(color: AppColors.dividerColor),
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
          _buildRow(AppStrings.itemTotal, '₹${order.subtotal ?? 0}'),
          const SizedBox(height: Dimens.standard_8),
          _buildRow(
            AppStrings.deliveryFee,
            (order.deliveryFee == null || order.deliveryFee == 0)
                ? AppStrings.free
                : '₹${order.deliveryFee}',
            valueColor: (order.deliveryFee == null || order.deliveryFee == 0)
                ? AppColors.colorGreen
                : null,
          ),
          if (order.discount != null && order.discount! > 0) ...[
            const SizedBox(height: Dimens.standard_8),
            _buildRow(
              AppStrings.totalSavings,
              '- ₹${order.discount}',
              valueColor: AppColors.colorGreen,
            ),
          ],
          const SizedBox(height: Dimens.standard_8),
          _buildRow(AppStrings.taxesCharges, '₹${order.taxes ?? 0}'),
          const Divider(
            height: Dimens.standard_24,
            color: AppColors.dividerColor,
          ),
          _buildRow(
            AppStrings.totalPaid,
            '₹${order.totalPayable ?? order.grandTotal ?? 0}',
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
}
