import 'package:flutter/material.dart';
import '../widgets/default_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: mediaQuery.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* <----------- Image and Text Section ------------> */
              Container(
                height: mediaQuery.height * 0.8,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/intro_image.png',
                      width: 500,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Lorem ipsum',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Lorem ipsum',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              /* <----------- Bottom Section ------------> */
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: DefaultButton(
                  text: "Selanjutnya",
                  press: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
