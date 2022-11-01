import 'package:flutter/material.dart';
import 'package:movie_lister_app/util/globals.dart';
import 'package:movie_lister_app/util/route_genertor.dart';
import 'package:movie_lister_app/util/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: Globals.navigatorKey,
      scaffoldMessengerKey: Globals.scaffoldMessengerKey,
      initialRoute: RouteGenerator.initialRoute,
    );
  }
}
