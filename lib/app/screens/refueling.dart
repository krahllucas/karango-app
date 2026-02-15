import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:provider/provider.dart';

class RefuelingListScreen extends StatelessWidget {
  const RefuelingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimentos'),
      ),
      body: Consumer<RefuelingProvider>(
        builder: (context, refuelingProvider, child) {
          final refuelings = refuelingProvider.refuelings;

          if (refuelings.isEmpty) {
            return const Center(
              child: Text('Nenhum abastecimento registrado'),
            );
          }

          return ListView.builder(
            itemCount: refuelings.length,
            itemBuilder: (context, index) {
              final refueling = refuelings[index];
              return ListTile(
                title: Text('${refueling.totalCost} L'),
                subtitle: Text(refueling.dateTime.toString()),
                trailing: Text('R\$ ${refueling.pricePerLiter.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}