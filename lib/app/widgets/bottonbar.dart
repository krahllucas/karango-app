import 'package:flutter/material.dart';
import 'package:karango_app/app/core/colors.dart';
import 'package:karango_app/app/screens/refueling.dart';
import 'package:karango_app/app/screens/refueling_add.dart';

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 5, 55, 219), // Força a cor de fundo
      selectedItemColor: Colors.white, // Cor do item selecionado
      unselectedItemColor: Colors.white70, // Cor dos itens não selecionados
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RefuelingListScreen()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
          backgroundColor: AppColors.appColor
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_gas_station),
          label: 'Abastecimentos',
        ),
        BottomNavigationBarItem(
          icon: PopupMenuButton<String>(
            icon: Icon(Icons.add_circle),
            onSelected: (value) {
              // Ação para cada opção selecionada
              if (value == 'Abastecimento') {
                // Navegar ou executar ação para Abastecimento
              } else if (value == 'Despesa') {
                // Navegar ou executar ação para Despesa
              } else if (value == 'Serviço') {
                // Navegar ou executar ação para Serviço
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Abastecimento',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RefuelingScreen()),
                  );
                },
                child: Text('Abastecimento'),
              ),
              PopupMenuItem(
                value: 'Despesa',
                child: Text('Despesa'),
              ),
              PopupMenuItem(
                value: 'Serviço',
                child: Text('Serviço'),
              ),
            ],
          ),
          label: 'Mais',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build),
          label: 'Serviços',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Despesas',
        ),
      ],
    );
  }
}