import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routing.dart';
import 'package:flutter_application_1/core/utils/string.dart';
// import 'package:flutter_application_1/core/routing/app_router.dart';



void main() {
  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.splash, 
      onGenerateRoute: AppRouter.generateRoute, 
    );
  }
}