import 'package:flutter/material.dart';

import '../constents.dart';
import '../manager/product_item_screen_cubit/product_item_screen_cubit.dart';
import '../methods/hex_to_color.dart';

class ColorsListView extends StatelessWidget {
  const ColorsListView({
    super.key,
    required this.cubit,
  });

  final ProductItemScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              cubit.changeVariation(index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: cubit.selectedVariation == index
                    ? mainColor
                    : Colors.grey.withOpacity(.7),
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: hexToColor(
                      cubit.customVariations[index].color ?? '000000'),
                ),
              ),
            ),
          );
        },
        itemCount: cubit.customVariations.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
