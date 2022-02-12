import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/pages/home.dart';
import 'package:flutter_application_11/pages/page_to_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

Padding rowForHome() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          height: forHeight(33.5),
          width: forHeight(33.5),
          color: Colors.transparent,
          child: Image.asset(
            "assets/images/logo/icon_logo.png",
            color: darkmode ? Vx.white : Vx.black,
          )),
      GestureDetector(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          darkmode = !darkmode;
          prefs.setBool("darkmode", darkmode);
          PageSelectMutation();
        },
        child: Container(
          height: forHeight(33.5),
          width: forHeight(33.5),
          color: Colors.transparent,
          child: Image.asset(
            "assets/images/icon/${darkmode ? "dark" : "light"}.png",
            color: darkmode ? Vx.white : Vx.black,
          ),
        ),
      )
    ],
  ).pSymmetric(h: forWidth(8));
}

Widget shimmerTopNewzBox(int topNewsIndex, BuildContext context) {
  return hasData
      ? containerForTopNewsBox(topNewsIndex, context)
      : Shimmer.fromColors(
          child: containerForTopNewsBox(topNewsIndex, context),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForTopNewsBox(int topNewsIndex, BuildContext context) {
  return Material(
          borderRadius: BorderRadius.circular(forHeight(5)),
          elevation: 2,
          child: Container(
              height: forHeight(218),
              width: forHeight(280),
              decoration: BoxDecoration(
                  color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
                  borderRadius: BorderRadius.circular(forHeight(5))),
              child: hasData ? topNewsDataBox(topNewsIndex, context) : null))
      .centered()
      .pOnly(left: topNewsIndex == 0 ? forWidth(12) : 0, right: forWidth(8));
}

ClipRRect topNewsDataBox(int topNewsIndex, BuildContext context) {
  String url = topNewsList[topNewsIndex]["multimedia"][0]["url"];
  String title = topNewsList[topNewsIndex]["title"];
  String summary = topNewsList[topNewsIndex]["abstract"];
  String byPerson = topNewsList[topNewsIndex]["byline"];
  String websiteUrl = topNewsList[topNewsIndex]["url"];
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
            height: forHeight(145),
            width: forHeight(280),
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
            ).pSymmetric(h: forWidth(5)).pOnly(top: forHeight(4)),
          ),
        ],
      ),
    ),
  );
}

Container containerForTopNewsBuilder(BuildContext context) {
  return Container(
    height: forHeight(225),
    width: width * 100,
    child: ListView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: topNewsList.isEmpty ? 3 : topNewsList.length,
      itemBuilder: (BuildContext context, int topNewsIndex) {
        return shimmerTopNewzBox(topNewsIndex, context);
      },
    ),
  );
}

Container containerForRecentNewsBuilder(BuildContext context) {
  return Container(
    width: width * 100,
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recentNewsList.isEmpty ? 3 : recentNewsList.length,
      itemBuilder: (BuildContext context, int recentNewsIndex) {
        return shimmerRecentNewzBox(recentNewsIndex, context);
      },
    ),
  );
}

