import 'package:flutter/material.dart';

class TopMenus extends StatefulWidget {
  const TopMenus({Key? key}) : super(key: key);

  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          TopMenuTiles(name: "Karbo", imageUrl: "rice-illustration", slug: ""),
          TopMenuTiles(name: "Protein", imageUrl: "soybean-illustration", slug: ""),
          TopMenuTiles(name: "Olahan", imageUrl: "jam-illustration", slug: ""),
          TopMenuTiles(name: "Jajanan", imageUrl: "chips-illustration", slug: ""),
        ],
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String slug;

  const TopMenuTiles(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Image.asset(
                    'assets/images/illustration/' + imageUrl + ".jpg",
                    width: 24,
                    height: 24,
                  )),
                )),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF6e6e71),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
