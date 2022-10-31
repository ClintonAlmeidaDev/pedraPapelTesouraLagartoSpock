import 'dart:html';

import 'package:jogo/src/partida.dart';
import 'package:jogo/src/resultado.dart';

late DivElement divOpcoes;
late DivElement divResultado;
late DivElement divResultadoPlayers;
late DivElement divPontuacaoVoce;
late DivElement divPontuacaoMaquina;

bool jogando = true;
late Resultado resultado;

void main() {
  inicializarReferencias();
  final partida = configurarPartida();

  for (final opcao in opcoes) {
    divOpcoes.append(
      ImageButtonInputElement()
        ..onClick.listen(
          (MouseEvent e) {
            if (jogando) {
              resultado = partida.iniciar(humano: opcao);
              jogando = false;
              jogarNovamenteBt(opcaoPlayer: opcao, mensagem: "Jogador");
              jogarNovamenteBt(opcaoPlayer: partida.pc, mensagem: "Maquina");
              adicionarEspaco();
              mostrarResultado(resultado);

              atualizaPontuacao(
                  jogadorPontos: partida.contJogador, pcPontos: partida.contPc);
            }
          },
        )
        ..className = 'opcao'
        ..src = 'images/$opcao.png'
        ..height = 120,
    );
  }
  adicionarEspaco();
}

void mostrarResultado(Resultado resultado) {
  String mensagem;
  String classeCss;
  switch (resultado.resultadoType) {
    case ResultadoType.empate:
      classeCss = 'empatou';
      mensagem = 'Empatou..';
      break;
    case ResultadoType.vitoria:
      classeCss = 'venceu';
      mensagem = 'Você ganhou :D';
      //resultado.contJogador = resultado.contJogador + 1;
      break;
    case ResultadoType.derrota:
      //resultado.incluiPontoMaquina();
      classeCss = 'perdeu';
      mensagem = 'Você perdeu :/';
      break;
  }
  divResultado.append(
    SpanElement()
      ..className = classeCss
      ..text = mensagem,
  );
  adicionarEspaco();
  divResultado.append(SpanElement()..text = resultado.resumo);
  adicionarEspaco();
  divResultado.append(
    ButtonElement()
      ..text = 'Jogar novamente!'
      ..onClick.listen(jogarNovamente),
  );
}

void adicionarEspaco() {
  divResultado.append(BRElement());
  divResultado.append(BRElement());
}

void jogarNovamenteBt({String? opcaoPlayer, String? mensagem}) {
  var div = new DivElement()..id = "teste0123";

  divResultadoPlayers.children.add(div);

  div.append(
    Element.p()
      ..className = 'resultadoPlayersClass'
      ..text = "$mensagem ",
  );
  div.append(ImageElement()
    ..src = 'images/$opcaoPlayer.png'
    ..height = 120
    ..className = 'resultadoPlayersClass');
}

void atualizaPontuacao({num? jogadorPontos, num? pcPontos}) {
  if (jogadorPontos != null && pcPontos != null) {
    divPontuacaoVoce.innerText = jogadorPontos.toString();
    divPontuacaoMaquina.innerText = pcPontos.toString();
  }
}

void jogarNovamente(MouseEvent e) {
  jogando = true;
  divResultado.children.clear();
  divResultadoPlayers.children.clear();
}

void inicializarReferencias() {
  divOpcoes = querySelector('#opcoes') as DivElement;
  divResultado = querySelector('#resultado') as DivElement;
  divResultadoPlayers = querySelector('#resultadoPlayers') as DivElement;
  divPontuacaoVoce = querySelector('#pontuacaoVoce') as DivElement;
  divPontuacaoMaquina = querySelector('#pontuacaoMaquina') as DivElement;
}

Partida configurarPartida() {
  return Partida()
    ..criarRegra(tesoura, acao: 'corta', perdedor: papel)
    ..criarRegra(tesoura, acao: 'decapita', perdedor: lagarto)
    ..criarRegra(papel, acao: 'cobre', perdedor: pedra)
    ..criarRegra(papel, acao: 'refuta', perdedor: spock)
    ..criarRegra(pedra, acao: 'esmaga', perdedor: lagarto)
    ..criarRegra(pedra, acao: 'quebra', perdedor: tesoura)
    ..criarRegra(lagarto, acao: 'envenena', perdedor: spock)
    ..criarRegra(lagarto, acao: 'come', perdedor: papel)
    ..criarRegra(spock, acao: 'esmaga', perdedor: tesoura)
    ..criarRegra(spock, acao: 'vaporiza', perdedor: pedra);
}
