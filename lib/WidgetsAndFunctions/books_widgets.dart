import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';
import '../pages/book.dart';
import '../pages/page_to_detail.dart';

DropdownButtonHideUnderline dropdownButtonHideUnderlineBooks() {
  return DropdownButtonHideUnderline(
      child: ButtonTheme(
    alignedDropdown: true,
    child: Theme(
      data: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(darkmode ? Vx.white : Vx.black),
        ),
        splashColor: Vx.black.withOpacity(0.1),
        highlightColor: Colors.transparent,
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(forHeight(6)),
        menuMaxHeight: forHeight(350),
        elevation: 1,
        value: currentItemSelected,
        dropdownColor: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
        style: TextStyle(
            color: darkmode ? Vx.white : Vx.black, fontSize: forHeight(17)),
        items: List<DropdownMenuItem<String>>.generate(
            sectionNames.length,
            (indexList) => DropdownMenuItem(
                  child: Text(sectionNames[indexList]["display_name"]),
                  value: sectionNames[indexList]["display_name"],
                )),
        onChanged: (item) async {
          if (item != currentItemSelected) {
            for (var i = 0; i < sectionNames.length; i++) {
              if (sectionNames[i]["display_name"] == item) {
                currentItemEncodeName = sectionNames[i]["list_name_encoded"];
                break;
              }
            }
            currentItemSelected = item.toString();
            hasDataCurrentItem = false;
            SectionSelectMutation();
            Response res = await Dio().get(
                "https://api.nytimes.com/svc/"
                "books/v3/lists/current/$currentItemEncodeName."
                "json?api-key=3ckNEDQARKXcikjqh1CiUwnubTr55KcQ",
                queryParameters: {"offset": 0});
            popularBookList = res.data["results"]["books"];
            hasDataCurrentItem = true;
            SectionSelectMutation();
          }
        },
        icon: ImageIcon(
          AssetImage("assets/images/icon/down_arrow.png"),
          color: darkmode ? Vx.white : Vx.black,
          size: forHeight(15),
        ).pOnly(right: forWidth(8), bottom: forHeight(2.5)),
      ),
    ),
  ));
}

Text sectionText() {
  return Text(
    "Section",
    style: TextStyle(
      color: darkmode ? Vx.white : Vx.black,
      fontSize: forHeight(23),
    ),
  );
}

Widget shimmerSectionText() {
  return hasData
      ? sectionText()
      : Shimmer.fromColors(
          child: sectionText(),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Material DropdownContainer() {
  return Material(
    borderRadius: BorderRadius.circular(forHeight(6)),
    elevation: forHeight(1),
    child: Container(
      width: forWidth(222),
      height: forHeight(60),
      decoration: BoxDecoration(
        color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
        borderRadius: BorderRadius.circular(forHeight(6)),
      ),
      child: dropdownButtonHideUnderlineBooks(),
    ),
  );
}

Padding shimmerRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [shimmerSectionText(), shimmerDropdownBox()],
  ).pSymmetric(h: forWidth(11));
}

Widget shimmerDropdownBox() {
  return hasData
      ? DropdownContainer()
      : Shimmer.fromColors(
          child: DropdownContainer(),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233));
}

Container containerForBooksBuilder(BuildContext context) {
  return Container(
    width: width * 100,
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: popularBookList.isEmpty ? 3 : popularBookList.length,
      itemBuilder: (BuildContext context, int popularBookIndex) {
        return shimmerBooksBox(popularBookIndex, context);
      },
    ),
  );
}

Widget shimmerBooksBox(int popularBookIndex, BuildContext context) {
  return hasData & hasDataCurrentItem
      ? containerForBooksBox(popularBookIndex, context)
      : Shimmer.fromColors(
          child: containerForBooksBox(popularBookIndex, context),
          highlightColor:
              darkmode ? Color.fromARGB(255, 124, 124, 124) : Vx.white,
          baseColor: darkmode
              ? Color.fromARGB(255, 68, 68, 68)
              : Color.fromARGB(246, 233, 233, 233),
        );
}

Padding containerForBooksBox(int popularBookIndex, BuildContext context) {
  return Material(
      borderRadius: BorderRadius.circular(forHeight(5)),
      elevation: forHeight(2),
      child: Container(
        width: forWidth(360),
        height: hasData ? null : forHeight(214),
        child: hasData ? popularBookDataBox(popularBookIndex, context) : null,
        decoration: BoxDecoration(
            color: darkmode ? Color.fromARGB(255, 68, 68, 68) : Vx.white,
            borderRadius: BorderRadius.circular(forHeight(5))),
      )).centered().pOnly(bottom: forHeight(8));
}

