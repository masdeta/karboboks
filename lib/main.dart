import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase/firestore.dart';
import 'pages/cart_page.dart';
import 'pages/intro_page.dart';
import 'pages/profile_page.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'store/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Store>(
          create: (context) => Store(),
        ),
        FutureProvider<Map<String, dynamic>?>(
          create: (context) => FirestoreService.fetchQuantity(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KarboBoks',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/intro': (context) => const IntroPage(),
          '/signin': (context) => const SignInPage(),
          '/signup': (context) => const SignUpPage(),
          '/profile': (context) => const ProfilePage(),
          '/cart': (context) => const CartPage(),
          '/detail': (context) => const DetailsPage(),
        },
      ),
    );
  }
}
