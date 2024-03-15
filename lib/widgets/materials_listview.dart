import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_cubit.dart';

class MaterialsListView extends StatefulWidget {
  const MaterialsListView({
    super.key,
    required this.cubit,
  });

  final ProductItemScreenCubit cubit;

  @override
  State<MaterialsListView> createState() => _MaterialsListViewState();
}

class _MaterialsListViewState extends State<MaterialsListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Material',
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
                    if (widget.cubit.selectedMaterial != index) {
                      setState(() {
                        widget.cubit.selectedMaterial = index;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                        color: widget.cubit.selectedMaterial == index
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
                              .materials?[index] ??
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
                      .materials
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
