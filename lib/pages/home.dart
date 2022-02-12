import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/home_widgets.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

List<dynamic> topNewsList = [];
List<dynamic> recentNewsList = [];
List<dynamic> popularNewsList = [];
List<dynamic> movieReviewList = [];
List<dynamic> popularBookList = [];

class _HomeState extends State<Home> {
  ScrollController sc = ScrollController();
  @override
  void initState() {
    super.initState();
    // sc.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        controller: sc,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          rowForHome(),
          sizedBoxForHeight(11.5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FutureBuilder(
              future: hasData
                  ? Future.delayed(Duration(seconds: 0), () => true)
                  : Future.wait(getData()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                hasData = snapshot.hasData;
                if (topNewsList.isEmpty && hasData) {
                  setData(snapshot);
                }
                return Column(children: [
                  GestureDetector(
                      onTap: () async {}, child: shimmerHeading("Top News")),
                  sizedBoxForHeight(4),
                  containerForTopNewsBuilder(context),
                  sizedBoxForHeight(13.5),
                  shimmerHeading("Recent News"),
                  sizedBoxForHeight(3),
                  containerForRecentNewsBuilder(context),
                ]);
              },
            ),
          ])
        ]);
  }
}
