import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/fuel.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:karango_app/app/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:karango_app/app/core/colors.dart';
import 'package:karango_app/app/screens/first_access.dart';
import 'package:karango_app/app/providers/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize your database here before creating providers
  // await yourDatabaseInitializationMethod();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => RefuelingProvider()),
        ChangeNotifierProvider(create: (_) => FuelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initializeProviders(BuildContext context) async {
    await Provider.of<CarProvider>(context, listen: false).loadCars();
    await Provider.of<RefuelingProvider>(context, listen: false).loadRefuelings();
    await Provider.of<FuelProvider>(context, listen: false).loadFuels();
  }

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
      home: FutureBuilder(
        future: _initializeProviders(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados.'));
          } else {
            return Consumer<CarProvider>(
              builder: (context, carProvider, _) {
                return carProvider.cars.isNotEmpty ? const HomeScreen() : const FirstAccessScreen();
              },
            );
          }
        },
      ),
    );
  }
}
