import 'package:bloc_advanced/core/dependency_injection/injector.dart';
import 'package:bloc_advanced/core/services/share_service.dart';
import 'package:bloc_advanced/core/services/permission_service.dart';
import 'package:bloc_advanced/features/instamart/data/models/instamart_model.dart';
import 'package:bloc_advanced/features/instamart/domain/use_case/get_instamart_items_usecase.dart';
import 'package:bloc_advanced/features/instamart/presentation/cubit/instamart_cubit.dart';
import 'package:bloc_advanced/shared/config/dimens.dart';
import 'package:bloc_advanced/shared/theme/app_colors.dart';
import 'package:bloc_advanced/shared/theme/text_styles.dart';
import 'package:bloc_advanced/shared/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InstamartHomePage extends StatefulWidget {
  const InstamartHomePage({super.key});

  @override
  State<InstamartHomePage> createState() => _InstamartHomePageState();
}

class _InstamartHomePageState extends State<InstamartHomePage> {
  late InstamartCubit _instamartCubit;

  @override
  void initState() {
    super.initState();
    _instamartCubit = InstamartCubit(injector<GetInstamartItemsUseCase>())..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _instamartCubit,
      child: Scaffold(
        backgroundColor: AppColors.appBackGround,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('InstaMart', style: AppTextStyles.openSansBold18.copyWith(color: AppColors.colorGreen)),
              Text('Delivery in 10 mins', style: AppTextStyles.openSansRegular12.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
              onPressed: () => ShareService.shareText('Check out the amazing fresh items on InstaMart!'),
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
              onPressed: () async {
                final granted = await PermissionService.requestPhotoPermission();
                if (granted && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Photo Permission Granted!')),
                  );
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<InstamartCubit, InstamartState>(
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
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryList(InstamartState state) {
    final categories = ['All', ...state.categories.map((e) => e.name)];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: Dimens.standard_12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.standard_16),
        itemCount: state.isLoading ? 5 : categories.length,
        itemBuilder: (context, index) {
          if (state.isLoading) {
            return Container(
              width: 80,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }
          final category = categories[index];
          final isSelected = state.selectedCategory == category;
          return GestureDetector(
            onTap: () => _instamartCubit.selectCategory(category),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.colorGreen : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  category.toUpperCase(),
                  style: AppTextStyles.openSansBold12.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(InstamartState state) {
    final items = state.isLoading ? _dummyItems : state.items;
    return GridView.builder(
      padding: const EdgeInsets.all(Dimens.standard_16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildProductCard(item);
      },
    );
  }

  Widget _buildProductCard(InstamartModel item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.standard_12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.standard_12)),
              child: CustomNetworkImage(
                imageUrl: item.thumbnail ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.standard_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? '',
                  style: AppTextStyles.openSansBold14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.price ?? 0.0}',
                  style: AppTextStyles.openSansBold16.copyWith(color: AppColors.colorGreen),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.colorGreen,
                      side: const BorderSide(color: AppColors.colorGreen),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('ADD'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<InstamartModel> _dummyItems = List.generate(
    6,
    (index) => InstamartModel(
      id: 0,
      title: 'Loading Item Name',
      price: 0.0,
      thumbnail: '',
    ),
  );
}
