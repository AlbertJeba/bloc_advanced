import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/constants/routes.dart';
import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/features/cart/data/models/add_to_cart_request.dart';
import 'package:bloc_advanced/features/cart/domain/use_case/cart_use_case.dart';
import 'package:bloc_advanced/features/grocery/data/models/product_model.dart';
import 'package:bloc_advanced/features/grocery/domain/use_case/get_grocery_items_use_case.dart';
import 'package:bloc_advanced/features/grocery/presentation/cubit/grocery_cubit.dart';
import 'package:bloc_advanced/features/wishlist/domain/use_case/wishlist_use_case.dart';
import 'package:bloc_advanced/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bloc_advanced/main/app_env.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/app_drawer.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:bloc_advanced/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  late GroceryCubit _groceryCubit;
  late WishlistCubit _wishlistCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _groceryCubit = GroceryCubit(injector<GetGroceryItemsUseCase>())..init();
    _wishlistCubit = WishlistCubit(injector<WishlistUseCase>())
      ..fetchWishlist();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      _groceryCubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _groceryCubit.close();
    _wishlistCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _groceryCubit),
        BlocProvider(create: (context) => _wishlistCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.surfaceColor,
          elevation: Dimens.standard_0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.textPrimary,
                size: Dimens.standard_24,
              ),
              tooltip: 'Menu',
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                EnvInfo.appName,
                style: AppTextStyles.openSansBold18.copyWith(
                  color: AppColors.colorGreen,
                ),
              ),
              Text(
                AppStrings.deliveryHeader,
                style: AppTextStyles.openSansRegular12.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite_outline,
                color: AppColors.textPrimary,
              ),
              tooltip: AppStrings.myWishlist,
              onPressed: () => context.push(RoutesName.wishlist),
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.textPrimary,
              ),
              tooltip: AppStrings.myCart,
              onPressed: () => context.push(RoutesName.cart),
            ),
          ],
        ),
        body: BlocBuilder<GroceryCubit, GroceryState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildCategoryList(state),
                Expanded(
                  child: Skeletonizer(
                    enabled: state.isLoading,
                    child: _buildProductGrid(state),
                  ),
                ),
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.standard_12),
                    child: Center(
                      child: CustomLoader(
                        size: Dimens.standard_24,
                        strokeWidth: Dimens.standard_2_5,
                        color: AppColors.colorGreen,
                        isCentered: false,
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

  Widget _buildCategoryList(GroceryState state) {
    final categories = ['All', ...state.categories.map((e) => e.name ?? '')];
    return Container(
      height: Dimens.standard_50,
      margin: const EdgeInsets.symmetric(vertical: Dimens.standard_12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_16),
        itemCount: state.isLoading ? 5 : categories.length,
        itemBuilder: (context, index) {
          if (state.isLoading) {
            return Container(
              width: Dimens.standard_80,
              margin: const EdgeInsets.only(right: Dimens.standard_8),
              decoration: BoxDecoration(
                color: AppColors.colorLightGrey,
                borderRadius: BorderRadius.circular(Dimens.standard_20),
              ),
            );
          }
          final category = categories[index];
          final isSelected = state.selectedCategory == category;
          return GestureDetector(
            onTap: () {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(0);
              }
              _groceryCubit.selectCategory(category);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.standard_20,
                vertical: Dimens.standard_8,
              ),
              margin: const EdgeInsets.only(right: Dimens.standard_8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.colorGreen
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(Dimens.standard_20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.colorTransparent
                      : AppColors.inputBorder,
                ),
              ),
              child: Center(
                child: Text(
                  category.toUpperCase(),
                  style: AppTextStyles.openSansBold12.copyWith(
                    color: isSelected
                        ? AppColors.colorWhite
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(GroceryState state) {
    if (!state.isLoading && state.items.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noProductsInCategory,
          style: AppTextStyles.openSansRegular14.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    final items = state.isLoading ? _dummyItems : state.items;
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(Dimens.standard_16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: Dimens.standard_16,
        mainAxisSpacing: Dimens.standard_16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildProductCard(item);
      },
    );
  }

  Widget _buildProductCard(ProductModel item) {
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
                      top: Radius.circular(Dimens.standard_12),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: item.imageUrl ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: Dimens.standard_6,
                    right: Dimens.standard_6,
                    child: BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, wishlistState) {
                        final isFavorite = wishlistState.items.any(
                          (w) => w.id == item.id,
                        );
                        return CircleAvatar(
                          radius: Dimens.standard_16,
                          backgroundColor: AppColors.colorWhite.withValues(
                            alpha: 0.9,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? AppColors.colorRed
                                  : AppColors.textSecondary,
                              size: Dimens.standard_18,
                            ),
                            onPressed: () =>
                                _wishlistCubit.toggleWishlist(item),
                          ),
                        );
                      },
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
                      color: AppColors.colorGreen,
                    ),
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

  final List<ProductModel> _dummyItems = List.generate(
    6,
    (index) => const ProductModel(
      id: '',
      name: 'Loading Item Name',
      discountPrice: 0,
      mrp: 0,
      imageUrl: '',
    ),
  );
}
