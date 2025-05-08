class ProductVariationModel {
  String? id;
  String? sku;
  String? image;
  String? description;
  double? price;
  double? salePrice;
  int? stock;
  Map<String, String>? attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Create Empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

// Json Format
  toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: int.parse(data['Stock'] ?? 0.toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      description: data['Description'],
      attributeValues: data['attributeValues'] != null
          ? Map<String, String>.from(data['attributeValues'])
          : {},
    );
  }

  ProductVariationModel.fromJsonSupabase(Map<String, dynamic> json) {
    description = json['Description'] ?? "";
  
    sku = json['SKU'] ?? "";
    image = json['Image'] ?? "";
    
    salePrice =
    // json['SalePrice'] ?? 0.0;
    double.parse( json['SalePrice']   .toString() ?? 0.0.toString());
    id = json['Id'] ?? "";
    stock = json['Stock'] ?? 0;
        attributeValues = Map.from( json['attributeValues'] )?? {};
      price = 
   
  double.parse(json['Price']    .toString() ?? 0.0.toString());
  }

  Map<String, dynamic> toJsonSupabase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Description'] = this.description;
    data['Price'] = this.price;
   // if (this.attributeValues != null) {
      data['attributeValues'] = this.attributeValues;
  //  }
    data['SalePrice'] = this.salePrice;
    data['Id'] = this.id;
    data['SKU'] = this.sku;
    data['Image'] = this.image;
    data['Stock'] = this.stock;
    return data;
  }
}
