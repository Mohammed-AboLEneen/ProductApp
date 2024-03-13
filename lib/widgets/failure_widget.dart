import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_button.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    required this.onPressed,
    required this.errorMessage,
  });

  final void Function() onPressed;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).height * .15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              errorMessage,
              style: GoogleFonts.cairo().copyWith(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 50,
                child: CustomTextButton(
                  text: 'اضغط لاعادة المحاولة',
                  buttonColor: Colors.blue,
                  textColor: Colors.white,
                  topRight: 10,
                  topLeft: 10,
                  bottomRight: 10,
                  bottomLeft: 10,
                  onPressed: onPressed,
                ))
          ],
        ),
      ),
    );
  }
}
