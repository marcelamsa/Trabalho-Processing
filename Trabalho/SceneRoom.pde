class SceneRoom {
  // Referência ao jogo
  Game g;
  // Áreas interativas
  Hotspot[] hs;

  OptionBox btnConclude; // botão para ir ao relatório

  SceneRoom(Game g) {
    this.g = g;
// Criação dos hotspots
    hs = new Hotspot[4];
    hs[0] = new Hotspot("Armário", 40, 80, 240, 420);
    hs[1] = new Hotspot("Cômoda", 300, 220, 260, 220);
    hs[2] = new Hotspot("Cama", 600, 210, 340, 300);
    hs[3] = new Hotspot("Corredor", 10, 10, 180, 60);

    //  botão fica em cima, longe da textbox (não cobre o texto).  Botão do relatório
    btnConclude = new OptionBox("Concluir caso", 60, 80, 260, 50);
  }

  void draw() {
    // fundo do quarto (SEM corpo aqui)
    g.assets.drawRoom(false);

    // Mostra dicas visuais dos hotspots
    for (int i = 0; i < hs.length; i++) {
      hs[i].drawHint();
    }

    // textbox com portrait do policial
    g.box.drawWithPortrait(
      g.assets.police,
      "Policial",
      "Relatório inicial:\n" +
      "Encontrámos a vítima com múltiplos ferimentos.\n" +
      "O que queres analisar primeiro?\n\n" +
      "Dica: passa o rato por cima dos objetos.",
      g.assets.textboxSkin,
      g.assets.framePortrait
    );

    // só mostra o botão quando tiver tudo feito
    if (g.canGoReport()) {
      btnConclude.draw();
    }
  }

  void mousePressed(float mx, float my) {
    // concluir caso
    if (g.canGoReport() && btnConclude.hit(mx, my)) {
      g.go(Game.REPORT);
      g.setToast("A preparar relatório...");
      return;
    }

    // Navegação pelos hotspots
    if (hs[0].hit(mx, my)) g.go(Game.QUIZ_WARDROBE);
    else if (hs[1].hit(mx, my)) g.go(Game.QUIZ_COMMODE);
    else if (hs[2].hit(mx, my)) g.go(Game.QUIZ_BODY);      // corpo só aparece lá
    else if (hs[3].hit(mx, my)) g.go(Game.NEIGHBOR);
  }
}
