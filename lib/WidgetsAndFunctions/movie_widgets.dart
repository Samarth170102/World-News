import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/pages/home.dart';
import 'package:flutter_application_11/pages/page_to_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

Container containerForMovieBuilder(BuildContext context) {
  return Container(
    width: width * 100,
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: movieReviewList.isEmpty ? 3 : movieReviewList.length,
      itemBuilder: (BuildContext context, int movieReviewIndex) {
        return shimmerMovieBox(movieReviewIndex, context);
      },
    ),
  );
}

Widget shimmerMovieBox(int movieReviewIndex, BuildContext context) {
  return hasData
      ? containerForMovieBox(movieReviewIndex, context)
      : Shimmer.fromColors(
          child: containerForMovieBox(movieReviewIndex, context),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForMovieBox(int movieReviewIndex, BuildContext context) {
  return Material(
      borderRadius: BorderRadius.circular(forHeight(5)),
      elevation: 2,
      child: Container(
        width: forWidth(363),
        height: hasData ? null : forHeight(218),
        child: hasData ? movieReviewDataBox(movieReviewIndex, context) : null,
        decoration: BoxDecoration(
            color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
            borderRadius: BorderRadius.circular(forHeight(5))),
      )).centered().pOnly(bottom: forHeight(8));
}

ClipRRect movieReviewDataBox(int movieReviewIndex, BuildContext context) {
  String url = movieReviewList[movieReviewIndex]["multimedia"]['src'];
  String headline = movieReviewList[movieReviewIndex]["headline"];
  String summary = movieReviewList[movieReviewIndex]["summary_short"];
  String byPerson = movieReviewList[movieReviewIndex]["byline"];
  String websiteUrl = movieReviewList[movieReviewIndex]["link"]["url"];
  return ClipRRect(
    borderRadius: BorderRadius.circular(forHeight(5)),
    child: GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              child: PageToDetail(headline, url, summary, "By " + byPerson,
                  websiteUrl, "Movie Review"),
              type: PageTransitionType.bottomToTop)),
      child: Column(
        children: [
          Container(
            height: forHeight(185),
            width: forWidth(363),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: width * 100,
            child: Text(
              headline,
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
