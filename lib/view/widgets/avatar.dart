import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';

class Avatar extends StatelessWidget {
  final double w;
  final double h;
  final String? img;
  const Avatar({Key? key, this.h = 50, this.w = 50, this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: w + 5,
          height: h + 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
            border: Border.all(color: primaryColor),
          ),
        ),
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
            image: img != null
                ? DecorationImage(image: NetworkImage(img!))
                : const DecorationImage(image: AssetImage('assets/avatar.jpg')),
          ),
        )
      ],
    );
  }
}
