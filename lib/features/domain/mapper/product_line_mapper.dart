import 'package:commerce_flutter_app/features/domain/entity/product_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductLineEntityMapper {
  ProductLineEntity toEntity(ProductLine model) => ProductLineEntity(
        id: model.id,
        name: model.name,
        count: model.count,
        selected: model.selected,
      );
}
