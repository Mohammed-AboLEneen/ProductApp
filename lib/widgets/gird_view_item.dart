import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';
import '../screens/product_item_screen.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
          return AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: animation.value,
              child: SlideTransition(
                  position: animation.drive(Tween<Offset>(
                      begin: const Offset(0, -1), end: Offset.zero)),
                  child: ProductItemScreen(id: '${product.data?.id}')));
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 130 / 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: product.data!.variations?[0]
                          .productVarientImages?[0].imagePath ??
                      '',
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 5),
                      child: Text(
                        '${product.data!.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                    '${product.data!.brandImage}',
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'EPG ${product.data!.variations?[0].price}',
                  style: GoogleFonts.cairo().copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
