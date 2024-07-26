import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

class MockAnalyticsEvent extends Mock implements AnalyticsEvent {}

void main() {
  group('ShopPageBloc', () {
    late ShopUseCase shopUseCase;
    late ShopPageBloc shopPageBloc;

    setUp(() {
      shopUseCase = MockShopUseCase();
      shopPageBloc = ShopPageBloc(shopUseCase: shopUseCase);
    });

    setUpAll(() {
      registerFallbackValue(MockAnalyticsEvent());
    });

    tearDown(() {
      shopPageBloc.close();
    });

    blocTest<ShopPageBloc, ShopPageState>(
      'emits [ShopPageLoadingState, ShopPageLoadedState] when ShopPageLoadEvent is added and loadData succeeds',
      build: () => shopPageBloc,
      act: (bloc) async {
        when(() => shopUseCase.trackEvent(any())).thenAnswer((_) async {});
        when(() => shopUseCase.loadData())
            .thenAnswer((_) async => const Success([]));
        bloc.add(const ShopPageLoadEvent());
        await untilCalled(() => shopUseCase.loadData());
      },
      expect: () => [
        isA<ShopPageLoadingState>(),
        ShopPageLoadedState(pageWidgets: []),
      ],
    );

    blocTest<ShopPageBloc, ShopPageState>(
      'emits [ShopPageLoadingState, ShopPageFailureState] when ShopPageLoadEvent is added and loadData fails',
      build: () {
        when(() => shopUseCase.trackEvent(any())).thenAnswer((_) async {});
        when(() => shopUseCase.loadData()).thenAnswer(
            (_) async => Failure(ErrorResponse(errorDescription: 'Error')));
        return shopPageBloc;
      },
      act: (bloc) async {
        bloc.add(const ShopPageLoadEvent());
        await untilCalled(() => shopUseCase.loadData());
      },
      expect: () => [
        isA<ShopPageLoadingState>(),
        ShopPageFailureState('Error'),
      ],
    );
  });
}
