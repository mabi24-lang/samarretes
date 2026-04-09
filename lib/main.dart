import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculadora_samarretes.dart';

void main() {
  runApp(const SamarretesApp());
}

class SamarretesApp extends StatelessWidget {
  const SamarretesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Samarretes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final CalculadoraSamarretes _calc = CalculadoraSamarretes();
  final TextEditingController _numeroController = TextEditingController();

  ShirtSize? _tallaSeleccionada;
  DiscountType _descompte = DiscountType.none;

  String _preuText = '--';

  void _actualitzaPreu() {
    final text = _numeroController.text.trim();
    if (text.isEmpty || _tallaSeleccionada == null) {
      setState(() => _preuText = '--');
      return;
    }

    final numero = int.tryParse(text);
    if (numero == null || numero < 0) {
      setState(() => _preuText = 'Nombre no vàlid');
      return;
    }

    final preu = _calc.preuDefinitiu(numero, _tallaSeleccionada!, _descompte);
    setState(() => _preuText = '${preu.toStringAsFixed(2)} €');
  }

  @override
  void initState() {
    super.initState();
    _numeroController.addListener(_actualitzaPreu);
  }

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Samarretes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre de samarretes
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Nombre de samarretes',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_cart),
              ),
            ),
            const SizedBox(height: 24),

            // Talla (RadioButtons)
            const Text('Talla:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTallaRadio('Petita (7.99€)', ShirtSize.small),
                _buildTallaRadio('Mitjana (9.95€)', ShirtSize.medium),
                _buildTallaRadio('Gran (13.50€)', ShirtSize.large),
              ],
            ),
            const SizedBox(height: 24),

            // Descompte (Dropdown)
            DropdownButtonFormField<DiscountType>(
              value: _descompte,
              decoration: const InputDecoration(
                labelText: 'Descompte',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.discount),
              ),
              items: const [
                DropdownMenuItem(value: DiscountType.none, child: Text('Cap descompte')),
                DropdownMenuItem(value: DiscountType.tenPercent, child: Text('Descompte del 10%')),
                DropdownMenuItem(value: DiscountType.twentyEurosOver100, child: Text('20€ per comandes > 100€')),
              ],
              onChanged: (value) {
                _descompte = value ?? DiscountType.none;
                _actualitzaPreu();
              },
            ),
            const SizedBox(height: 32),

            // Preu total
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Preu total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                Text(
                  _preuText,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _preuText == 'Nombre no vàlid' ? Colors.red : Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTallaRadio(String label, ShirtSize value) {
    return Expanded(
      child: RadioListTile<ShirtSize>(
        title: Text(label, style: const TextStyle(fontSize: 13)),
        value: value,
        groupValue: _tallaSeleccionada,
        contentPadding: EdgeInsets.zero,
        dense: true,
        onChanged: (val) {
          _tallaSeleccionada = val;
          _actualitzaPreu();
        },
      ),
    );
  }
}