import 'package:flutter/material.dart';
import 'package:karango_app/app/core/theme.dart';
import 'package:karango_app/app/providers/expensetype.dart';
import 'package:karango_app/app/providers/fuel.dart';
import 'package:karango_app/app/providers/payment_method.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:karango_app/app/providers/servicetype.dart';
import 'package:karango_app/app/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:karango_app/app/screens/first_access.dart';
import 'package:karango_app/app/providers/car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => RefuelingProvider()),
        ChangeNotifierProvider(create: (_) => FuelProvider()),
        ChangeNotifierProvider(create: (_) => ServiceTypeProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseTypeProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initializeProviders(BuildContext context) async {
    await Provider.of<CarProvider>(context, listen: false).loadCars();
    await Provider.of<RefuelingProvider>(
      context,
      listen: false,
    ).loadRefuelings();
    await Provider.of<FuelProvider>(context, listen: false).loadFuels();
    await Provider.of<ServiceTypeProvider>(context, listen: false).loadServiceTypes();
    await Provider.of<ExpenseTypeProvider>(context, listen: false).loadExpenseTypes();
    await Provider.of<PaymentMethodProvider>(context, listen: false).loadPaymentMethods();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karango',
      theme: themeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
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
                return carProvider.cars.isNotEmpty
                    ? const HomeScreen()
                    : const FirstAccessScreen();
              },
            );
          }
        },
      ),
    );
  }
}