Widget shimmerRecentNewzBox(int recentNewsIndex, BuildContext context) {
  return hasData
      ? containerForRecentNewsBox(recentNewsIndex, context)
      : Shimmer.fromColors(
          child: containerForRecentNewsBox(recentNewsIndex, context),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForRecentNewsBox(int recentNewsIndex, BuildContext context) {
  return Material(
          borderRadius: BorderRadius.circular(forHeight(5)),
          elevation: 2,
          child: Container(
              height: hasData ? null : forHeight(240),
              width: forWidth(363),
              decoration: BoxDecoration(
                  color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
                  borderRadius: BorderRadius.circular(forHeight(5))),
              child:
                  hasData ? recentNewsDataBox(recentNewsIndex, context) : null))
      .centered()
      .pOnly(bottom: forHeight(8));
}

ClipRRect recentNewsDataBox(int recentNewsIndex, BuildContext context) {
  String url = recentNewsList[recentNewsIndex]["multimedia"][2]["url"];
  String title = recentNewsList[recentNewsIndex]["title"];
  String summary = recentNewsList[recentNewsIndex]["multimedia"][0]["caption"];
  String byPerson = recentNewsList[recentNewsIndex]["byline"];
  String websiteUrl = recentNewsList[recentNewsIndex]["url"];
  byPerson = byPerson.toLowerCase();
  List byPersonSplit = byPerson.split(" ");
  for (var i = 0; i < byPersonSplit.length; i++) {
    byPersonSplit[i] = byPersonSplit[i].toString().firstLetterUpperCase();
  }
  byPerson = byPersonSplit.join(" ");
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
            height: forHeight(190),
            width: forWidth(363),
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
            ).pSymmetric(h: forWidth(5), v: forHeight(4)),
          ),
        ],
      ),
    ),
  );
}

Iterable<Future> getData() {
  return [
    Dio().get("https://api.nytimes.com/svc/"
        "topstories/v2/home.json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ"),
    Dio().get(
        "https://api.nytimes.com/svc/"
        "news/v3/content/all/world.json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ",
        queryParameters: {"limit": 100, "offset": 0}),
    Dio().get("https://api.nytimes.com/svc/"
        "mostpopular/v2/shared/1.json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ"),
    Dio().get(
        "https://api.nytimes.com/svc/"
        "books/v3/lists/current/animals.json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ",
        queryParameters: {"offset": 0}),
    Dio().get(
        "https://api.nytimes.com/svc/"
        "movies/v2/reviews/all.json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ",
        queryParameters: {"offset": 0, "order": "by-opening-date"}),
  ];
}

void setData(AsyncSnapshot snapshot) {
  List responseList = snapshot.data;
  Response topNewsResponse = responseList[0];
  Response recentNewsResponse = responseList[1];
  Response popularNewsResponse = responseList[2];
  Response popularBookResponse = responseList[3];
  Response movieReviewResponse = responseList[4];
  if (topNewsResponse.statusCode == 200) {
    List<dynamic> allListDataTopNews = topNewsResponse.data["results"];
    List<dynamic> tempList = [];
    if (allListDataTopNews.length > 10) {
      for (var item in allListDataTopNews) {
        String title = item["title"];
        final span = TextSpan(text: title);
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: forHeight(400));
        if (tp.width == 400) {
          tempList.add(item);
        }
      }
      if (tempList.length > 10) {
        topNewsList = tempList.sublist(0, 10);
      } else {
        topNewsList = tempList;
      }
    } else {
      topNewsList = allListDataTopNews;
    }
  } else {
    topNewsList = [];
  }
  if (recentNewsResponse.statusCode == 200) {
    List<dynamic> allListDataRecentNews = recentNewsResponse.data["results"];
    for (var item in allListDataRecentNews) {
      String title = item["title"];
      if (item["multimedia"] != null &&
          (title.contains("a") || title.contains("e"))) {
        recentNewsList.add(item);
      }
    }
  } else {
    recentNewsList = [];
  }
  if (popularNewsResponse.statusCode == 200) {
    List<dynamic> allListDataPopularNews = popularNewsResponse.data["results"];
    popularNewsList = allListDataPopularNews;
  } else {
    popularNewsList = [];
  }
  if (popularBookResponse.statusCode == 200) {
    List<dynamic> allListDataPopularBook =
        popularBookResponse.data["results"]["books"];
    popularBookList = allListDataPopularBook;
  } else {
    popularBookList = [];
  }
  if (movieReviewResponse.statusCode == 200) {
    List<dynamic> allListDataMovieReview = movieReviewResponse.data["results"];
    movieReviewList = allListDataMovieReview;
  } else {
    movieReviewList = [];
  }
  Future.delayed(Duration(seconds: 1), () => PageIsSetMutation());
}
