import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/products_cubit/products_cubit.dart';
import 'package:splash_app/models/product_model.dart';
import 'package:splash_app/screens/product_item_screen.dart';

import '../constents.dart';
import '../manager/products_cubit/products_states.dart';
import '../widgets/failure_widget.dart';
import '../widgets/gird_view_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(),
      child: BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ProductsCubit.get(context);
            if (state is GetProductsSuccessState) {
              return Scaffold(
                  backgroundColor: mainColor,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          }),
    );
  }
}
