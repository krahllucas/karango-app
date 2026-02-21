import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karango_app/app/models/tirecalibration.dart';
import 'package:karango_app/app/providers/car.dart';
import 'package:karango_app/app/providers/tirecalibration.dart';
import 'package:karango_app/app/widgets/button_form_save.dart';
import 'package:karango_app/app/widgets/tirecalibration_form.dart';
import 'package:provider/provider.dart';

class TireCalibrationAddScreen extends StatefulWidget {
  const TireCalibrationAddScreen({Key? key}) : super(key: key);

  @override
  State<TireCalibrationAddScreen> createState() =>
      _TireCalibrationAddScreenState();
}

class _TireCalibrationAddScreenState extends State<TireCalibrationAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _odometerController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  final _tireFormKey = GlobalKey<TireCalibrationFormWidgetState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final tireDetails = _tireFormKey.currentState?.getTireDetails() ?? [];

      Provider.of<TireCalibrationProvider>(
        context,
        listen: false,
      ).addTireCalibration(
        TireCalibration(
          id: DateTime.now().millisecondsSinceEpoch,
          carId: int.parse(
            context.read<CarProvider>().cars.first.id.toString(),
          ),
          dateTime: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
          odometer: int.parse(_odometerController.text),
          location: _locationController.text,
          notes: _notesController.text,
          details: tireDetails,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Calibração de Pneus')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              // Localização
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Localização',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Notas
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Pressão dos pneus
              TireCalibrationFormWidget(
                key: _tireFormKey,
                tireCount: 4,
              ),

              const SizedBox(height: 16),
              ButtonFormSaveWidget(
                onPressed: _submitForm,
                text: 'Salvar Calibração de Pneus',
              ),
            ],
          ),
        ),
      ),
    );
  }
}