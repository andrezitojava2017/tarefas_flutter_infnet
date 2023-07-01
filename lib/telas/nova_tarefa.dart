import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../modelos/item.dart';
import '../controller/tarefa_provider.dart';

class NovaTarefa extends StatefulWidget {
  const NovaTarefa({super.key});

  @override
  NovaTarefaState createState() => NovaTarefaState();
}

class NovaTarefaState extends State<NovaTarefa> {
  final novaTarefaController = TextEditingController();
  final horarioController = TextEditingController();
  final localizacaoController = TextEditingController();
  final Geolocator geolocator = Geolocator();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
              child: TextFormField(
                controller: novaTarefaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nova tarefa',
                ),
              ),
            ),
            TextFormField(
              controller: horarioController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Horário',
              ),
            ),
            TextFormField(
              onTap: () {
                _determinePosition().then((value) {
                  setState(() {
                    localizacaoController.text =
                        '${value.latitude}, ${value.longitude}';
                  });
                }).catchError((error) {
                  setState(() {
                    localizacaoController.text = 'Erro ao obter localização';
                  });
                });
              },
              controller: localizacaoController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Localização',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final novaTarefa = Item(
            id: null,
            titulo: novaTarefaController.text,
            encerrado: false,
            horario: horarioController.text,
          );

          final tarefaProvider =
              Provider.of<TarefaProvider>(context, listen: false);
          tarefaProvider.adicionarTarefa(novaTarefa);
          // tarefaProvider.notifyListeners();
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
