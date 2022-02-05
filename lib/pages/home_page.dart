import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../firebase/auth.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/loading.dart';
import '../widgets/popular_foods.dart';
import '../widgets/promo_foods.dart';
import '../widgets/search.dart';
import '../widgets/top_menus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFAFAFA),
            elevation: 0,
            title: const Search(),
            actions: <Widget>[
              StreamBuilder(
                stream: AuthService.userStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loading(
                      background: true,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong!"),
                    );
                  } else if (snapshot.hasData) {
                    final authUser = FirebaseAuth.instance.currentUser;
                    return RawMaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          authUser!.photoURL!,
                        ),
                      ),
                      constraints: const BoxConstraints.expand(
                        width: 30,
                        height: 30,
                      ),
                      shape: const CircleBorder(),
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF3a3737),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    );
                  }
                },
              ),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                TopMenus(),
                PopularFoods(),
                PromoFoods(),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavbar(),
        ),
      ),
    );
  }
}
