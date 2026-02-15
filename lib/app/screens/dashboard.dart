import 'package:flutter/material.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:karango_app/app/widgets/highlightcard.dart';
import 'package:provider/provider.dart';

class HomeDashboardWidget extends StatelessWidget {
  const HomeDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final averageConsumption = context
        .watch<RefuelingProvider>()
        .getAverageConsumption();
    final totalMonthlyCost = context
        .watch<RefuelingProvider>()
        .getTotalMonthlyCost();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: HighlightCard(
                    value: 'R\$ ${totalMonthlyCost.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                    label: 'Gasto Mensal',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: HighlightCard(
                    value: '${averageConsumption.toStringAsFixed(2)} KM/L',
                    icon: Icons.local_gas_station_outlined,
                    label: 'Média de Consumo',
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: HighlightCard(
                    value: 'X dias',
                    icon: Icons.tire_repair_outlined,
                    label: 'Última calibragem',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: HighlightCard(
                    value: 'X KM',
                    icon: Icons.car_repair,
                    label: 'Próximo serviço',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
