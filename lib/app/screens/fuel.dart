import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/fuel.dart';
import 'package:karango_app/app/core/fueltype.dart';
import 'package:provider/provider.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combustíveis'),
      ),
      body: Consumer<FuelProvider>(
        builder: (context, fuelProvider, child) {
          if (fuelProvider.fuels.isEmpty) {
            return const Center(
              child: Text('Nenhum combustível encontrado'),
            );
          }
          return ListView.builder(
            itemCount: fuelProvider.fuels.length,
            itemBuilder: (context, index) {
              final fuel = fuelProvider.fuels[index];
              return ListTile(
                title: Text(fuel.name),
                subtitle: Text('Tipo: ${Fueltype.getFuelName(fuel.type)}'),
                onTap: () {
                  // Ação ao tocar no item
                },
              );
            },
          );
        },
      ),
    );
  }
}