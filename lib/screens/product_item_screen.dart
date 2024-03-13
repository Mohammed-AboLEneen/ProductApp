import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_cubit.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_states.dart';
import '../widgets/failure_widget.dart';

class ProductItemScreen extends StatelessWidget {
  final String id;

  const ProductItemScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductItemScreenCubit()..getProductItem(id),
      child: BlocConsumer<ProductItemScreenCubit, ProductItemScreenStates>(
        builder: (context, state) {
          var cubit = ProductItemScreenCubit.get(context);
          if (state is GetProductItemSuccessState) {
            return Scaffold(
              backgroundColor: mainColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Product details',
                                  style: GoogleFonts.cairo().copyWith(
                                      color: Colors.white, fontSize: 20),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetProductItemFailureState) {
            return FailureWidget(
              errorMessage: state.error,
              onPressed: () {
                cubit.getProductItem(id);
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
