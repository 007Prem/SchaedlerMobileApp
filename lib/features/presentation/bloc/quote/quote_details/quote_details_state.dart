import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class QuoteDetailsState {}

class QuoteDetailsInitialState extends QuoteDetailsState {}

class QuoteDetailsLoadingState extends QuoteDetailsState {}

class QuoteDetailsLoadedState extends QuoteDetailsState {
  final QuoteDto quoteDto;
  final List<QuoteLineEntity> quoteLines;
  QuoteDetailsLoadedState({required this.quoteDto, required this.quoteLines});
}

class QuoteDetailsFailedState extends QuoteDetailsState {
  final String error;
  QuoteDetailsFailedState({required this.error});
}
