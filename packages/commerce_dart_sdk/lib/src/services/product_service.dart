import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/foundation.dart';

class ProductService extends ServiceBase implements IProductService {
  ProductService({
    required super.clientService,
  });

  void _fixProduct(Product product) {
    product.pricing ??= ProductPrice();
    product.availability ??= Availability();
  }

  @override
  Future<ServiceResponse<Product>> getProduct(String productId,
      {ProductsQueryParameters? parameters}) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProductCrossSells(
      String productId) {
    // TODO: implement getProductCrossSells
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<ProductPrice>> getProductPrice(
      String productId, ProductPriceQueryParameter parameters) {
    // TODO: implement getProductPrice
    throw UnimplementedError();
  }

  @Deprecated('Caution: Will be removed in a future release.')
  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProducts(
      ProductsQueryParameters parameters) async {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProductsNoCache(
      ProductsQueryParameters parameters) async {
    try {
      Map<String, dynamic> parametersMap = await compute(
          (ProductsQueryParameters parameters) => parameters.toJson(),
          parameters);

      String url = Uri.parse(CommerceAPIConstants.productsUrl)
          .replace(queryParameters: parametersMap)
          .toString();

      final response =
          await getAsyncNoCache(url, GetProductCollectionResult.fromJson);
      final productResult = response.model;

      if (productResult == null) return response;
      if (productResult.products == null) return response;

      for (Product product in productResult.products!) {
        _fixProduct(product);
      }

      return response;
    } catch (e) {
      return ServiceResponse<GetProductCollectionResult>(
          exception: e as Exception);
    }
  }

  @override
  Future<bool> hasProductCache(ProductsQueryParameters parameters) {
    // TODO: implement hasProductCache
    throw UnimplementedError();
  }
}
