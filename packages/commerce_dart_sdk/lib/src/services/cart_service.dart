import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/foundation.dart';

class CartService extends ServiceBase implements ICartService {
  CartService({required super.clientService});

  List<AddCartLine> _addToCartRequests = [];
  bool _isAddingToCartSlow = false;

  @override
  bool? isCartEmpty;

  @override
  Future<ServiceResponse<CartLine>> addCartLine(AddCartLine cartLine) {
    // TODO: implement addCartLine
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<List<CartLine>>> addCartLineCollection(
      List<AddCartLine> cartLineCollection) {
    // TODO: implement addCartLineCollection
    throw UnimplementedError();
  }

  @override
  int get addToCartRequestsCount => _addToCartRequests.length;

  @override
  Future<ServiceResponse<CartLineCollectionDto>> addWishListToCart(
      String wishListId) {
    // TODO: implement addWishListToCart
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Promotion>> applyPromotion(AddPromotion promotion) {
    // TODO: implement applyPromotion
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Cart>> approveCart(Cart cart) {
    // TODO: implement approveCart
    throw UnimplementedError();
  }

  @override
  void cancelAllAddCartLineFutures() {
    // TODO: implement cancelAllAddCartLineFutures
  }

  @override
  Future<bool> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Cart>> createAlternateCart(AddCartModel addCartModel) {
    // TODO: implement createAlternateCart
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCart(String cartId) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCartLine(CartLine cartLine) {
    // TODO: implement deleteCartLine
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Cart>> getCart(
      String cartId, CartQueryParameters parameters) async {
    try {
      var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
      final parametersMap = await compute(
          (CartQueryParameters parameters) => parameters.toJson(), parameters);

      url = url.replace(queryParameters: parametersMap);
      final urlString = url.toString();

      final response = await getAsyncNoCache<Cart>(urlString, Cart.fromJson);
      isCartEmpty = response.model?.cartLines == null ||
          response.model!.cartLines!.isEmpty;

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  Future<ServiceResponse<Cart>> _getCart(
      CartQueryParameters parameters, AddCartModel addCartModel,
      {CartType cartType = CartType.regular}) async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
      final ServiceResponse<Cart> response;

      if (cartType == CartType.alternate) {
        url = Uri.parse(CommerceAPIConstants.cartsUrl);
        final data = await serializeToJson(
            addCartModel, (AddCartModel addCartModel) => addCartModel.toJson());

        response =
            await postAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);
      } else {
        if (cartType == CartType.regular) {
          await clientService.removeAlternateCartCookie();
        }

        String urlString =
            url.replace(queryParameters: parameters.toJson()).toString();
        response = await getAsyncNoCache<Cart>(urlString, Cart.fromJson);
      }

      isCartEmpty = response.model?.cartLines == null ||
          response.model!.cartLines!.isEmpty;

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<GetCartLinesResult>> getCartLines() {
    // TODO: implement getCartLines
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<PromotionCollectionModel>> getCartPromotions(
      String cartId) {
    // TODO: implement getCartPromotions
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<CartCollectionModel>> getCarts(
      {CartsQueryParameters? parameters}) {
    // TODO: implement getCarts
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Cart>> getCurrentCart(CartQueryParameters parameters) {
    // TODO: implement getCurrentCart
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<PromotionCollectionModel>> getCurrentCartPromotions() {
    // TODO: implement getCurrentCartPromotions
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<Cart>> getRegularCart(CartQueryParameters parameters) {
    // TODO: implement getRegularCart
    throw UnimplementedError();
  }

  @override
  bool get isAddingToCartSlow => _isAddingToCartSlow;

  @override
  Future<ServiceResponse<Cart>> updateCart(Cart cart) {
    // TODO: implement updateCart
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<CartLine>> updateCartLine(CartLine cartLine) {
    // TODO: implement updateCartLine
    throw UnimplementedError();
  }
}
