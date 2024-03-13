import 'package:splash_app/models/product_data.dart';

class Product {
  Product({
    Data? data,
  }) {
    _data = data;
  }

  Product.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  Data? get data => _data;
}
