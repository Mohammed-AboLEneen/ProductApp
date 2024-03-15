import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_cubit.dart';

class SizesListView extends StatefulWidget {
  const SizesListView({
    super.key,
    required this.cubit,
  });

  final ProductItemScreenCubit cubit;

  @override
  State<SizesListView> createState() => _SizesListViewState();
}

class _SizesListViewState extends State<SizesListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Size',
              style: GoogleFonts.cairo().copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.cubit.selectedSize != index) {
                      setState(() {
                        widget.cubit.selectedSize = index;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                        color: widget.cubit.selectedSize == index
                            ? mainColor
                            : Colors.grey.withOpacity(.7),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget
                              .cubit
                              .customVariations[widget.cubit.selectedVariation]
                              .sizes?[index] ??
                          '-----',
                      style: GoogleFonts.cairo().copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(.85),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget
                      .cubit
                      .customVariations[widget.cubit.selectedVariation]
                      .sizes
                      ?.length ??
                  0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
