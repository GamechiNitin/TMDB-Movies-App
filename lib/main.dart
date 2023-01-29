import 'package:tmdb/utils/imports.dart';
import 'package:tmdb/view/splash_page.dart';
import 'package:tmdb/view/widget/scroll_widget.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

FocusNode fn = FocusNode();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'TMDB Movies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: kPrimaryColor,
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: ScrollWidget(),
            child: child!,
          );
        },
        home: const SplashPage(),
      ),
    );
  }
}
