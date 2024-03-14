import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_cubit.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_states.dart';
import '../methods/hex_to_color.dart';
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
          if (state is GetProductItemSuccessState ||
              state is ChangeVariationState) {
            return Scaffold(
              backgroundColor: mainColor,
              body: SafeArea(
                child: SingleChildScrollView(
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
                              horizontal:
                                  MediaQuery.sizeOf(context).width * .05),
                          child: PageView.builder(
                            controller: pageController,
                            itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.teal)),
                                    child: AspectRatio(
                                      aspectRatio: 20 / 20,
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
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.product.data?.name ?? '-----',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cairo().copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'EGP ${cubit.customVariations[cubit.selectedVariation].price ?? '-----'}',
                                    style: GoogleFonts.cairo().copyWith(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: CachedNetworkImageProvider(
                                        cubit.product.data?.brandImage ?? ''),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${cubit.product.data?.brandName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cairo().copyWith(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        if (cubit.customVariations.isNotEmpty &&
                            cubit.customVariations[0].color != null)
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    cubit.changeVariation(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Colors.grey.withOpacity(.6),
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: hexToColor(cubit
                                                .customVariations[index]
                                                .color ??
                                            '000000'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.customVariations.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        if (cubit.customVariations.isNotEmpty &&
                            (cubit.customVariations[cubit.selectedVariation]
                                    .sizes?.isNotEmpty ??
                                false) &&
                            cubit.customVariations[cubit.selectedVariation]
                                    .sizes?[0] !=
                                null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select Size',
                                    style: GoogleFonts.cairo()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          cubit
                                                  .customVariations[
                                                      cubit.selectedVariation]
                                                  .sizes?[index] ??
                                              '-----',
                                          style: GoogleFonts.cairo().copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white.withOpacity(.85),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: cubit
                                            .customVariations[
                                                cubit.selectedVariation]
                                            .sizes
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (cubit.customVariations.isNotEmpty &&
                            (cubit.customVariations[cubit.selectedVariation]
                                    .materials?.isNotEmpty ??
                                false) &&
                            cubit.customVariations[cubit.selectedVariation]
                                    .materials?[0] !=
                                null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select Material',
                                    style: GoogleFonts.cairo()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          cubit
                                                  .customVariations[
                                                      cubit.selectedVariation]
                                                  .materials?[index] ??
                                              '-----',
                                          style: GoogleFonts.cairo().copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white.withOpacity(.85),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: cubit
                                            .customVariations[
                                                cubit.selectedVariation]
                                            .materials
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomExpensionPanelList(
                          description: cubit.product.data?.description ??
                              'There is no description',
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
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

class CustomExpensionPanelList extends StatefulWidget {
  final String description;

  const CustomExpensionPanelList({super.key, required this.description});

  @override
  State<CustomExpensionPanelList> createState() =>
      _CustomExpensionPanalListState();
}

class _CustomExpensionPanalListState extends State<CustomExpensionPanelList> {
  bool Expanded = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            Expanded = isExpanded;
            print(isExpanded);
          });
        },
        children: [
          ExpansionPanel(
            isExpanded: Expanded,
            backgroundColor: Colors.teal,
            headerBuilder: (context, isExpanded) => ListTile(
              title: Text(
                'Description',
                style: GoogleFonts.cairo()
                    .copyWith(fontSize: 18, color: Colors.white),
              ),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                widget.description ?? 'No Description',
                style: GoogleFonts.cairo()
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
