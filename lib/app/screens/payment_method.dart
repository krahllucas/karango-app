import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/payment_method.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formas de Pagamento'),
      ),
      body: Consumer<PaymentMethodProvider>(
        builder: (context, paymentMethodProvider, child) {
          if (paymentMethodProvider.paymentMethods.isEmpty) {
            return const Center(
              child: Text('Nenhuma forma de pagamento encontrada'),
            );
          }
          return ListView.builder(
            itemCount: paymentMethodProvider.paymentMethods.length,
            itemBuilder: (context, index) {
              final paymentMethod = paymentMethodProvider.paymentMethods[index];
              return ListTile(
                title: Text(paymentMethod.name),
                subtitle: Text('ID: ${paymentMethod.id}'),
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