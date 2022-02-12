import 'package:flutter/material.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';
import '../WidgetsAndFunctions/movie_widgets.dart';

class Movie extends StatefulWidget {
  Movie({Key? key}) : super(key: key);
  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  ScrollController sc = ScrollController();
  @override
  void initState() {
    super.initState();
    // sc.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageIsSetMutation]);
    return ListView(
      controller: sc,
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        sizedBoxForHeight(4),
        shimmerHeading("Movie Reviews"),
        sizedBoxForHeight(15),
        containerForMovieBuilder(context)
      ],
    );
  }
}
