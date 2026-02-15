import 'package:flutter/material.dart';
import 'package:karango_app/app/screens/dashboard.dart';
import 'package:karango_app/app/screens/refueling.dart';
import 'package:karango_app/app/widgets/appbar.dart';
import 'package:karango_app/app/widgets/bottonbar.dart';
import 'package:karango_app/app/widgets/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboardWidget(),
    const HomeRefuelingWidget(),
    // Adicione outras telas aqui
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      drawer: const MenuWidget(),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: _screens[_currentIndex]
    );
  }
}
