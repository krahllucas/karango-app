import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:karango_app/app/models/refueling.dart';
import 'package:karango_app/app/providers/car.dart';
import 'package:karango_app/app/providers/fuel.dart';
import 'package:karango_app/app/providers/refueling.dart';
import 'package:provider/provider.dart';

class RefuelingScreen extends StatefulWidget {
  const RefuelingScreen({Key? key}) : super(key: key);

  @override
  State<RefuelingScreen> createState() => _RefuelingScreenState();
}

class _RefuelingScreenState extends State<RefuelingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _odometerController = TextEditingController();
  final _priceController = TextEditingController();
  final _totalController = TextEditingController();
  final _litersController = TextEditingController();
  final _locationController = TextEditingController();

  int _selectedFuelId = 1;
  bool _isFullTank = false;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _priceController.dispose();
    _totalController.dispose();
    _litersController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Implementar lógica de salvamento
      Provider.of<RefuelingProvider>(context, listen: false).addRefueling(
        Refueling(
          carId: context.read<CarProvider>().cars.first.id,
          dateTime: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
          odometer: int.parse(_odometerController.text),
          fuelId: _selectedFuelId,
          pricePerLiter: double.parse(_priceController.text),
          totalCost: double.parse(_totalController.text),
          liters: double.parse(_litersController.text),
          location: _locationController.text,
          isFullTank: _isFullTank,
        ),
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reabastecimento salvo com sucesso!')),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar reabastecimento: $error')),
        );
      });
    }
  }

  void _updateCalculations(String lastModifiedField) {
    final price = double.tryParse(_priceController.text) ?? 0;
    final liters = double.tryParse(_litersController.text) ?? 0;
    final total = double.tryParse(_totalController.text) ?? 0;

    if (lastModifiedField == 'price' && price > 0 && liters > 0) {
      _totalController.text = (price * liters).toStringAsFixed(2);
    } else if (lastModifiedField == 'liters' && price > 0 && liters > 0) {
      _totalController.text = (price * liters).toStringAsFixed(2);
    } else if (lastModifiedField == 'total' && total > 0) {
      if (liters > 0) {
        _priceController.text = (total / liters).toStringAsFixed(2);
      } else if (price > 0) {
        _litersController.text = (total / price).toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reabastecimento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Carro
              DropdownButtonFormField<String>(
                value: context.watch<CarProvider>().cars.isNotEmpty
                    ? context.watch<CarProvider>().cars.first.id.toString()
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Carro',
                  border: OutlineInputBorder(),
                ),
                items: context.watch<CarProvider>().cars.map((car) {
                  return DropdownMenuItem(
                    value: car.id.toString(),
                    child: Text(car.name),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle car selection
                },
                validator: (value) =>
                    value == null ? 'Selecione um carro' : null,
              ),
              const SizedBox(height: 16),
              // Data e Hora
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      '${_selectedTime.format(context)} ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                ),
                decoration: InputDecoration(
                  labelText: 'Hora e Data',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );

                    if (pickedTime != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _selectedTime = pickedTime;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              // Odômetro
              TextFormField(
                controller: _odometerController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Odômetro (km)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              // Tipo de Combustível
              DropdownButtonFormField<int>(
                value: context.watch<FuelProvider>().getFuelsByTypes(context.read<CarProvider>().cars.first.fuelTypes)
                    .any((fuel) => fuel.id == _selectedFuelId)
                    ? _selectedFuelId
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Combustível',
                  border: OutlineInputBorder(),
                ),
                items: context.watch<FuelProvider>().getFuelsByTypes(context.read<CarProvider>().cars.first.fuelTypes).map((fuel) {
                  return DropdownMenuItem(
                    value: fuel.id,
                    child: Text(fuel.name),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => _selectedFuelId = value ?? 1),
              ),
              const SizedBox(height: 16),
              // Preço por Litro e Quantidade de Litros
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Preço por Litro (R\$)',
                        border: OutlineInputBorder(),
                      ),
                      onEditingComplete: () => _updateCalculations('price'),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _litersController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Quantidade (L)',
                        border: OutlineInputBorder(),
                      ),
                      onEditingComplete: () => _updateCalculations('liters'),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Valor Total
              TextFormField(
                controller: _totalController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Valor Total (R\$)',
                  border: OutlineInputBorder(),
                ),
                onEditingComplete: () => _updateCalculations('total'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              // Switch - Tanque Completo
              SwitchListTile(
                title: const Text('Tanque Completo'),
                value: _isFullTank,
                onChanged: (value) => setState(() => _isFullTank = value),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              // Local do Abastecimento
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Local do Abastecimento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 24),
              // Botão Salvar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white, // Set text color here
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _submitForm,
                child: const Text('Salvar Reabastecimento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
