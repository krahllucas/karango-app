import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/expensetype.dart';
import 'package:provider/provider.dart';

class ExpenseTypeScreen extends StatelessWidget {
  const ExpenseTypeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Despesa'),
      ),
      body: Consumer<ExpenseTypeProvider>(
        builder: (context, expenseTypeProvider, child) {
          if (expenseTypeProvider.expenseTypes.isEmpty) {
            return const Center(
              child: Text('Nenhum tipo de despesa encontrado'),
            );
          }
          return ListView.builder(
            itemCount: expenseTypeProvider.expenseTypes.length,
            itemBuilder: (context, index) {
              final expenseType = expenseTypeProvider.expenseTypes[index];
              return ListTile(
                title: Text(expenseType.name),
                subtitle: Text('ID: ${expenseType.id}'),
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