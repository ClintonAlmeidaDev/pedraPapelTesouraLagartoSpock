import 'dart:math';

import 'package:jogo/src/resultado.dart';

const pedra = 'Pedra';
const papel = 'Papel';
const tesoura = 'Tesoura';
const lagarto = 'Lagarto';
const spock = 'Spock';
const opcoes = [pedra, papel, tesoura, lagarto, spock];

class Partida {
  final regras = <String, Map<String, String>>{};

  late String pc = escolherPc();
  late num contJogador = 0;
  late int contPc = 0;

  void incluiPontoJogador() {
    contJogador = contJogador + 1;
    pc = escolherPc();
  }

  void incluiPontoMaquina() {
    contPc = contPc + 1;
    pc = escolherPc();
  }

  String escolherPc() {
    int? index = Random().nextInt(5);
    return opcoes[index];
  }

  void criarRegra(String vencedor,
      {required String acao, required String perdedor}) {
    if (!regras.containsKey(vencedor)) {
      regras[vencedor] = {};
    }
    regras[vencedor]![acao] = perdedor;
  }

  Resultado iniciar({required String humano}) {
    if (humano == pc) {
      return Resultado(ResultadoType.empate, '$humano empata com $pc');
    }

    if (regras[humano]!.containsValue(pc)) {
      final entry = regras[humano]!.entries.firstWhere((e) => e.value == pc);
      incluiPontoJogador();
      return Resultado(
          ResultadoType.vitoria, '$humano ${entry.key} ${entry.value}');
    }

    final entry = regras[pc]!.entries.firstWhere((e) => e.value == humano);
    incluiPontoMaquina();
    return Resultado(ResultadoType.derrota, '$pc ${entry.key} ${entry.value}');
  }
}
