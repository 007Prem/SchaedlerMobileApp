import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListEntityMapper {
  static WishListEntity toEntity(WishList wishList) => WishListEntity(
        id: wishList.id,
        name: wishList.name,
        canAddAllToCart: wishList.canAddAllToCart,
        description: wishList.description,
        updatedOn: wishList.updatedOn,
        updatedByDisplayName: wishList.updatedByDisplayName,
        wishListLinesCount: wishList.wishListLinesCount,
        wishListSharesCount: wishList.wishListSharesCount,
        isSharedList: wishList.isSharedList,
        sharedByDisplayName: wishList.sharedByDisplayName,
        pagination: wishList.pagination != null
            ? PaginationEntityMapper.toEntity(wishList.pagination!)
            : null,
        wishListLineCollection: wishList.wishListLineCollection
            ?.map((e) => WishListLineEntityMapper.toEntity(e))
            .toList(),
        allowEditingBySharedWithUsers: wishList.allowEditingBySharedWithUsers,
        shareOption: wishList.shareOption,
        isAutogenerated: wishList.isAutogenerated,
      );

  static WishList toModel(WishListEntity wishListEntity) => WishList(
        id: wishListEntity.id,
        name: wishListEntity.name,
        canAddAllToCart: wishListEntity.canAddAllToCart,
        description: wishListEntity.description,
        updatedOn: wishListEntity.updatedOn,
        updatedByDisplayName: wishListEntity.updatedByDisplayName,
        wishListLinesCount: wishListEntity.wishListLinesCount,
        wishListSharesCount: wishListEntity.wishListSharesCount,
        isSharedList: wishListEntity.isSharedList,
        sharedByDisplayName: wishListEntity.sharedByDisplayName,
        pagination: wishListEntity.pagination != null
            ? PaginationEntityMapper.toModel(wishListEntity.pagination!)
            : null,
        wishListLineCollection: wishListEntity.wishListLineCollection
            ?.map((e) => WishListLineEntityMapper.toModel(e))
            .toList(),
        allowEditingBySharedWithUsers:
            wishListEntity.allowEditingBySharedWithUsers,
        shareOption: wishListEntity.shareOption,
        isAutogenerated: wishListEntity.isAutogenerated,
      );
}

