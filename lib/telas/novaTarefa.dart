import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../modelos/item.dart';

class Tarefas extends StatefulWidget {
  var iten = <Item>[];
  Tarefas({super.key, required this.iten});

  @override
  _TarefasState createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  @override
  void initState() {
    super.initState();
    /*
    var local = _determinePosition();
    local.then((v) => localizacao.text = '$v.Latitude + $v.Longitude');
    */
  }

  var novaTarefa = TextEditingController();
  var horario = TextEditingController();
  var localizacao = TextEditingController();
  Geolocator _geolocator = Geolocator();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                  child: TextFormField(
                    controller: novaTarefa,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nova tarefa',
                    ),
                  ),
                ),
                TextFormField(
                  controller: horario,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Horario',
                  ),
                ),
                TextFormField(
                  onTap: () {
                    _determinePosition()
                        .then((value) => localizacao.text = value.toString());
                  },
                  controller: localizacao,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Localização',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.iten.add(Item(
                titulo: novaTarefa.text,
                encerrado: false,
                horario: horario.text));
          });

          Navigator.pop(context, widget.iten);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
