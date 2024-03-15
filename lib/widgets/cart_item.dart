import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cart_item_model.dart';
import 'custom_expension_panal_list.dart';
import 'incremental_container.dart';

class CartItem extends StatelessWidget {
  final CartItemModel cartItemModel;

  const CartItem({super.key, required this.cartItemModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomExpensionPanelList(
        content: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            cartItemModel.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 100 / 120,
              child: CachedNetworkImage(
                imageUrl: cartItemModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: IncrementalContainer(
            limitQuantity: int.parse(cartItemModel.quantity),
            price: int.parse(cartItemModel.price),
          ),
        ),
        header: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Ordered From',
            style: GoogleFonts.cairo().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
          subtitle: Text(
            cartItemModel.brandName,
            style: GoogleFonts.cairo().copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Text('EGP ${cartItemModel.price}',
              style: GoogleFonts.cairo().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 100 / 120,
              child: CachedNetworkImage(
                imageUrl: cartItemModel.brandImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
