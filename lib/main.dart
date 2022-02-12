import 'dart:io';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_11/PageSelector/page_selector.dart';

void main(List<String> args) {
  HttpOverrides.global = MyHttpOverrides();
  runApp(VxState(store: MyStore(), child: MaterialApp(home: MyApp())));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyStore extends VxStore {
  bool pageSelect = true;
  bool sectionSelect = true;
  bool pageIsSet = true;
}

class PageSelectMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.pageSelect = !store.pageSelect;
  }
}

class SectionSelectMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.sectionSelect = !store.sectionSelect;
  }
}

class PageIsSetMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.pageIsSet = !store.pageIsSet;
  }
}

MyStore store = VxState.store;
double height = 0;
double width = 0;
int pageIndex = 0;
bool darkmode = false;
bool hasData = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 100;
    width = MediaQuery.of(context).size.width / 100;
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: PageSelector(),
    );
  }
}
