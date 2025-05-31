class ClassName {
  String? status;
  String? message;
  Data? data;

  ClassName({
    this.status,
    this.message,
    this.data,
  });

  ClassName.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    message = json['message'] as String?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  int? id;
  String? imgUrl;
  String? model;
  String? brand;
  double? price; 
  int? ram;
  int? storage;

  Data({
    this.id,
    this.brand,
    this.price,
    this.model,
    this.ram,
    this.imgUrl,
    this.storage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    brand = json['brand'] as String?;
    price = (json['price'] as num?)?.toDouble();
    imgUrl = json['imgUrl'] as String?;
    model = json['model'] as String?;
    ram = json['ram'] as int?;
    storage = json['storage'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['brand'] = brand;
    json['price'] = price;
    json['model'] = model;
    json['imgUrl'] = imgUrl;
    json['storage'] = storage;
    json['ram'] = ram;
    return json;
  }
}
