import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncrementalContainer extends StatefulWidget {
  final int limitQuantity;
  final int price;

  const IncrementalContainer(
      {super.key, required this.limitQuantity, required this.price});

  @override
  State<IncrementalContainer> createState() => _IncrementalContainerState();
}

class _IncrementalContainerState extends State<IncrementalContainer> {
  int currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('EGP ${widget.price * currentValue}',
            style: GoogleFonts.cairo().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16)),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: SizedBox(
            width: 80,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentValue > 1) {
                      currentValue--;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
                const Spacer(),
                Text(
                  currentValue.toString(),
                  style: GoogleFonts.cairo().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (currentValue < widget.limitQuantity) {
                      currentValue++;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white.withOpacity(.8),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
