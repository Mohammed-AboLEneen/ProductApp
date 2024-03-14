import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageViewItem extends StatelessWidget {
  const CachedImageViewItem({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
