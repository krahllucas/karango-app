import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/car.dart';
import 'package:provider/provider.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (carProvider.cars.isEmpty) {
            return const Center(
              child: Text('Nenhum carro disponível'),
            );
          }
          return ListView.builder(
            itemCount: carProvider.cars.length,
            itemBuilder: (context, index) {
              final car = carProvider.cars[index];
              return ListTile(
                title: Text(car.name),
                subtitle: Text(car.model),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Navegar para detalhes do carro
                },
              );
            },
          );
        },
      ),
    );
  }
}