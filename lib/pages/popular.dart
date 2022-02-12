import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/popular_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';
import '../main.dart';

class Popular extends StatefulWidget {
  Popular({Key? key}) : super(key: key);
  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  // popular data box
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageIsSetMutation]);
    return ListView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        sizedBoxForHeight(4),
        shimmerHeading("Popular News"),
        sizedBoxForHeight(15),
        containerForPopularNewsBuilder(context)
      ],
    );
  }
}
