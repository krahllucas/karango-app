import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/tirecalibration.dart';
import 'package:provider/provider.dart';

class TireCalibrationListScreen extends StatelessWidget {
  const TireCalibrationListScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibrações de Pneus'),
      ),
      body: FutureBuilder(
        future: Provider.of<TireCalibrationProvider>(context, listen: false).loadTireCalibrationsV2(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar calibrações: ${snapshot.error}'));
          } else {
            return Consumer<TireCalibrationProvider>(
              builder: (context, tireCalibrationProvider, child) {
                if (tireCalibrationProvider.tireCalibrations.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma calibração de pneu encontrada'),
                  );
                }
                return ListView.builder(
                  itemCount: tireCalibrationProvider.tireCalibrations.length,
                  itemBuilder: (context, index) {
                    final tireCalibration = tireCalibrationProvider.tireCalibrations[index];
                    return ListTile(
                      title: Text('Calibração ${tireCalibration.dateTime.toLocal()}'),
                      subtitle: Text('Odometro: ${tireCalibration.odometer} KM - Local: ${tireCalibration.location} - Pneus: ${tireCalibration.details?.map((d) => '${d['position']}: ${d['pressure']} psi').join(', ')}'),
                      onTap: () {
                        // Ação ao tocar no item
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}