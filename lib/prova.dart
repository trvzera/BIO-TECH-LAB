abstract class Produto {
  int id;
  String substancia;
  double _temperatura = 0;
  
  Produto(this.id, this.substancia, double temperatura): _temperatura = temperatura {this.temperatura = temperatura;}
  
  double get temperatura => _temperatura;

  set temperatura(double temperatura) {
    if (temperatura > 0) {
      throw Exception("Risco de explosão: temperatura positiva");
    }
    _temperatura = temperatura;
  }

  resfriarEmergencia(){
    _temperatura -= 5;
  }

  Map<String, dynamic> toJson();
  mostrarCaracteristicas();
}

class Reagente extends Produto {
  String nivelRisco;

  Reagente(this.nivelRisco, int id, String substancia, double temperatura):super(id, substancia, temperatura);

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'substancia': substancia, 'temp': temperatura, 'nivelRisco': nivelRisco};
  }
  @override
  mostrarCaracteristicas() {
    print('--------------------------------------------------');    
    print(
        'ID: $id | SUBSTANCIA: $substancia | TEMPERATURA: $temperatura | NIVEL DE RISCO: $nivelRisco');
    print('--------------------------------------------------');    
  }
}