// Integrante: Danilo Almeida Brito

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List receitas = [];
  bool carregando = false;
  String mensagem = 'Digite o nome de uma receita.';

  Future<void> pesquisar() async {
    final texto = busca.text.trim();

    if (texto.isEmpty) {
      setState(() {
        receitas = [];
        mensagem = 'Digite algo para pesquisar.';
      });
      return;
    }

    setState(() {
      carregando = true;
      receitas = [];
    });

    try {
      final url = Uri.https(
        'www.themealdb.com',
        '/api/json/v1/1/search.php',
        {'s': texto},
      );

      final resposta = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (resposta.statusCode != 200) {
        throw Exception();
      }

      final dados = jsonDecode(resposta.body);

      if (!mounted) return;

      setState(() {
        receitas = dados['meals'] ?? [];
        mensagem = 'Nenhuma receita encontrada.';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        receitas = [];
        mensagem = 'Erro ao buscar receitas.';
      });
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

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
                onPressed: carregando ? null : pesquisar,
                child: const Text('Pesquisar'),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: carregando
                    ? const Center(child: CircularProgressIndicator())
                    : receitas.isEmpty
                        ? Center(child: Text(mensagem))
                        : ListView.builder(
                            itemCount: receitas.length,
                            itemBuilder: (context, index) {
                              final receita = receitas[index];
                              return ListTile(
                                leading: Image.network(
                                  receita['strMealThumb'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(receita['strMeal']),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
