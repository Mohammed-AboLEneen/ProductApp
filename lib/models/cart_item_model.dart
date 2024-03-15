class CartItemModel {
  String brandName;
  String brandImage;
  String productName;
  String productVariation;
  String image;
  String price;
  String quantity;

  CartItemModel(
      {required this.brandName,
      required this.productName,
      required this.brandImage,
      required this.image,
      required this.productVariation,
      required this.price,
      required this.quantity});
}
