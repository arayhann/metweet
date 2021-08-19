import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metweet/pages/home_page.dart';
import 'package:metweet/pages/on_boarding_page.dart';
import 'package:metweet/providers/auth.dart';
import 'package:metweet/utils/themes.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('metweet');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'metweet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = useState<bool?>(null);

    useEffect(() {
      Future.delayed(Duration.zero).then((_) {
        isAuth.value = ref.read(authProvider.notifier).tryAutoLogin();
      });
      return;
    }, []);
    return isAuth.value == null
        ? Scaffold()
        : isAuth.value!
            ? HomePage()
            : OnBoardingPage();
  }
}
