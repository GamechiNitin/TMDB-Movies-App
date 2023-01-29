import 'dart:async';
import 'package:tmdb/utils/imports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() async {
    Timer(const Duration(seconds: 2), gotoHomePage);
  }



  gotoHomePage() {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: const TextSpan(
            text: 'TMDB',
            style: TextStyle(
              fontSize: 20,
              color: kBlackColor,
            ),
            children: [
              TextSpan(
                text: 'Movies',
                style: TextStyle(
                  fontSize: 20,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
