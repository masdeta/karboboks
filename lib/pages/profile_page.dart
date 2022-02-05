import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/auth.dart';
import '../widgets/loading.dart';
import '../constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;
    return authUser != null
        ? SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const ProfilePic(),
                const SizedBox(height: 20),
                ProfileMenu(
                  text: "Akunku",
                  press: () => {},
                ),
                ProfileMenu(
                  text: "Pengaturan",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Bantuan",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Keluar",
                  press: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Keluar"),
                          content: const Text("Apakah kamu ingin keluar?"),
                          actions: [
                            TextButton(
                              child: const Text("Batal",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                "Keluar",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                AuthService.signOut();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        : !loading
            ? Center(
                child: LoginButton(
                  text: 'Masuk dengan Google',
                  handleSignIn: () async {
                    setState(() {
                      loading = true;
                    });
                    bool isOk = await AuthService.googleLogin();
                    if (isOk) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              )
            : const Loading(background: false);
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final Function handleSignIn;

  const LoginButton({
    Key? key,
    required this.text,
    required this.handleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.login,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(18),
          backgroundColor: primaryColor,
        ),
        onPressed: () => handleSignIn(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            // radius: 30,
            backgroundImage: NetworkImage(
              authUser!.photoURL!,
              // scale: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: primaryColor,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: primaryColor.withOpacity(0.04),
        ),
        onPressed: press,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
