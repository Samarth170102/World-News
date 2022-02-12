import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/pages/home.dart';
import 'package:flutter_application_11/pages/page_to_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

Container containerForPopularNewsBuilder(BuildContext context) {
  return Container(
    width: width * 100,
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: popularNewsList.isEmpty ? 3 : popularNewsList.length,
      itemBuilder: (BuildContext context, int topNewsIndex) {
        return shimmerPopularNewsBox(topNewsIndex, context);
      },
    ),
  );
}

Widget shimmerPopularNewsBox(int popularNewsIndex, BuildContext context) {
  return hasData
      ? containerForPopularNewsBox(popularNewsIndex, context)
      : Shimmer.fromColors(
          child: containerForPopularNewsBox(popularNewsIndex, context),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForPopularNewsBox(int popularNewsIndex, BuildContext context) {
  return Material(
      borderRadius: BorderRadius.circular(forHeight(5)),
      elevation: 2,
      child: Container(
        width: forWidth(363),
        height: hasData ? null : forHeight(243),
        child: hasData ? popularNewsDataBox(popularNewsIndex, context) : null,
        decoration: BoxDecoration(
            color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
            borderRadius: BorderRadius.circular(forHeight(5))),
      )).centered().pOnly(bottom: forHeight(8));
}

ClipRRect popularNewsDataBox(int popularNewsIndex, BuildContext context) {
  String url =
      popularNewsList[popularNewsIndex]["media"][0]["media-metadata"][2]["url"];
  String title = popularNewsList[popularNewsIndex]["title"];
  String summary = popularNewsList[popularNewsIndex]["abstract"];
  String byPerson = popularNewsList[popularNewsIndex]["byline"];
  String websiteUrl = popularNewsList[popularNewsIndex]["url"];
  return ClipRRect(
    borderRadius: BorderRadius.circular(forHeight(5)),
    child: GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              child: PageToDetail(
                  title, url, summary, byPerson, websiteUrl, "News"),
              type: PageTransitionType.bottomToTop)),
      child: Column(
        children: [
          Container(
            height: forHeight(189),
            width: forHeight(363),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: width * 100,
            child: Text(
              title,
              style: TextStyle(
                  color: darkmode ? Vx.white : Vx.black,
                  fontSize: forHeight(16)),
            ).pSymmetric(h: forWidth(5), v: forHeight(5)),
          ),
        ],
      ),
    ),
  );
}
