import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchUseCase extends BaseUseCase {

  Future<Result<AutocompleteResult, ErrorResponse>?> loadAutocompleteResults(String searchQuery) async {
    var parameters = AutocompleteQueryParameters(
        query: searchQuery,
        categoryEnabled: true,
        brandEnabled: true,
        productEnabled: true,
    );
    var result = await commerceAPIServiceProvider.getAutocompleteService().getAutocompleteResults(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<AutocompleteResult, ErrorResponse>?> loadVmiAutocompleteResults(String searchQuery) async {
    var parameters = VmiBinQueryParameters(
      vmiLocationId : coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '',
      filter : searchQuery,
      expand : 'product',
    );
    var result = await commerceAPIServiceProvider.getVmiLocationsService().getVmiBins(parameters: parameters);
    switch (result) {
      case Success(value: final data):
        List<AutocompleteProduct> result = [];

        if (data?.vmiBins != null) {
          for (var item in data!.vmiBins) {
            if (item.product != null) {
              result.add(AutocompleteProduct(
                id: item.product?.id,
                title: item.product?.shortDescription,
                subtitle: item.product?.pageTitle,
                image: item.product?.mediumImagePath,
                name: item.product?.name,
                erpNumber: item.product?.erpNumber,
                brandName: item.product?.brand?.name,
                brandDetailPagePath: item.product?.brand?.logoSmallImagePath,
                binNumber: item.binNumber,
              ));
            }
          }
        }
        return Success(AutocompleteResult(products: result));
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>?>
      loadSearchProductsResults(
    String searchQuery,
    int currentPage, {
    SortOrderAttribute? selectedSortOrder,
  }) async {
    var parameters = ProductsQueryParameters(
      query: searchQuery,
      page: currentPage,
      // Sort = this.sortViewModel?.CurrentlySelectedSortOption?.SortType,
      // AttributeValueIds = this.SelectedAttributeValueIds,
      // BrandIds = this.SelectedBrandIds,
      // ProductLineIds = this.SelectedProductLineIds,
      // CategoryId = this.SelectedCategoryId,
      // PreviouslyPurchasedProducts = this.PreviouslyPurchased,
      // StockedItemsOnly = this.SelectedStockedItems,
      expand: ["pricing", "facets", "brand"],
      sort: selectedSortOrder?.value,
    );
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  List<SortOrderAttribute> getAvailableSortOrders({
    required List<SortOption> sortOptions,
  }) {
    return SortToolMenuHelper.convertOptionToAttribute(
      sortOptions: sortOptions,
    );
  }

  SortOrderAttribute getSelectedSortOrder({
    required List<SortOrderAttribute> availableSortOrders,
    required String selectedSortOrderType,
  }) {
    return SortToolMenuHelper.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType: selectedSortOrderType,
    );
  }
}