ClipRRect popularBookDataBox(int popularBookIndex, BuildContext context) {
  String url = popularBookList[popularBookIndex]["book_image"];
  String title = popularBookList[popularBookIndex]["title"];
  String author = popularBookList[popularBookIndex]["author"];
  String description = popularBookList[popularBookIndex]["description"];
  String buylink = popularBookList[popularBookIndex]["amazon_product_url"];

  return ClipRRect(
    borderRadius: BorderRadius.circular(forHeight(5)),
    child: GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
              child: PageToDetail(
                  title, url, description, author, buylink, "Book"),
              type: PageTransitionType.bottomToTop)),
      child: Row(
        children: [
          Container(
            height: forHeight(214),
            width: forWidth(142),
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(url),
            )),
          ),
          sizedBoxForWidth(10),
          Container(
            height: forHeight(214),
            width: forWidth(208),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxForHeight(10),
                bookDataColumn("Book", title),
                sizedBoxForHeight(10),
                bookDataColumn("Author", author),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Column bookDataColumn(String type, String typeData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        type,
        style: TextStyle(
            fontSize: forHeight(20),
            fontWeight: FontWeight.w600,
            color: darkmode ? Vx.white : Vx.black),
      ),
      Text(
        typeData,
        style: TextStyle(
            fontSize: forHeight(16), color: darkmode ? Vx.white : Vx.black),
      ),
    ],
  );
}

List<dynamic> sectionNames = [
  {
    "list_name": "Animals",
    "display_name": "Animals",
    "list_name_encoded": "animals",
    "oldest_published_date": "2014-09-07",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Manga",
    "display_name": "Manga",
    "list_name_encoded": "manga",
    "oldest_published_date": "2009-03-15",
    "newest_published_date": "2017-01-29",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Audio Fiction",
    "display_name": "Audio Fiction",
    "list_name_encoded": "audio-fiction",
    "oldest_published_date": "2018-03-11",
    "newest_published_date": "2022-02-13",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Business Books",
    "display_name": "Business",
    "list_name_encoded": "business-books",
    "oldest_published_date": "2013-11-03",
    "newest_published_date": "2022-02-13",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Celebrities",
    "display_name": "Celebrities",
    "list_name_encoded": "celebrities",
    "oldest_published_date": "2014-09-07",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Hardcover Advice",
    "display_name": "Hardcover Advice",
    "list_name_encoded": "hardcover-advice",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2013-04-21",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Paperback Advice",
    "display_name": "Paperback Advice",
    "list_name_encoded": "paperback-advice",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2013-04-21",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Picture Books",
    "display_name": "Picture Books",
    "list_name_encoded": "picture-books",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2022-02-20",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Sports",
    "display_name": "Sports",
    "list_name_encoded": "sports",
    "oldest_published_date": "2014-03-02",
    "newest_published_date": "2019-09-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Family",
    "display_name": "Family",
    "list_name_encoded": "family",
    "oldest_published_date": "2014-09-07",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Science",
    "display_name": "Science",
    "list_name_encoded": "science",
    "oldest_published_date": "2013-04-14",
    "newest_published_date": "2019-09-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Series Books",
    "display_name": "Children’s Series",
    "list_name_encoded": "series-books",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2022-02-20",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Young Adult",
    "display_name": "Young Adult",
    "list_name_encoded": "young-adult",
    "oldest_published_date": "2012-12-16",
    "newest_published_date": "2015-08-23",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Culture",
    "display_name": "Culture",
    "list_name_encoded": "culture",
    "oldest_published_date": "2014-10-12",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Chapter Books",
    "display_name": "Chapter Books",
    "list_name_encoded": "chapter-books",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2012-12-09",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Paperback Books",
    "display_name": "Paperback Books",
    "list_name_encoded": "paperback-books",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2012-12-09",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Education",
    "display_name": "Education",
    "list_name_encoded": "education",
    "oldest_published_date": "2014-10-12",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Food and Fitness",
    "display_name": "Food and Diet",
    "list_name_encoded": "food-and-fitness",
    "oldest_published_date": "2013-09-01",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Health",
    "display_name": "Health",
    "list_name_encoded": "health",
    "oldest_published_date": "2014-10-12",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Hardcover Fiction",
    "display_name": "Hardcover Fiction",
    "list_name_encoded": "hardcover-fiction",
    "oldest_published_date": "2008-06-08",
    "newest_published_date": "2022-02-20",
    "updated": "WEEKLY"
  },
  {
    "list_name": "E-Book Fiction",
    "display_name": "E-Book Fiction",
    "list_name_encoded": "e-book-fiction",
    "oldest_published_date": "2011-02-13",
    "newest_published_date": "2017-01-29",
    "updated": "WEEKLY"
  },
  {
    "list_name": "Humor",
    "display_name": "Humor",
    "list_name_encoded": "humor",
    "oldest_published_date": "2014-09-07",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
  {
    "list_name": "Travel",
    "display_name": "Travel",
    "list_name_encoded": "travel",
    "oldest_published_date": "2014-09-07",
    "newest_published_date": "2017-01-15",
    "updated": "MONTHLY"
  },
];
