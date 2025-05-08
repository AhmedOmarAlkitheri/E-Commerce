class ProductAttributeModel {
  String? name;
   List<String>? values;

  ProductAttributeModel({this.name, this.values});


  ProductAttributeModel.empty() {
    name = "";
    values = [];
  }
  // Json Format
  toJson() {
    return {'Name': name, 'Values': values};
  }

  // Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }


   ProductAttributeModel.fromJsonSupabase(Map<String, dynamic> json) {
    values = json['Values'].cast<String>();
    name = json['Name'];
  }

  Map<String, dynamic> toJsonSupabase() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Values'] = this.values;
    data['Name'] = this.name;
    return data;
  }
}
