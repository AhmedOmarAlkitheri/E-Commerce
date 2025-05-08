import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String? brandId;
  String? brandName;
  String? logoUrl;

  String? createdAt;
  String? updatedAt;
  bool? isFeatured;
  String? productsCount;

  BrandModel(
      {this.brandId,
      this.brandName,
      this.logoUrl,
      this.createdAt,
      this.updatedAt,
      this.isFeatured,
      this.productsCount});

  static BrandModel empty() =>
      BrandModel(brandId: "", brandName: "", logoUrl: "");

  BrandModel.fromJsonSupabase(Map<String, dynamic> json) {
    brandId = json['brand_id'].toString() ?? "";
    brandName = json['brand_name']?? "";
    logoUrl = json['logo_url']?? "";
    // createdAt = json['created_at'] ?? DateTime.now();
    // updatedAt = json['updated_at']?? DateTime.now(); 
    isFeatured = json['isFeatured'];
    productsCount = json['productsCount'] ?? "";
  }

  Map<String, dynamic> toJsonBrandModel() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['logo_url'] = this.logoUrl;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;

    data['isFeatured'] = this.isFeatured;
    data['productsCount'] = this.productsCount;
    return data;
  }


  Map<String, dynamic> toJson() {
    return {
      "brand_id": this.brandId,
      "brand_name": this.brandName,
      "logo_url": this.logoUrl,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "isFeatured": this.isFeatured,
      "productsCount": this.productsCount
    };
  }

// Map Json oriented document snapshot from Firebase to UserModel
factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        brandId: data['brand_id'] ?? '',
        brandName: data['brand_name'] ?? '',
        logoUrl: data['logo_url'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['productsCount'] ?? "0"
    );
}

// Map Json oriented document snapshot from Firebase to UserModel
factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
        final data = document.data()!;
        // Map JSON Record to the Model
        return BrandModel(
            brandId: document.id,
            brandName: data['brand_name'] ?? '',
            logoUrl: data['logo_url'] ?? '',
            productsCount: data['productsCount'] ?? "0",
            isFeatured: data['isFeatured'] ?? false,
        );
    } else {
        return BrandModel.empty();
    }
}

}
