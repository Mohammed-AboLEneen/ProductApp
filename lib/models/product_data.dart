import 'package:splash_app/models/produect_variations.dart';

import 'available_pro_model.dart';

class Data {
  Data({
    num? id,
    String? name,
    String? type,
    String? description,
    List<Variations>? variations,
    List<AvaiableProperties>? avaiableProperties,
    String? brandName,
    String? brandImage,
  }) {
    _id = id;
    _name = name;
    _type = type;
    _description = description;
    _variations = variations;
    _avaiableProperties = avaiableProperties;
    _brandName = brandName;
    _brandImage = brandImage;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _type = json['type'];
    _description = json['description'];

    _variations = [];
    if (json['ProductVariations'] != null) {
      json['ProductVariations'].forEach((v) {
        _variations?.add(Variations.fromJson(v));
      });
    } else {
      json['variations'].forEach((v) {
        _variations?.add(Variations.fromJson(v));
      });
    }

    if (json['avaiableProperties'] != null) {
      _avaiableProperties = [];
      json['avaiableProperties'].forEach((v) {
        _avaiableProperties?.add(AvaiableProperties.fromJson(v));
      });
    }
    _brandName = json['brandName'];

    if (json['brandImage'] != null) {
      _brandImage = json['brandImage'];
    } else {
      _brandImage = json['Brands']['brand_logo_image_path'];
    }
  }

  num? _id;
  String? _name;
  String? _type;
  String? _description;

  List<Variations>? _variations;
  List<AvaiableProperties>? _avaiableProperties;
  String? _brandName;
  String? _brandImage;

  num? get id => _id;

  String? get name => _name;

  String? get type => _type;

  String? get description => _description;

  List<Variations>? get variations => _variations;

  List<AvaiableProperties>? get avaiableProperties => _avaiableProperties;

  String? get brandName => _brandName;

  String? get brandImage => _brandImage;
}
