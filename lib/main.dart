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