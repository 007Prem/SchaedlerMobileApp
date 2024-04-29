import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListUsecase _wishListUsecase;
  WishListCubit({required WishListUsecase wishListUsecase})
      : _wishListUsecase = wishListUsecase,
        super(
          const WishListState(
            sortOrder: WishListSortOrder.modifiedOnDescending,
            status: WishListStatus.initial,
            wishLists: WishListCollectionEntity(),
          ),
        );

  Future<void> loadWishLists() async {
    emit(state.copyWith(status: WishListStatus.loading));

    final result = await _wishListUsecase.getWishLists(
      sortOrder: state.sortOrder,
      page: 1,
    );

    result != null
        ? emit(
            WishListState(
              wishLists: result,
              status: WishListStatus.success,
              sortOrder: state.sortOrder,
            ),
          )
        : emit(state.copyWith(status: WishListStatus.failure));
  }

  Future<void> loadMoreWishlists() async {
    if (state.wishLists.pagination?.page == null ||
        state.wishLists.pagination!.page! + 1 >
            state.wishLists.pagination!.numberOfPages! ||
        state.status == WishListStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: WishListStatus.moreLoading));
    final result = await _wishListUsecase.getWishLists(
      page: state.wishLists.pagination!.page! + 1,
      sortOrder: state.sortOrder,
    );

    if (result == null) {
      emit(state.copyWith(status: WishListStatus.moreLoadingFailure));
      return;
    }

    final newWishLists = state.wishLists.wishListCollection;
    newWishLists?.addAll(result.wishListCollection!);

    emit(
      state.copyWith(
        wishLists: state.wishLists.copyWith(
          wishListCollection: newWishLists,
          pagination: result.pagination,
        ),
        status: WishListStatus.success,
      ),
    );
  }
}
