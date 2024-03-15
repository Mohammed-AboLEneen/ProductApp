import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/constents.dart';
import 'package:splash_app/manager/cart_cubit/cart_cubit.dart';
import 'package:splash_app/widgets/custom_expension_panal_list.dart';

import '../models/cart_item_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: BlocProvider.of<CartCubit>(context)
                  .items
                  .map((e) => CartItem(
                        cartItemModel: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

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

class IncrementalContainer extends StatefulWidget {
  final int limitQuantity;
  final int price;

  const IncrementalContainer(
      {super.key, required this.limitQuantity, required this.price});

  @override
  State<IncrementalContainer> createState() => _IncrementalContainerState();
}

class _IncrementalContainerState extends State<IncrementalContainer> {
  int currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('EGP ${widget.price * currentValue}',
            style: GoogleFonts.cairo().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16)),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: SizedBox(
            width: 80,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentValue > 1) {
                      currentValue--;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
                const Spacer(),
                Text(
                  currentValue.toString(),
                  style: GoogleFonts.cairo().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (currentValue < widget.limitQuantity) {
                      currentValue++;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white.withOpacity(.8),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
