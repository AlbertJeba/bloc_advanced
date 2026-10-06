import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/core/services/share_service.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_detail_request.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_product_detail_use_case.dart';
import 'package:bloc_advanced/features/grocery/presentation/cubit/product_detail_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ProductDetailCubit(injector<GetProductDetailUseCase>())
      ..fetchProductDetail(ProductDetailRequest(id: widget.productId));
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.push(RoutesName.cart),
            ),
            IconButton(
              icon: const Icon(
                Icons.share_outlined,
                color: AppColors.textPrimary,
              ),
              onPressed: () {
                final product = _cubit.state.product;
                if (product != null) {
                  ShareService.shareText(
                    'Check out ${product.name} on ${AppStrings.appName}!',
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CustomLoader());
            }

            if (state.errorMessage.isNotEmpty && state.product == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: Dimens.standard_48,
                      color: AppColors.colorRed,
                    ),
                    const SizedBox(height: Dimens.standard_12),
                    Text(
                      state.errorMessage,
                      style: AppTextStyles.openSansRegular14,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimens.standard_16),
                    PrimaryButton(
                      width: Dimens.standard_120,
                      height: Dimens.standard_40,
                      text: AppStrings.retry,
                      onPressed: () =>
                          _cubit.fetchProductDetail(ProductDetailRequest(id: widget.productId)),
                    ),
                  ],
                ),
              );
            }

            final product = state.product;
            if (product == null) {
              return const SizedBox.shrink();
            }

            final images =
                (product.images != null && product.images!.isNotEmpty)
                ? product.images!
                : (product.imageUrl != null ? [product.imageUrl!] : <String>[]);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Gallery
                        Container(
                          color: AppColors.surfaceColor,
                          width: double.infinity,
                          height: Dimens.standard_280,
                          child: Stack(
                            children: [
                              Center(
                                child: CustomNetworkImage(
                                  imageUrl: images.isNotEmpty
                                      ? images[state.selectedImageIndex.clamp(
                                          0,
                                          images.length - 1,
                                        )]
                                      : '',
                                  height: Dimens.standard_240,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              if (product.dealBadge != null &&
                                  product.dealBadge!.isNotEmpty)
                                Positioned(
                                  top: Dimens.standard_16,
                                  left: Dimens.standard_16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.standard_10,
                                      vertical: Dimens.standard_4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.colorGreen,
                                      borderRadius: BorderRadius.circular(
                                        Dimens.standard_6,
                                      ),
                                    ),
                                    child: Text(
                                      product.dealBadge!,
                                      style: AppTextStyles.openSansBold12
                                          .copyWith(
                                            color: AppColors.colorWhite,
                                          ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Image thumbnail strip
                        if (images.length > 1)
                          Container(
                            color: AppColors.surfaceColor,
                            padding: const EdgeInsets.only(
                              bottom: Dimens.standard_12,
                            ),
                            height: Dimens.standard_60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.standard_16,
                              ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                final isSelected =
                                    state.selectedImageIndex == index;
                                return GestureDetector(
                                  onTap: () => _cubit.selectImage(index),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: Dimens.standard_8,
                                    ),
                                    width: Dimens.standard_50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.colorGreen
                                            : AppColors.colorGrey,
                                        width: isSelected
                                            ? Dimens.standard_2
                                            : Dimens.standard_1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Dimens.standard_8,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Dimens.standard_6,
                                      ),
                                      child: CustomNetworkImage(
                                        imageUrl: images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: Dimens.standard_8),

                        // Title & Price Section
                        Container(
                          width: double.infinity,
                          color: AppColors.surfaceColor,
                          padding: const EdgeInsets.all(Dimens.standard_16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.categoryName != null &&
                                  product.categoryName!.isNotEmpty)
                                Text(
                                  '${product.categoryName} • ${product.subcategoryName ?? ""}',
                                  style: AppTextStyles.openSansRegular12
                                      .copyWith(color: AppColors.textSecondary),
                                ),
                              const SizedBox(height: Dimens.standard_4),
                              Text(
                                product.name ?? '',
                                style: AppTextStyles.openSansBold18.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: Dimens.standard_6),
                              Text(
                                product.packSize ?? '',
                                style: AppTextStyles.openSansSemiBold14
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: Dimens.standard_12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '₹${product.discountPrice ?? product.mrp ?? 0}',
                                    style: AppTextStyles.openSansBold24
                                        .copyWith(color: AppColors.colorGreen),
                                  ),
                                  if (product.mrp != null &&
                                      product.discountPrice != null &&
                                      product.mrp! >
                                          product.discountPrice!) ...[
                                    const SizedBox(width: Dimens.standard_8),
                                    Text(
                                      '${AppStrings.mrp} ₹${product.mrp}',
                                      style: AppTextStyles.openSansRegular14
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                    const SizedBox(width: Dimens.standard_8),
                                    Text(
                                      '${(((product.mrp! - product.discountPrice!) / product.mrp!) * 100).round()}% ${AppStrings.off}',
                                      style: AppTextStyles.openSansBold12
                                          .copyWith(color: AppColors.colorRed),
                                    ),
                                  ],
                                ],
                              ),
                              if (product.rating != null &&
                                  product.rating! > 0) ...[
                                const SizedBox(height: Dimens.standard_10),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimens.standard_8,
                                        vertical: Dimens.standard_3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.colorGreen,
                                        borderRadius: BorderRadius.circular(
                                          Dimens.standard_6,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: Dimens.standard_14,
                                            color: AppColors.colorWhite,
                                          ),
                                          const SizedBox(
                                            width: Dimens.standard_4,
                                          ),
                                          Text(
                                            product.rating!.toStringAsFixed(1),
                                            style: AppTextStyles.openSansBold12
                                                .copyWith(
                                                  color: AppColors.colorWhite,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimens.standard_8),
                                    Text(
                                      '(${product.ratingCount ?? 0} ${AppStrings.reviews})',
                                      style: AppTextStyles.openSansRegular12
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: Dimens.standard_8),

                        // Description Section
                        if (product.description != null &&
                            product.description!.isNotEmpty)
                          Container(
                            width: double.infinity,
                            color: AppColors.surfaceColor,
                            padding: const EdgeInsets.all(Dimens.standard_16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.productDetails,
                                  style: AppTextStyles.openSansBold16.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: Dimens.standard_8),
                                Text(
                                  product.description!,
                                  style: AppTextStyles.openSansRegular14
                                      .copyWith(
                                        color: AppColors.textPrimary,
                                        height:
                                            Dimens.decimal_50 +
                                            Dimens.standard_1,
                                      ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: Dimens.standard_8),

                        // Nutrition facts Section
                        if (product.nutrition != null)
                          Container(
                            width: double.infinity,
                            color: AppColors.surfaceColor,
                            padding: const EdgeInsets.all(Dimens.standard_16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.nutritionalInformation,
                                  style: AppTextStyles.openSansBold16.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: Dimens.standard_12),
                                Row(
                                  children: [
                                    _buildNutritionItem(
                                      AppStrings.calories,
                                      product.nutrition?.calories ?? '-',
                                    ),
                                    _buildNutritionItem(
                                      AppStrings.carbs,
                                      product.nutrition?.carbs ?? '-',
                                    ),
                                    _buildNutritionItem(
                                      AppStrings.fat,
                                      product.nutrition?.fat ?? '-',
                                    ),
                                    _buildNutritionItem(
                                      AppStrings.protein,
                                      product.nutrition?.protein ?? '-',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: Dimens.standard_80),
                      ],
                    ),
                  ),
                ),

                // Bottom Sticky Action Bar
                Container(
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
                        offset: const Offset(
                          Dimens.standard_0,
                          -Dimens.standard_4,
                        ),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        // Quantity stepper
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.colorLightGrey),
                            borderRadius: BorderRadius.circular(
                              Dimens.standard_8,
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: Dimens.standard_18,
                                ),
                                onPressed: _cubit.decrementQuantity,
                              ),
                              Text(
                                '${state.quantity}',
                                style: AppTextStyles.openSansBold16,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: Dimens.standard_18,
                                ),
                                onPressed: _cubit.incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Dimens.standard_16),

                        // Add to Cart Button
                        Expanded(
                          child: PrimaryButton(
                            text:
                                '${AppStrings.add} (₹${(product.discountPrice ?? product.mrp ?? 0) * state.quantity})',
                            onPressed: () {
                              final request = AddToCartRequest(
                                productId: product.id ?? '',
                                quantity: state.quantity,
                              );
                              injector<CartUseCase>().addItem(request);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.colorGreen,
                                  content: Text(
                                    '${product.name} ${AppStrings.add}!',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: AppStrings.viewCart,
                                    textColor: AppColors.colorWhite,
                                    onPressed: () {
                                      if (context.mounted) {
                                        context.push(RoutesName.cart);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(Dimens.standard_8),
        margin: const EdgeInsets.symmetric(horizontal: Dimens.standard_4),
        decoration: BoxDecoration(
          color: AppColors.appBackGround,
          borderRadius: BorderRadius.circular(Dimens.standard_8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppTextStyles.openSansRegular12.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: Dimens.standard_4),
            Text(
              value,
              style: AppTextStyles.openSansBold14.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
