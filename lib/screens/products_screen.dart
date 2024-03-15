import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/products_cubit/products_cubit.dart';
import 'package:splash_app/screens/cart_screen.dart';

import 'package:splash_app/screens/skelaton_product_screen.dart';

import '../constents.dart';
import '../manager/cart_cubit/cart_cubit.dart';
import '../manager/products_cubit/products_states.dart';
import '../widgets/failure_widget.dart';
import '../widgets/gird_view_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProductsCubit.get(context);
          if (state is GetProductsSuccessState) {
            return Scaffold(
                backgroundColor: backgroundColor,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Prodects',
                                  style: GoogleFonts.cairo().copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context, PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                    return AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        opacity: animation.value,
                                        child: SlideTransition(
                                            position: animation.drive(
                                                Tween<Offset>(
                                                    begin: const Offset(0, -1),
                                                    end: Offset.zero)),
                                            child: const CartScreen()));
                                  }));
                                },
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 300,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return GridViewItem(
                                product: cubit.product[index],
                              );
                            },
                            itemCount: cubit.product.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          } else if (state is GetProductsFailureState) {
            return FailureWidget(
              errorMessage: state.error,
              onPressed: () {
                cubit.getProducts();
              },
            );
          } else {
            return const SkelatonProductScreen();
          }
        });
  }
}
