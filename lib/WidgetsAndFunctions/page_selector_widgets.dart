import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

class BottomNavigationBarPageSelector extends StatefulWidget {
  BottomNavigationBarPageSelector({Key? key}) : super(key: key);
  @override
  State<BottomNavigationBarPageSelector> createState() =>
      _BottomNavigationBarPageSelectorState();
}

class _BottomNavigationBarPageSelectorState
    extends State<BottomNavigationBarPageSelector> {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageSelectMutation]);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: pageIndex,
          onTap: (value) async {
            pageIndex = value;
            PageSelectMutation();
          },
          backgroundColor: darkmode ? Vx.black : Vx.white,
          items: [
            bottomNavigationBarItem(0, "home"),
            bottomNavigationBarItem(1, "popular"),
            bottomNavigationBarItem(2, "book"),
            bottomNavigationBarItem(3, "movie"),
          ]),
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem(
    int itemIndex, String iconName) {
  return BottomNavigationBarItem(
    label: iconName,
    icon: ImageIcon(
      AssetImage("assets/images/icon/"
          "${iconName}_${pageIndex == itemIndex ? "" : "un"}"
          "select.png"),
      size: forHeight(30),
      color: darkmode ? Vx.white : Vx.black,
    ),
  );
}

Future changeMode() async {
  final prefs = await SharedPreferences.getInstance();
  darkmode = prefs.getBool("darkmode") ?? false;
  PageSelectMutation();
}

AppBar appBarForPageSelector() {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: darkmode ? Brightness.light : Brightness.dark),
    toolbarHeight: forHeight(6),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
