import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';

class WishListEntity extends Equatable {
  final String? id;
  final String? name;
  final bool? canAddAllToCart;
  final String? description;
  final DateTime? updatedOn;
  final String? updatedByDisplayName;
  final int? wishListLinesCount;
  final int? wishListSharesCount;
  final bool? isSharedList;
  final String? sharedByDisplayName;
  final PaginationEntity? pagination;
  final List<WishListLineEntity>? wishListLineCollection;
  final bool? allowEditingBySharedWithUsers;
  final String? shareOption;

  const WishListEntity({
    this.id,
    this.name,
    this.canAddAllToCart,
    this.description,
    this.updatedOn,
    this.updatedByDisplayName,
    this.wishListLinesCount,
    this.wishListSharesCount,
    this.isSharedList,
    this.sharedByDisplayName,
    this.pagination,
    this.wishListLineCollection,
    this.allowEditingBySharedWithUsers,
    this.shareOption,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        canAddAllToCart,
        description,
        updatedOn,
        updatedByDisplayName,
        wishListLinesCount,
        wishListSharesCount,
        isSharedList,
        sharedByDisplayName,
        pagination,
        wishListLineCollection,
        allowEditingBySharedWithUsers,
        shareOption,
      ];

  WishListEntity copyWith({
    String? id,
    String? name,
    bool? canAddAllToCart,
    String? description,
    DateTime? updatedOn,
    String? updatedByDisplayName,
    int? wishListLinesCount,
    int? wishListSharesCount,
    bool? isSharedList,
    String? sharedByDisplayName,
    PaginationEntity? pagination,
    List<WishListLineEntity>? wishListLineCollection,
    bool? allowEditingBySharedWithUsers,
    String? shareOption,
  }) {
    return WishListEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      canAddAllToCart: canAddAllToCart ?? this.canAddAllToCart,
      description: description ?? this.description,
      updatedOn: updatedOn ?? this.updatedOn,
      updatedByDisplayName: updatedByDisplayName ?? this.updatedByDisplayName,
      wishListLinesCount: wishListLinesCount ?? this.wishListLinesCount,
      wishListSharesCount: wishListSharesCount ?? this.wishListSharesCount,
      isSharedList: isSharedList ?? this.isSharedList,
      sharedByDisplayName: sharedByDisplayName ?? this.sharedByDisplayName,
      pagination: pagination ?? this.pagination,
      wishListLineCollection:
          wishListLineCollection ?? this.wishListLineCollection,
      allowEditingBySharedWithUsers:
          allowEditingBySharedWithUsers ?? this.allowEditingBySharedWithUsers,
      shareOption: shareOption ?? this.shareOption,
    );
  }
}
