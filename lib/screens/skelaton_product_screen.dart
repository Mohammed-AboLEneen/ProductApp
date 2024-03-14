import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constents.dart';
import '../widgets/skelaton_girdview_item.dart';

class SkelatonProductScreen extends StatelessWidget {
  const SkelatonProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      return const SkelatonGridViewItem();
                    },
                    itemCount: 10,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
