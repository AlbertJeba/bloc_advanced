import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/features/wishlist/domain/use_case/wishlist_use_case.dart';
import 'package:bloc_advanced/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late WishlistCubit _wishlistCubit;

  @override
  void initState() {
    super.initState();
    _wishlistCubit = WishlistCubit(injector<WishlistUseCase>())
      ..fetchWishlist();
  }

  @override
  void dispose() {
    _wishlistCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _wishlistCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceColor,
          elevation: Dimens.standard_0,
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_ios_new, color: AppColors.textPrimary,
                size: Dimens.standard_20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppStrings.myWishlist,
            style: AppTextStyles.openSansBold18.copyWith(
                color: AppColors.textPrimary),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                  Icons.shopping_cart_outlined, color: AppColors.textPrimary),
              onPressed: () => context.push(RoutesName.cart),
            ),
          ],
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CustomLoader());
            }

            if (state.items.isEmpty) {
              return _buildEmptyWishlist(context);
            }

            return GridView.builder(
              padding: const EdgeInsets.all(Dimens.standard_16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Dimens.standard_16,
                mainAxisSpacing: Dimens.standard_16,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return _buildWishlistCard(context, item);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildWishlistCard(BuildContext context, ProductModel item) {
    return GestureDetector(
      onTap: () {
        if (item.id != null && item.id!.isNotEmpty) {
          context.push(RoutesName.productDetail, extra: item.id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(Dimens.standard_12),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withValues(alpha: 0.05),
              blurRadius: Dimens.standard_10,
              offset: const Offset(Dimens.standard_0, Dimens.standard_5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimens.standard_12)),
                    child: CustomNetworkImage(
                      imageUrl: item.imageUrl ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: Dimens.standard_6,
                    right: Dimens.standard_6,
                    child: CircleAvatar(
                      radius: Dimens.standard_16,
                      backgroundColor: AppColors.colorWhite.withValues(
                          alpha: 0.9),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                            Icons.favorite, color: AppColors.colorRed,
                            size: Dimens.standard_18),
                        onPressed: () => _wishlistCubit.toggleWishlist(item),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.standard_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    style: AppTextStyles.openSansBold14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimens.standard_4),
                  Text(
                    '₹${item.discountPrice ?? item.mrp ?? 0}',
                    style: AppTextStyles.openSansBold16.copyWith(
                        color: AppColors.colorGreen),
                  ),
                  const SizedBox(height: Dimens.standard_8),
                  PrimaryButton(
                    text: AppStrings.add,
                    isOutlined: true,
                    height: Dimens.standard_36,
                    borderRadius: Dimens.standard_8,
                    textStyle: AppTextStyles.openSansBold12,
                    onPressed: () {
                      if (item.id != null && item.id!.isNotEmpty) {
                        injector<CartUseCase>().addItem(
                          AddToCartRequest(productId: item.id!, quantity: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.colorGreen,
                            content: Text('${item.name} ${AppStrings.add}!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standard_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border_rounded,
              size: Dimens.standard_80,
              color: AppColors.colorLightGrey,
            ),
            const SizedBox(height: Dimens.standard_16),
            Text(
              AppStrings.wishlistEmpty,
              style: AppTextStyles.openSansBold20.copyWith(
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: Dimens.standard_8),
            Text(
              AppStrings.wishlistEmptySubtitle,
              style: AppTextStyles.openSansRegular14.copyWith(
                  color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.standard_24),
            PrimaryButton(
              text: AppStrings.browseProducts,
              width: Dimens.standard_180,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
