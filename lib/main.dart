import 'package:flutter/material.dart';
import 'package:important_app/app_router.dart';
import 'package:important_app/constants/my_colors.dart';

void main() {
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({required this.appRouter, Key? key}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: MyColors.myGrey,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
