import 'package:prova/prova.dart';
import 'dart:io';
import 'dart:convert';



void main(List<String> arguments) {
  while(true){
    final arquivo = File('estoque.json');
    List<dynamic> catalogo = [];
    if (arquivo.existsSync()) {
      final conteudo = arquivo.readAsStringSync();
      if (conteudo.trim().isNotEmpty) {
        catalogo = jsonDecode(conteudo) as List<dynamic>;
      }
    }
     for (var item in catalogo) {
          int id = item['id'];
          String substancia = item['substancia'];
          dynamic temperatura = item['temp'];
          String nivelRisco = item['nivelRisco'];
          Reagente novoReagente =
              Reagente(nivelRisco, id, substancia, temperatura);
          novoReagente.mostrarCaracteristicas();
        }

    print("---- MENU ----");
    print("1 - Cadastrar \n2 - Remover\n3 - Sair");
    stdout.write("Escolha: ");
    String op = stdin.readLineSync()!;
    if(op == "3"){
      break;
    }
    else if(op == "1"){
      print("---- CADASTRAR ----");
      stdout.write('ID da substância: ');
      int id = int.parse(stdin.readLineSync() ?? '');

      stdout.write('Nome substância: ');
      String substancia = stdin.readLineSync() ?? '';

      stdout.write('Temperatura: ');
      double temperatura = double.parse(stdin.readLineSync() ?? '');

      stdout.write('Nível de Risco: ');
      String nivelRisco = stdin.readLineSync() ?? ''; 

      for (var idCadastrado in catalogo){
        if(idCadastrado['id'] == id){
          throw Exception("ID já cadastrado!");
        }
      }

      try {
        final reagente = Reagente(nivelRisco, id, substancia, temperatura);
        if(temperatura > -2.0){
          reagente.resfriarEmergencia();
        }
        catalogo.add(reagente.toJson());
        arquivo.writeAsStringSync(jsonEncode(catalogo));
        print('Substancia "${reagente.substancia}" salva com sucesso!');
      }catch (e) {
        print('Erro: $e');
      }

    }
    else if (op == "2"){
      print("---- REMOVER ----");
      stdout.write('Digite o id da substancia para deletar: ');
      int idRemove = int.parse(stdin.readLineSync() ?? '');
      catalogo.removeWhere((idRemover) => idRemover['id'] == idRemove);
      arquivo.writeAsStringSync(jsonEncode(catalogo));
    }
    else {
      print("Opção inválida!");
    }
  }
}
