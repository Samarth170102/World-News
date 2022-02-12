import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/books_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';

class Book extends StatefulWidget {
  Book({Key? key}) : super(key: key);
  @override
  State<Book> createState() => _BookState();
}

bool hasDataCurrentItem = true;
String currentItemEncodeName = "animals";
String currentItemSelected = sectionNames[0]["display_name"];

class _BookState extends State<Book> {
  ScrollController sc = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [SectionSelectMutation, PageIsSetMutation]);
    return ListView(
      controller: sc,
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        sizedBoxForHeight(4),
        shimmerHeading("Popular Books"),
        sizedBoxForHeight(18),
        shimmerRow(),
        sizedBoxForHeight(12),
        containerForBooksBuilder(context)
      ],
    );
  }
}
