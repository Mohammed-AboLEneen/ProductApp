class CustomVariationModel {
  num? price;
  String? color;
  List<String?>? sizes = [];
  List<String?>? materials = [];

  CustomVariationModel(
      {required this.color, required this.price, this.materials, this.sizes});
}
