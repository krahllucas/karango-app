import 'package:flutter/material.dart';
import 'package:karango_app/app/widgets/appbar.dart';
import 'package:karango_app/app/widgets/bottonbar.dart';
import 'package:karango_app/app/widgets/highlightcard.dart';
import 'package:karango_app/app/widgets/menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      drawer: const MenuWidget(),
      bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
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
                      value: 'R\$ 1.250,00',
                      icon: Icons.attach_money,
                      label: 'Gasto Mensal',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: HighlightCard(
                      value: '6,98 KM/L',
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

            _buildVehicleCard(),
            const SizedBox(height: 24),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações do Veículo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Marca', 'Toyota'),
            _buildInfoRow('Modelo', 'Corolla'),
            _buildInfoRow('Placa', 'ABC-1234'),
            _buildInfoRow('Ano', '2023'),
            _buildInfoRow('Cor', 'Prata'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dados Adicionais',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Quilometragem', '15.000 km'),
        _buildInfoRow('Último Abastecimento', '20/01/2024'),
      ],
    );
  }
}
