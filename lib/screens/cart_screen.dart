import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/constents.dart';
import 'package:splash_app/manager/cart_cubit/cart_cubit.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Cart Items',
          style: GoogleFonts.cairo().copyWith(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: SingleChildScrollView(
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
    );
  }
}
