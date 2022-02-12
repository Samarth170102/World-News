// ignore_for_file: empty_catches
import 'package:flutter/material.dart';
import 'package:flutter_application_11/pages/book.dart';
import 'package:flutter_application_11/pages/home.dart';
import 'package:flutter_application_11/pages/movie.dart';
import 'package:flutter_application_11/pages/popular.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/page_selector_widgets.dart';
import '../main.dart';

class PageSelector extends StatefulWidget {
  PageSelector({Key? key}) : super(key: key);
  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  @override
  void initState() {
    super.initState();
    changeMode();
  }
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageSelectMutation]);
    return Scaffold(
      backgroundColor: darkmode ? Vx.black : Color.fromARGB(246, 240, 240, 240),
      appBar: appBarForPageSelector(),
      body: IndexedStack(
        index: pageIndex,
        children: [Home(), Popular(), Book(), Movie()],
      ),
      bottomNavigationBar: BottomNavigationBarPageSelector(),
    );
  }
}
