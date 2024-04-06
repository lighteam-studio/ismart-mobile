import 'package:ismart/core/models/product_variation_model.dart';

class BasketItemModel extends ProductVariationModel {
  double amount;

  BasketItemModel({
    required super.variationId,
    required super.name,
    required super.brand,
    required super.thumbnail,
    required super.unit,
    required super.price,
    required this.amount,
    required super.stock,
    required super.variationValues,
  });

  factory BasketItemModel.fromProductVariation(ProductVariationModel variation) {
    return BasketItemModel(
      variationId: variation.variationId,
      name: variation.name,
      brand: variation.brand,
      thumbnail: variation.thumbnail,
      unit: variation.unit,
      price: variation.price,
      amount: 1,
      stock: variation.stock,
      variationValues: variation.variationValues,
    );
  }
}
