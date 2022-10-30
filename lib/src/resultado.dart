enum ResultadoType { empate, vitoria, derrota }

class Resultado {
  Resultado(this.resultadoType, this.resumo);

  final ResultadoType resultadoType;
  final String resumo;
  int? pontuacaoJogador;
  int? pontuacaoMaquina;

  void calcularPontuacao(ResultadoType resultadoType) {}
}
