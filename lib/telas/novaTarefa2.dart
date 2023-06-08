import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../modelos/item.dart';
import '../controller/tarefaProvider.dart';

class NovaTarefa extends StatefulWidget {
  @override
  _NovaTarefaState createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  final novaTarefaController = TextEditingController();
  final horarioController = TextEditingController();
  final localizacaoController = TextEditingController();
  Geolocator _geolocator = Geolocator();

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
        title: Text('Inserir tarefa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
              child: TextFormField(
                controller: novaTarefaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nova tarefa',
                ),
              ),
            ),
            TextFormField(
              controller: horarioController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
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
              decoration: InputDecoration(
                labelText: 'Localização',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final novaTarefa = Item(
            titulo: novaTarefaController.text,
            encerrado: false,
            horario: horarioController.text,
          );

          final tarefaProvider =
              Provider.of<TarefaProvider>(context, listen: false);
          tarefaProvider.adicionarTarefa(novaTarefa);
          tarefaProvider.notifyListeners();
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
