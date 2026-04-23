import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/core/constants/app_strings.dart';
import 'package:bloc_advanced/core/network/logout_service_function.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/features/dashboard/data/models/product.dart';
import 'package:bloc_advanced/features/dashboard/domain/use_case/get_products_usecase.dart';
import 'package:bloc_advanced/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bloc_advanced/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_loader.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Dashboard Screen - The main screen after login.
///
/// What it does:
/// 1. Shows welcome message with user's name
/// 2. Displays a grid of products from the API
/// 3. Supports pull-to-refresh to reload products
/// 4. Loads more products when scrolling to bottom (pagination)
/// 5. Allows user to logout
///
/// This screen uses BLoC pattern (DashboardCubit) to manage state.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // The cubit that handles product loading logic
  late DashboardCubit _dashboardCubit;

  // Controller to detect when user scrolls
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Set up scroll controller for pagination
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _initializeCubit();
  }

  /// Creates the DashboardCubit and fetches products
  void _initializeCubit() {
    final getProductsUseCase = injector<GetProductsUseCase>();
    _dashboardCubit = DashboardCubit(getProductsUseCase);
    _dashboardCubit.getProducts(); // Load first page of products
  }

  /// Called every time user scrolls
  /// If user is near the bottom, load more products
  void _onScroll() {
    if (_isBottom) {
      _dashboardCubit.loadMoreProducts();
    }
  }

  /// Checks if user has scrolled to 90% of the list
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * Dimens.decimal_9);
  }

  @override
  void dispose() {
    // Clean up scroll controller when screen is closed
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the logged in user's data
    final user = UserPreferences.instance.getUser();

    return BlocProvider(
      // Provide the DashboardCubit to this screen so we can access it
      create: (context) => _dashboardCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with user info and logout button
              _buildAppBar(user),

              // Products list area
              Expanded(
                // BlocBuilder listens to state changes and rebuilds the UI
                // It's like setState() but only for this part of the screen
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    // Show loading spinner when first loading
                    if (state.isLoading &&
                        (state.products == null || state.products!.isEmpty)) {
                      return const CustomLoader();
                    }

                    // Show error message if loading failed
                    if (state.isFailure &&
                        (state.products == null || state.products!.isEmpty)) {
                      return _buildErrorState(state.message);
                    }

                    // Show products if we have them
                    if (state.products != null && state.products!.isNotEmpty) {
                      return RefreshIndicator(
                        // Allows user to pull down to reload the list
                        color: AppColors.colorPrimary,
                        onRefresh: () async => _dashboardCubit.refresh(),
                        
                        // CustomScrollView allows us to mix different scrolling widgets
                        // like lists and grids together
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            // Header with "Products" title and count
                            // SliverToBoxAdapter adapts a normal widget to be used in a sliver
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.all(Dimens.standard_16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.products.toUpperCase(),
                                      style: AppTextStyles.openSansBold20
                                          .copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                    ),
                                    Text(
                                      "${state.products!.length} of ${state.totalProducts}",
                                      style: AppTextStyles.openSansRegular14
                                          .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Product cards in a 2-column grid
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.standard_16,
                              ),
                              sliver: SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 columns
                                      childAspectRatio: Dimens.decimal_68, // Card height/width ratio
                                      crossAxisSpacing: Dimens.standard_12,
                                      mainAxisSpacing: Dimens.standard_12,
                                    ),
                                delegate: SliverChildBuilderDelegate((
                                  context,
                                  index,
                                ) {
                                  return _buildProductCard(
                                    state.products![index],
                                  );
                                }, childCount: state.products!.length),
                              ),
                            ),

                            // Show loading spinner when loading more
                            if (state.isLoadingMore)
                              const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.all(Dimens.standard_20),
                                  child: CustomLoader(
                                    strokeWidth: Dimens.standard_2,
                                  ),
                                ),
                              ),

                            // Bottom padding
                            const SliverToBoxAdapter(
                              child: SizedBox(height: Dimens.standard_20),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top app bar with user info and logout button
  Widget _buildAppBar(dynamic user) {
    return Container(
      padding: const EdgeInsets.all(Dimens.standard_16),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: Dimens.standard_8,
            offset: const Offset(Dimens.standard_0, Dimens.standard_2),
          ),
        ],
      ),
      child: Row(
        children: [
          // User avatar (first letter of name)
          Container(
            width: Dimens.standard_48,
            height: Dimens.standard_48,
            decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(Dimens.standard_12),
            ),
            child: Center(
              child: Text(
                (user?.firstName ?? user?.username ?? AppStrings.userInitial)
                    .toString()
                    .substring(0, 1)
                    .toUpperCase(),
                style: AppTextStyles.openSansBold20.copyWith(
                  color: AppColors.colorWhite,
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimens.standard_12),

          // Welcome text and user name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.welcome}! 👋",
                  style: AppTextStyles.openSansRegular12.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  user?.firstName ?? user?.username ?? AppStrings.user,
                  style: AppTextStyles.openSansBold14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Logout button
          IconButton(
            onPressed: () => _showLogoutDialog(context),
            icon: Container(
              padding: const EdgeInsets.all(Dimens.standard_8),
              decoration: BoxDecoration(
                color: AppColors.colorRed.withValues(alpha: Dimens.decimal_1),
                borderRadius: BorderRadius.circular(Dimens.standard_10),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.colorRed,
                size: Dimens.standard_20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single product card
  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(Dimens.standard_16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: Dimens.standard_8,
            offset: const Offset(Dimens.standard_0, Dimens.standard_2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image section (60% of card height)
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Product image
                CustomNetworkImage(
                  imageUrl: product.thumbnail ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimens.standard_16),
                    topRight: Radius.circular(Dimens.standard_16),
                  ),
                ),

                // Discount badge (top left corner)
                if (product.discountPercentage != null &&
                    product.discountPercentage! > 0)
                  Positioned(
                    top: Dimens.standard_8,
                    left: Dimens.standard_8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.standard_8,
                        vertical: Dimens.standard_4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorRed,
                        borderRadius: BorderRadius.circular(Dimens.standard_6),
                      ),
                      child: Text(
                        "-${product.discountPercentage!.toStringAsFixed(0)}%",
                        style: AppTextStyles.openSansBold12.copyWith(
                          color: AppColors.colorWhite,
                          fontSize: Dimens.standard_11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Product details section (40% of card height)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.standard_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product title
                  Text(
                    product.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.openSansBold13.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),

                  // Price and rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: AppTextStyles.openSansBold14.copyWith(
                          color: AppColors.colorPrimary,
                          fontSize: Dimens.standard_15,
                        ),
                      ),

                      // Rating badge
                      if (product.rating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.standard_6,
                            vertical: Dimens.standard_2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorYellow.withValues(
                              alpha: Dimens.decimal_15,
                            ),
                            borderRadius: BorderRadius.circular(Dimens.standard_6),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.colorYellow,
                                size: Dimens.standard_14,
                              ),
                              const SizedBox(width: Dimens.standard_2),
                              Text(
                                product.rating!.toStringAsFixed(1),
                                style: AppTextStyles.openSansBold12.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the error state UI with retry button
  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standard_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(Dimens.standard_20),
              decoration: BoxDecoration(
                color: AppColors.colorRed.withValues(alpha: Dimens.decimal_1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: Dimens.standard_48,
                color: AppColors.colorRed,
              ),
            ),
            const SizedBox(height: Dimens.standard_24),
            Text(
              AppStrings.errorSomethingWrong,
              style: AppTextStyles.openSansBold18.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: Dimens.standard_8),
            Text(
              message,
              style: AppTextStyles.openSansRegular14.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.standard_24),
            ElevatedButton.icon(
              onPressed: () => _dashboardCubit.refresh(),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppStrings.retry.toUpperCase()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorPrimary,
                foregroundColor: AppColors.colorWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.standard_24,
                  vertical: Dimens.standard_12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.standard_12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shows the logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.standard_16)),
        title: Text(AppStrings.logout.toUpperCase(), style: AppTextStyles.openSansBold18),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.logoutConfirm,
              style: AppTextStyles.openSansRegular14,
            ),
            const SizedBox(height: Dimens.standard_24),

            // Cancel and Logout buttons in a row
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: SizedBox(
                    height: Dimens.standard_44,
                    child: OutlinedButton(
                      onPressed: () => dialogContext.pop(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.colorGrey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.standard_10),
                        ),
                      ),
                      child: Text(
                        AppStrings.cancel,
                        style: AppTextStyles.openSansBold14.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.standard_12),

                // Logout button
                Expanded(
                  child: SizedBox(
                    height: Dimens.standard_44,
                    child: ElevatedButton(
                      onPressed: () async {
                        dialogContext.pop(); // Close dialog
                        await LogoutService.instance.logoutAndNavigate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorRed,
                        foregroundColor: AppColors.colorWhite,
                        elevation: Dimens.standard_0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.standard_10),
                        ),
                      ),
                      child: Text(
                        AppStrings.logout.toUpperCase(),
                        style: AppTextStyles.openSansBold14.copyWith(
                          color: AppColors.colorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
