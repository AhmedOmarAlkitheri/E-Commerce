import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
    final String brandId;
    final String categoryId;

    BrandCategoryModel({
        required this.brandId,
        required this.categoryId,
    });

    Map<String, dynamic> toJson() {
        return {
            'brand_id': brandId,
            'category_id': categoryId,
        };
    }

    factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return BrandCategoryModel(
            brandId: data['brand_id'] as String,
            categoryId: data['category_id'] as String,
        );
    }
}
