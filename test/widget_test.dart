// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app/controller/tarefa_provider.dart';
import 'package:task_app/modelos/item.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('FirebaseFirestoreService', () {
    TarefaProvider? firebaseFirestoreService;
    MockFirebaseFirestore? mockFirestore;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      firebaseFirestoreService = TarefaProvider(firestore: mockFirestore!);
    });

    test('adicionarTarefa adiciona corretamente uma tarefa ao Firestore',
        () async {
      // Mock dos dados
      final item = Item(
        id: null, encerrado: false, horario: '', titulo: 'Teste',
        // Preencha os campos do item com os valores desejados
        // Exemplo: title: 'Tarefa 1', description: 'Descrição da tarefa 1'
      );

      // Execução do método adicionarTarefa
      firebaseFirestoreService!.adicionarTarefa(item);

      // Verifica se a função "collection" foi chamada corretamente
      verify(mockFirestore!.collection('tarefas')).called(1);

      // Verifica se a função "add" foi chamada corretamente com os dados esperados
      verify(mockFirestore!.collection('tarefas').add(item.toJson())).called(1);

      // Verifica se a função "notifyListeners" foi chamada
      // Certifique-se de que sua classe de serviço implemente "ChangeNotifier"
      expect(firebaseFirestoreService, emitsInOrder([emits(anything)]));
    });
  });
}
