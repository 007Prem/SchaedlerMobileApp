import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductUnitOfMeasureEntityMapper {
  ProductUnitOfMeasureEntity toEntity(ProductUnitOfMeasure model) =>
      ProductUnitOfMeasureEntity(
        productUnitOfMeasureId: model.productUnitOfMeasureId,
        unitOfMeasure: model.unitOfMeasure,
        unitOfMeasureDisplay: model.unitOfMeasureDisplay,
        description: model.description,
        qtyPerBaseUnitOfMeasure: model.qtyPerBaseUnitOfMeasure,
        roundingRule: model.roundingRule,
        isDefault: model.isDefault,
        availability: AvailabilityEntityMapper().toEntity(model.availability ??
            Availability()), // Assuming AvailabilityEntityMapper is available
      );
}
