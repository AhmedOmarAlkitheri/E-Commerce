import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryId;
  String? categoryName;
  String? categoryImageUrl;
  bool? isFeatured;
  String? parentId;

  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.categoryId,
      this.categoryName,
      this.categoryImageUrl,
      this.isFeatured,
      this.parentId = '',
      this.createdAt,
      this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImageUrl = json['category_image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
        isFeatured = json['isFeatured'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJsonSupabase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_image_url'] = this.categoryImageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
        data['isFeatured'] = this.isFeatured;
    data['parentId'] = this.parentId;
    return data;
  }

  /// Empty Helper Function
static CategoryModel empty() => CategoryModel(categoryId: '', categoryImageUrl: '', categoryName: '', isFeatured: false);

/// Convert model to Json structure so that you can store data in Firebase
Map<String, dynamic> toJson() {
    return {
        'category_name': categoryName,
        'category_image_url': categoryImageUrl,
        'parentId': parentId,
        'isFeatured': isFeatured,
    };
}

/// Map Json oriented document snapshot from Firebase to UserModel
factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
        final data = document.data()!;
        // Map JSON Record to the Model
        return CategoryModel(
            categoryId: document.id,
            categoryName: data['category_name'] ?? '',
            categoryImageUrl: data['category_image_url'] ?? '',
            parentId: data['parentId'] ?? '',
            isFeatured: data['isFeatured'] ?? false,
        );
    } else {
        return CategoryModel.empty();
    }
}

}
