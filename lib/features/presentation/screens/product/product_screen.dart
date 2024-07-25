import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product/product_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

//TODO we need to take another look at the name of each class in this file
//TODO these classes are associated with category or brand product list page

enum ProductParentType {
  category,
  brand,
  brandProductLine,
  brandCategory,
}

class ProductPageEntity {

  String query = '';
  ProductParentType parentType;
  String? pageTitle;
  Category? category;
  String? categoryId;
  String? categoryTitle;
  BrandEntity? brandEntity;
  String? brandEntityId;
  String? brandEntityTitle;
  BrandProductLine? brandProductLine;

  ProductPageEntity(this.query, this.parentType, {this.pageTitle, this.category, this.categoryId, this.categoryTitle, this.brandEntity, this.brandEntityId, this.brandEntityTitle, this.brandProductLine});

  ProductPageEntity copyWith({
    String? query,
    ProductParentType? parentType,
    Category? category,
    String? categoryId,
    String? categoryTitle,
    BrandEntity? brandEntity,
    String? brandEntityId,
    String? brandEntityTitle,
  }) {
    return ProductPageEntity(
      query ?? this.query,
      parentType ?? this.parentType,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      brandEntity: brandEntity ?? this.brandEntity,
      brandEntityId: brandEntityId ?? this.brandEntityId,
      brandEntityTitle: brandEntityTitle ?? this.brandEntityTitle,
    );
  }

}

class ProductScreen extends StatelessWidget {

  final ProductPageEntity pageEntity;

  const ProductScreen({super.key, required this.pageEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => sl<ProductBloc>()..add(ProductLoadEvent(entity: pageEntity)),
      child: ProductPage(pageEntity: pageEntity),
    );
  }
}
class ProductPage extends StatelessWidget {

  final ProductPageEntity pageEntity;

  ProductPage({super.key, required this.pageEntity});

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _getTitle(pageEntity), style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(websitePath: _getWebsitePath(pageEntity)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Input(
              hintText: LocalizationConstants.search.localized(),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  textEditingController.clear();
                  context
                      .read<ProductBloc>()
                      .add(ProductLoadEvent(entity: pageEntity.copyWith(query: '')));
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                context
                    .read<ProductBloc>()
                    .add(ProductLoadEvent(entity: pageEntity.copyWith(query: textEditingController.text)));
              },
              controller: textEditingController,
            ),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider<AddToCartCubit>(
                create: (context) => sl<AddToCartCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<SearchProductsCubit>()
                  ..setProductFilter(pageEntity),
              ),
            ],
            child: Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                switch (state) {
                  case ProductInitial():
                  case ProductLoading():
                    return const Center(child: CircularProgressIndicator());
                  case ProductLoaded():
                    final productCollectionResult = state.result;
                    context
                        .read<SearchProductsCubit>()
                        .loadInitialSearchProducts(productCollectionResult);
                    return SearchProductsWidget(
                      onPageChanged: (page) {},
                      productListType: _getProductListType(pageEntity),
                    );
                  case ProductFailed():
                  default:
                    return Center(
                        child: Text(LocalizationConstants.searchNoResults.localized(),
                            style: OptiTextStyles.body));
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  ProductListType _getProductListType(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return ProductListType.categoryProducts;
    } else if (entity.parentType == ProductParentType.brand) {
      return ProductListType.shopBrandProducts;
    } else if (entity.parentType == ProductParentType.brandCategory) {
      return ProductListType.shopBrandCategoryProducts;
    } else if (entity.parentType == ProductParentType.brandProductLine) {
      return ProductListType.shopBrandProductLineProducts;
    } else {
      return ProductListType.searchProducts;
    }
  }

  String _getTitle(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return entity.category?.shortDescription ?? entity.categoryTitle ?? LocalizationConstants.categories.localized();
    } else if (entity.parentType == ProductParentType.brand) {
      return entity.brandEntity?.name ?? entity.brandEntityTitle ?? LocalizationConstants.brands.localized();
    }else{
      return entity.pageTitle ?? "Product list";
    }
  }

  String? _getWebsitePath(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return entity.category?.path;
    } else if (entity.parentType == ProductParentType.brand) {
      return entity.brandEntity?.detailPagePath;
    } else if (entity.parentType == ProductParentType.brandProductLine) {
      return entity.brandProductLine?.productListPagePath;
    }
    return null;
  }
}