class WishListLineEntityMapper {
  static WishListLineEntity toEntity(WishListLine wishListLine) =>
      WishListLineEntity(
        id: wishListLine.id,
        productUri: wishListLine.productUri,
        productId: wishListLine.productId,
        smallImagePath: wishListLine.smallImagePath,
        altText: wishListLine.altText,
        productName: wishListLine.productName,
        manufacturerItem: wishListLine.manufacturerItem,
        customerName: wishListLine.customerName,
        shortDescription: wishListLine.shortDescription,
        qtyOnHand: wishListLine.qtyOnHand,
        qtyOrdered: wishListLine.qtyOrdered,
        erpNumber: wishListLine.erpNumber,
        pricing: wishListLine.pricing != null
            ? ProductPriceEntityMapper.toEntity(wishListLine.pricing!)
            : null,
        quoteRequired: wishListLine.quoteRequired,
        isActive: wishListLine.isActive,
        canEnterQuantity: wishListLine.canEnterQuantity,
        canShowPrice: wishListLine.canShowPrice,
        canAddToCart: wishListLine.canAddToCart,
        canShowUnitOfMeasure: wishListLine.canShowUnitOfMeasure,
        canBackOrder: wishListLine.canBackOrder,
        trackInventory: wishListLine.trackInventory,
        availability: wishListLine.availability != null
            ? AvailabilityEntityMapper.toEntity(wishListLine.availability!)
            : null,
        breakPrices: wishListLine.breakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toEntity(e))
            .toList(),
        unitOfMeasure: wishListLine.unitOfMeasure,
        unitOfMeasureDisplay: wishListLine.unitOfMeasureDisplay,
        unitOfMeasureDescription: wishListLine.unitOfMeasureDescription,
        baseUnitOfMeasure: wishListLine.baseUnitOfMeasure,
        baseUnitOfMeasureDisplay: wishListLine.baseUnitOfMeasureDisplay,
        qtyPerBaseUnitOfMeasure: wishListLine.qtyPerBaseUnitOfMeasure,
        selectedUnitOfMeasure: wishListLine.selectedUnitOfMeasure,
        productUnitOfMeasures: wishListLine.productUnitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toEntity(e))
            .toList(),
        packDescription: wishListLine.packDescription,
        createdOn: wishListLine.createdOn,
        notes: wishListLine.notes,
        createdByDisplayName: wishListLine.createdByDisplayName,
        isSharedLine: wishListLine.isSharedLine,
        isVisible: wishListLine.isVisible,
        isDiscontinued: wishListLine.isDiscontinued,
        sortOrder: wishListLine.sortOrder,
        brand: BrandEntityMapper.toEntity(wishListLine.brand),
        isQtyAdjusted: wishListLine.isQtyAdjusted,
        allowZeroPricing: wishListLine.allowZeroPricing,
        properties: wishListLine.properties,
      );

  static WishListLine toModel(WishListLineEntity wishListLineEntity) =>
      WishListLine(
        id: wishListLineEntity.id,
        productUri: wishListLineEntity.productUri,
        productId: wishListLineEntity.productId,
        smallImagePath: wishListLineEntity.smallImagePath,
        altText: wishListLineEntity.altText,
        productName: wishListLineEntity.productName,
        manufacturerItem: wishListLineEntity.manufacturerItem,
        customerName: wishListLineEntity.customerName,
        shortDescription: wishListLineEntity.shortDescription,
        qtyOnHand: wishListLineEntity.qtyOnHand,
        qtyOrdered: wishListLineEntity.qtyOrdered,
        erpNumber: wishListLineEntity.erpNumber,
        pricing: wishListLineEntity.pricing != null
            ? ProductPriceEntityMapper.toModel(wishListLineEntity.pricing!)
            : null,
        quoteRequired: wishListLineEntity.quoteRequired,
        isActive: wishListLineEntity.isActive,
        canEnterQuantity: wishListLineEntity.canEnterQuantity,
        canShowPrice: wishListLineEntity.canShowPrice,
        canAddToCart: wishListLineEntity.canAddToCart,
        canShowUnitOfMeasure: wishListLineEntity.canShowUnitOfMeasure,
        canBackOrder: wishListLineEntity.canBackOrder,
        trackInventory: wishListLineEntity.trackInventory,
        availability: wishListLineEntity.availability != null
            ? AvailabilityEntityMapper.toModel(wishListLineEntity.availability!)
            : null,
        breakPrices: wishListLineEntity.breakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toModel(e))
            .toList(),
        unitOfMeasure: wishListLineEntity.unitOfMeasure,
        unitOfMeasureDisplay: wishListLineEntity.unitOfMeasureDisplay,
        unitOfMeasureDescription: wishListLineEntity.unitOfMeasureDescription,
        baseUnitOfMeasure: wishListLineEntity.baseUnitOfMeasure,
        baseUnitOfMeasureDisplay: wishListLineEntity.baseUnitOfMeasureDisplay,
        qtyPerBaseUnitOfMeasure: wishListLineEntity.qtyPerBaseUnitOfMeasure,
        selectedUnitOfMeasure: wishListLineEntity.selectedUnitOfMeasure,
        productUnitOfMeasures: wishListLineEntity.productUnitOfMeasures
            ?.map((e) => ProductUnitOfMeasureEntityMapper.toModel(e))
            .toList(),
        packDescription: wishListLineEntity.packDescription,
        createdOn: wishListLineEntity.createdOn,
        notes: wishListLineEntity.notes,
        createdByDisplayName: wishListLineEntity.createdByDisplayName,
        isSharedLine: wishListLineEntity.isSharedLine,
        allowZeroPricing: wishListLineEntity.allowZeroPricing,
        brand: wishListLineEntity.brand != null
            ? BrandEntityMapper.toModel(wishListLineEntity.brand!)
            : null,
        isVisible: wishListLineEntity.isVisible,
        isDiscontinued: wishListLineEntity.isDiscontinued,
        sortOrder: wishListLineEntity.sortOrder,
        isQtyAdjusted: wishListLineEntity.isQtyAdjusted,
      )..properties = wishListLineEntity.properties;
}

class WishListLineCollectionEntityMapper {
  static WishListLineCollectionEntity toEntity(
          WishListLineCollectionModel wishListLineCollection) =>
      WishListLineCollectionEntity(
        wishListLines: wishListLineCollection.wishListLines
            ?.map((e) => WishListLineEntityMapper.toEntity(e))
            .toList(),
        pagination: wishListLineCollection.pagination != null
            ? PaginationEntityMapper.toEntity(
                wishListLineCollection.pagination!)
            : null,
      );

  static WishListLineCollectionModel toModel(
          WishListLineCollectionEntity wishListLineCollectionEntity) =>
      WishListLineCollectionModel(
        wishListLines: wishListLineCollectionEntity.wishListLines
            ?.map((e) => WishListLineEntityMapper.toModel(e))
            .toList(),
        pagination: wishListLineCollectionEntity.pagination != null
            ? PaginationEntityMapper.toModel(
                wishListLineCollectionEntity.pagination!)
            : null,
      );
}

class WishListCollectionEntityMapper {
  static WishListCollectionEntity toEntity(
          WishListCollectionModel wishListCollection) =>
      WishListCollectionEntity(
        wishListCollection: wishListCollection.wishListCollection
            ?.map((e) => WishListEntityMapper.toEntity(e))
            .toList(),
        pagination: wishListCollection.pagination != null
            ? PaginationEntityMapper.toEntity(wishListCollection.pagination!)
            : null,
      );

  static WishListCollectionModel toModel(
          WishListCollectionEntity wishListCollectionEntity) =>
      WishListCollectionModel(
        wishListCollection: wishListCollectionEntity.wishListCollection
            ?.map((e) => WishListEntityMapper.toModel(e))
            .toList(),
        pagination: wishListCollectionEntity.pagination != null
            ? PaginationEntityMapper.toModel(
                wishListCollectionEntity.pagination!)
            : null,
      );
}
