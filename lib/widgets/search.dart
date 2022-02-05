import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 0,right: 10,bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFd0cece),
          ),
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Color(0xFFd0cece), fontSize: 18),
          hintText: "Mau beli apa?",
        ),
      ),
    );
  }
}
