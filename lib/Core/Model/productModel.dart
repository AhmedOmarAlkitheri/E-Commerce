import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_client/Core/Model/brandModel.dart';
import 'package:ecommerce_app_client/Core/Model/productAttributeModel.dart';
import 'package:ecommerce_app_client/Core/Model/productVariationModel.dart';

class ProductModel {
  String? id;
  int? stock;
  String? sku;
  double? price;
  String? title;
  DateTime? date;
  double? salePrice;
  String? thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String? productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    print(document.data()!);

    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: int.parse(data['Stock'] ?? 0.toString()),
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse(data['Price'] ?? 0.0.toString()),
      salePrice: double.parse(data['SalePrice'] ?? 0.0.toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: int.parse(data['Stock'] ?? 0.toString()),
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse(data['Price'] ?? 0.0.toString()),
      salePrice: double.parse(data['SalePrice'] ?? 0.0.toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  ProductModel.fromJsonSupabase(Map<String, dynamic> json) {
    categoryId = json['CategoryId'];
 price = double.parse( json['Price'].toString() ?? 0.0.toString());

 id=int.parse( json['ProductId'].toString() ?? 0.0.toString()).toString();
 
  
    // if (json['ProductVariations'] != null) {
    //   productVariations = <ProductVariationModel>[];
    //   json['ProductVariations'].forEach((v) {
    //     productVariations!.add(new ProductVariationModel.fromJsonSupabase(v));
    //   });
    // }
 productVariations=   json['ProductVariations'] != null
        ? (json['ProductVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJsonSupabase(e))
            .toList()
        : [];
        

    //       if (json['ProductVariations'] != null) {
    //   productAttributes = <ProductVariationModel>[];
    //   json['ProductVariations'].forEach((v) {
    //     productAttributes!.add(ProductVariationModel.fromJsonSupabase(v));
    //   });
    // }
    description = json['Description'];
    if (json['ProductAttributes'] != null) {
      productAttributes = <ProductAttributeModel>[];
      json['ProductAttributes'].forEach((v) {
        productAttributes!.add(ProductAttributeModel.fromJsonSupabase(v));
      });
    }
    productType = json['ProductType'] ?? "";
    title = json['Title'] ?? "";
      salePrice = double.parse(json['SalePrice']     .toString() ?? 0.0.toString());
    stock = json['Stock']??0;
    thumbnail = json['Thumbnail'] ?? "";
    isFeatured = json['IsFeatured'];

    sku = json['SKU'] ?? "";
        images = json['Images'].cast<String>();
    brand = json['Brand'] != null
        ? new BrandModel.fromJsonSupabase(json['Brand'])
        : null;
   
  
  }

  Map<String, dynamic> toJsonSupabase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brand != null) {
      data['Brand'] = this.brand!.toJson();
    }
    data['CategoryId'] = this.categoryId;
    if (this.productVariations != null) {
      data['ProductVariations'] =
          this.productVariations!.map((v) => v.toJson()).toList();
    }
    data['Description'] = this.description;
    if (this.productAttributes != null) {
      data['ProductAttributes'] =
          this.productAttributes!.map((v) => v.toJson()).toList();
    }
    data['ProductType'] = this.productType;
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['SalePrice'] = this.salePrice;
    data['Stock'] = this.stock;
    data['Thumbnail'] = this.thumbnail;
    data['IsFeatured'] = this.isFeatured;
    data['Images'] = this.images;
    data['SKU'] = this.sku;
    return data;
  }
}
