// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/page_selector_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';

class PageToDetail extends StatelessWidget {
  String imageUrl;
  String title;
  String summary;
  String byPerson;
  String websiteUrl;
  String type;
  PageToDetail(this.title, this.imageUrl, this.summary, this.byPerson,
      this.websiteUrl, this.type);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkmode ? Vx.black : Vx.white,
      appBar: appBarForPageSelector(),
      body: Container(
        width: width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: forHeight(28),
                width: forHeight(28),
                child: Image.asset(
                  "assets/images/icon/back.png",
                  color: darkmode ? Vx.white : Vx.black,
                ),
              ).pOnly(left: forWidth(5)),
            ),
            sizedBoxForHeight(10),
            Container(
              height: forHeight(286),
              width: width * 100,
              child: CachedNetworkImage(
                  fit: type == "Book" ? BoxFit.contain : BoxFit.cover,
                  imageUrl: imageUrl),
            ),
            sizedBoxForHeight(10),
            Text(
              title,
              style: TextStyle(
                  fontSize: forHeight(22),
                  fontWeight: FontWeight.w700,
                  color: darkmode ? Vx.white : Vx.black),
            ).pSymmetric(h: forWidth(6)),
            sizedBoxForHeight(30),
            Text(
              summary,
              style: TextStyle(
                  fontSize: forHeight(17),
                  color: darkmode ? Vx.white : Vx.black),
            ).pSymmetric(h: forWidth(6)),
            sizedBoxForHeight(10),
            Text(
              "-" + byPerson,
              style: TextStyle(
                  fontSize: forHeight(15),
                  color: darkmode ? Vx.white : Vx.black),
            ).pSymmetric(h: forWidth(6)).objectBottomRight(),
            Spacer(),
            GestureDetector(
              onTap: () async {
                await launch(websiteUrl);
              },
              child: Text(
                type == "Book" ? "Buy The Book" : "Read Whole $type",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: forHeight(22), color: Vx.blue600),
              ).centered(),
            ),
            sizedBoxForHeight(40),
          ],
        ),
      ),
    );
  }
}
