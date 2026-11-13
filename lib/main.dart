// Integrante: Danilo Almeida Brito

import 'package:flutter/material.dart';

void main() {
  runApp(const ConsultaReceitas());
}

class ConsultaReceitas extends StatefulWidget {
  const ConsultaReceitas({super.key});

  @override
  State<ConsultaReceitas> createState() => _ConsultaReceitasState();
}

class _ConsultaReceitasState extends State<ConsultaReceitas> {
  final busca = TextEditingController();

  @override
  void dispose() {
    busca.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Danilo Almeida Brito'),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: busca,
                decoration: const InputDecoration(
                  labelText: 'Nome da receita',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Pesquisar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
