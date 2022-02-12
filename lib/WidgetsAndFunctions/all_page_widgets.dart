import 'package:flutter/material.dart';
import 'package:flutter_application_11/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

double forHeight(double size) {
  return (size / 8.533333333333333) * height;
}

double forWidth(double size) {
  return (size / 3.84) * width;
}

SizedBox sizedBoxForHeight(double height) {
  return SizedBox(
    height: forHeight(height),
  );
}

SizedBox sizedBoxForWidth(double width) {
  return SizedBox(
    width: forWidth(width),
  );
}

Future changeMode() async {
  final pref = await SharedPreferences.getInstance();
  darkmode = pref.getBool("darkmode") ?? false;
  PageSelectMutation();
}

Widget shimmerHeading(String heading) {
  return hasData
      ? containerForHeading(heading).objectCenterLeft()
      : Shimmer.fromColors(
          child: containerForHeading(heading).objectCenterLeft(),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForHeading(String heading) {
  return Text(
    heading,
    style: TextStyle(
      color: darkmode ? Vx.white : Vx.black,
      fontSize: forHeight(30),
      fontWeight: FontWeight.w700,
    ),
  ).pOnly(left: forWidth(8));
}
