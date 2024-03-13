class ProductVarientImages {
  ProductVarientImages({
    num? id,
    String? imagePath,
    num? productVarientId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _imagePath = imagePath;
    _productVarientId = productVarientId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ProductVarientImages.fromJson(dynamic json) {
    _id = json['id'];
    _imagePath = json['image_path'];
    _productVarientId = json['product_varient_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  num? _id;
  String? _imagePath;
  num? _productVarientId;
  String? _createdAt;
  String? _updatedAt;

  num? get id => _id;

  String? get imagePath => _imagePath;

  num? get productVarientId => _productVarientId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;
}
