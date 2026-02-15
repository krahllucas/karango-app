import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:karango_app/app/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:karango_app/app/core/colors.dart';
import 'package:karango_app/app/screens/first_access.dart';
import 'package:karango_app/app/providers/car.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => RefuelingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karango',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.appColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: Consumer<CarProvider>(
        builder: (context, carProvider, _) {
          return carProvider.cars.isNotEmpty ? const HomeScreen() : const FirstAccessScreen();
        },
      ),
    );
  }
}
