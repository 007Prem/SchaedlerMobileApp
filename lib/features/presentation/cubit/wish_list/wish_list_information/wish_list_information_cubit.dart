import 'package:commerce_flutter_app/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_information_state.dart';

class WishListInformationCubit extends Cubit<WishListInformationState> {
  final WishListUsecase _wishListUsecase;
  WishListInformationCubit({required WishListUsecase wishListUsecase})
      : _wishListUsecase = wishListUsecase,
        super(
          const WishListInformationState(
            wishList: WishListEntity(),
            settings: WishListSettingsEntity(),
            status: WishListStatus.initial,
          ),
        );

  Future<void> initialize({
    required WishListEntity wishList,
  }) async {
    emit(state.copyWith(wishList: wishList, status: WishListStatus.loading));
    final settings = await _wishListUsecase.loadWishListSettings();
    if (settings != null) {
      emit(
        state.copyWith(
          settings: settings,
          status: WishListStatus.failure,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: WishListStatus.success,
          settings: settings,
        ),
      );
    }
  }

  Future<void> updateWishList({
    required String name,
    String? description,
  }) async {
    emit(state.copyWith(status: WishListStatus.loading));
    final result = await _wishListUsecase.updateWishList(
      wishListEntity: state.wishList,
      newName: name,
      newDescription: description ?? '',
    );

    emit(state.copyWith(status: result));
  }

  bool get canEditNameDesc =>
      state.settings.allowEditingOfWishLists == true &&
      state.wishList.isSharedList == false;
}
