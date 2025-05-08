import 'package:cloud_firestore/cloud_firestore.dart';

class sliderBannerModel {
  String? sliderBannerId;
  String? imageUrl;
  String? redirectUrl;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  sliderBannerModel(
      {this.sliderBannerId,
      this.imageUrl,
      this.redirectUrl,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  sliderBannerModel.fromJson(Map<String, dynamic> json) {
    sliderBannerId = json['slider_banner_id'];
    imageUrl = json['image_url'];
    redirectUrl = json['redirect_url'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJsonSupabase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider_banner_id'] = this.sliderBannerId;
    data['image_url'] = this.imageUrl;
    data['redirect_url'] = this.redirectUrl;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toJson() {
  return {
    'image_url': imageUrl,
    'redirect_url': redirectUrl,
    'is_active': isActive,
  };
}

factory sliderBannerModel.fromSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return sliderBannerModel(
    imageUrl: data['image_url'] ?? '',
    redirectUrl: data['redirect_url'] ?? '',
    isActive: data['is_active'] ?? false,
  );
}
}