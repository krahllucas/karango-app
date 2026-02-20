import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/servicetype.dart';
import 'package:provider/provider.dart';

class ServiceTypeScreen extends StatelessWidget {
  const ServiceTypeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos de Serviço'),
      ),
      body: Consumer<ServiceTypeProvider>(
        builder: (context, serviceTypeProvider, child) {
          if (serviceTypeProvider.serviceTypes.isEmpty) {
            return const Center(
              child: Text('Nenhum tipo de serviço encontrado'),
            );
          }
          return ListView.builder(
            itemCount: serviceTypeProvider.serviceTypes.length,
            itemBuilder: (context, index) {
              final serviceType = serviceTypeProvider.serviceTypes[index];
              return ListTile(
                title: Text(serviceType.name),
                subtitle: Text('ID: ${serviceType.id}'),
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