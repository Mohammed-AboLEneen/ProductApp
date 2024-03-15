import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_app/manager/cart_cubit/cart_cubit.dart';
import 'package:splash_app/manager/cart_cubit/cart_states.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_cubit.dart';
import 'package:splash_app/models/cart_item_model.dart';
import 'package:splash_app/widgets/custom_button.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_states.dart';
import '../methods/hex_to_color.dart';
import '../models/produect_variations.dart';
import '../widgets/cached_image_view_item.dart';
import '../widgets/color_listview.dart';
import '../widgets/custom_expension_panal_list.dart';
import '../widgets/failure_widget.dart';
import '../widgets/materials_listview.dart';
import '../widgets/sizes_listview.dart';

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
          if (state is GetProductItemFailureState) {
            return FailureWidget(
              errorMessage: state.error,
              onPressed: () {
                cubit.getProductItem(widget.id);
              },
            );
          } else if (state is GetProductItemLoadingState) {
            return Center(
                child: SizedBox(
              width: MediaQuery.sizeOf(context).width * .3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  color: Colors.teal,
                ),
              ),
            ));
          } else {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
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
                          ColorsListView(cubit: cubit),
                        if (cubit.customVariations.isNotEmpty &&
                            (cubit.customVariations[cubit.selectedVariation]
                                    .sizes?.isNotEmpty ??
                                false) &&
                            cubit.customVariations[cubit.selectedVariation]
                                    .sizes?[0] !=
                                null)
                          SizesListView(cubit: cubit),
                        if (cubit.customVariations.isNotEmpty &&
                            (cubit.customVariations[cubit.selectedVariation]
                                    .materials?.isNotEmpty ??
                                false) &&
                            cubit.customVariations[cubit.selectedVariation]
                                    .materials?[0] !=
                                null)
                          MaterialsListView(cubit: cubit),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomExpensionPanelList(
                          content: Text(
                            cubit.product.data?.description ??
                                'There is no description',
                            style: GoogleFonts.cairo()
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<CartCubit, CartCubitStates>(
                            builder: (context, state) {
                          return SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .7,
                            child: CustomTextButton(
                              text: chooseTextButtonCart(context,
                                  cubit.product.data?.variations ?? []),
                              textColor: Colors.white,
                              buttonColor: mainColor.withOpacity(.8),
                              topLeft: 10,
                              bottomLeft: 10,
                              bottomRight: 10,
                              topRight: 10,
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).addItem(CartItemModel(
                                    brandName:
                                        cubit.product.data?.brandName ?? '',
                                    productName: cubit.product.data?.name ?? '',
                                    brandImage:
                                        cubit.product.data?.brandImage ?? '',
                                    image: cubit
                                            .product
                                            .data
                                            ?.variations?[
                                                cubit.selectedVariation]
                                            .productVarientImages?[0]
                                            .imagePath ??
                                        '',
                                    productVariation:
                                        cubit.product.data?.variations?[cubit.selectedVariation].id.toString() ??
                                            '',
                                    quantity: cubit
                                            .product
                                            .data
                                            ?.variations?[cubit.selectedVariation]
                                            .quantity
                                            .toString() ??
                                        '',
                                    price: cubit.product.data?.variations?[cubit.selectedVariation].price.toString() ?? ''));
                              },
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}

String chooseTextButtonCart(context, List<Variations> variations) {
  String text = '';

  if (variations.isNotEmpty &&
      BlocProvider.of<CartCubit>(context).items.isNotEmpty) {
    BlocProvider.of<CartCubit>(context)
        .items
        .asMap()
        .entries
        .forEach((element) {
      print(int.parse(element.value.productVariation));
      if (int.parse(element.value.productVariation) ==
          variations[element.key].id) {
        text = 'Check This Item In Cart';
      } else {
        text = 'Add To Cart';
      }
    });
  } else {
    text = 'Add To Cart';
  }

  return text;
}
