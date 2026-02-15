import 'package:flutter/material.dart';
import 'package:karango_app/app/core/colors.dart';
import 'package:karango_app/app/screens/fuel.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.gray,
            ),
            child: SizedBox(
              height: 50,
              child: Image.asset('assets/banner_2.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Veículos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Combustíveis'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FuelScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Postos de Combustíveis'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Tipos de Serviços'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Tipos de Despesas'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Formas de Pagamentos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}