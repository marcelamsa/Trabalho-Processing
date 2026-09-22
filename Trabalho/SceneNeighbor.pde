class SceneNeighbor {
  // Referência ao jogo
  Game g;
  // Opções de diálogo
  OptionBox[] opts;
  // Construtor
  SceneNeighbor(Game g) {
    this.g = g;
  }
  // Desenho da cena
  void draw() {
    // Fundo escuro
    background(15, 15, 25);
    // Desenha o corredor
    g.assets.drawCorridor();

    // Caixa de diálogo com retrato
    g.box.drawWithPortrait(
      g.assets.victimPortrait,
      "Vizinha",
      "Ela teve rotina normal: mercado, comida cheirosa...\n"
      + "O marido chegava no fim do dia.\n\n"
      + "O que perguntas primeiro?",
      g.assets.textboxSkin, // skin (fundo da textbox)
      g.assets.framePortrait // moldura do portrait
      );
    // Criação das opções
    float y0 = 70;
    opts = new OptionBox[3];
    opts[0] = new OptionBox("A) Viste alguém diferente no prédio?", 60, y0, 640, 45);
    opts[1] = new OptionBox("B) O marido discutia com ela?", 60, y0+55, 640, 45);
    opts[2] = new OptionBox("C) Não preciso de nada, obrigado.", 60, y0+110, 640, 45);
    // Desenha todas as opções com arrays
    for (int i=0; i<opts.length; i++) opts[i].draw();
  }
  // Cliques do rato
  void mousePressed(float mx, float my) {
    for (int i=0; i<opts.length; i++) {
      if (opts[i].hit(mx, my)) {
        // Marca que o vizinho já foi visitado
        g.visitedNeighbor = true;
        // Avaliação da escolha, se foi boa ou ruim, para pontuação
        if (i == 0) {
          g.points++;
          g.setToast("Boa: abre hipótese de intruso.");
        } else {
          g.errors++;
          g.setToast("Fraco/arriscado. (Erro +1)");
        }
        // Volta para o quarto
        g.go(Game.ROOM);
        return;
      }
    }
  }
}
