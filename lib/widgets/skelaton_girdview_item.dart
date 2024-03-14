import 'package:flutter/material.dart';

class SkelatonGridViewItem extends StatelessWidget {
  const SkelatonGridViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 130 / 150,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(.8),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 5),
                    child: Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(.8)),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.withOpacity(.9),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(.8)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
