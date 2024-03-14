import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_cubit.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_states.dart';
import '../widgets/cached_image_view_item.dart';
import '../widgets/failure_widget.dart';

class ProductItemScreen extends StatefulWidget {
  final String id;

  const ProductItemScreen({
    super.key,
    required this.id,
  });

  @override
  State<ProductItemScreen> createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductItemScreenCubit()..getProductItem(widget.id),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: MediaQuery.sizeOf(context).height * .07,
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * .35,
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width * .05),
                        child: PageView.builder(
                          controller: pageController,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CachedImageViewItem(
                              imagePath: cubit
                                      .product
                                      .data
                                      ?.variations?[cubit.selectedVariation]
                                      .productVarientImages?[index]
                                      .imagePath ??
                                  '',
                            ),
                          ),
                          itemCount: cubit
                                  .product
                                  .data
                                  ?.variations?[cubit.selectedVariation]
                                  .productVarientImages
                                  ?.length ??
                              0,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.teal)),
                                  child: CachedImageViewItem(
                                    imagePath: cubit
                                            .product
                                            .data
                                            ?.variations?[
                                                cubit.selectedVariation]
                                            .productVarientImages?[index]
                                            .imagePath ??
                                        '',
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: cubit
                                  .product
                                  .data
                                  ?.variations?[cubit.selectedVariation]
                                  .productVarientImages
                                  ?.length ??
                              0,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetProductItemFailureState) {
            return FailureWidget(
              errorMessage: state.error,
              onPressed: () {
                cubit.getProductItem(widget.id);
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
