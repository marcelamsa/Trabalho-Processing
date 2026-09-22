class SceneTimelineSuspectsEnding {
  // Referência ao jogo principal
  Game g;
// Etapas do relatório
  int step = 0; // 0=timeline, 1=suspeito, 2=final
  // Guarda qual suspeito foi escolhido (-1 = nenhum)
  int suspectChoice = -1;
// Opções de escolha (botões)
  OptionBox[] opts;
    // Botão para reiniciar o jogo
  OptionBox restartBtn;
// Construtor da cena
  SceneTimelineSuspectsEnding(Game g) {
    this.g = g;
    // Cria o botão de reinício
    restartBtn = new OptionBox("Recomeçar", 60, 80, 260, 50);
  }
// DESENHO GERAL DA CENA
  void draw() {
    // Fundo preto
    background(0);
// Escolhe o que desenhar consoante a fase
    if (step == 0) drawTimeline();
    else if (step == 1) drawSuspects();
    else drawEnding();
  }
// ETAPA 1 — LINHA DO TEMPO
  void drawTimeline() {
    // Caixa de texto com instruções
    g.box.drawWithPortrait(
      g.assets.stalkerShadow,    // retrato simbólico do suposto assassino
      "Relatório",
      "LINHA DO TEMPO (últimas 24h):\n" +
      "Escolhe a sequência mais plausível.\n\n" +
      "As escolhas influenciam o final.",
      g.assets.textboxSkin,
      g.assets.framePortrait
    );
// Criação das opções de linha do tempo
    opts = new OptionBox[3];
    opts[0] = new OptionBox("A) Mercado → Casa → Confronto → Corpo no quarto", 60, 90, 840, 45);
    opts[1] = new OptionBox("B) Corpo no quarto → Mercado → Casa → Nada", 60, 145, 840, 45);
    opts[2] = new OptionBox("C) Mercado → Nada → Corpo aparece → Fim", 60, 200, 840, 45);
// Desenha as opções
    for (int i = 0; i < opts.length; i++) opts[i].draw();
  }
  
  // ETAPA 2 — ESCOLHA DO SUSPEITO

  void drawSuspects() {
    // Caixa de texto para escolha do suspeito
    g.box.drawWithPortrait(
      g.assets.stalkerNormal,   //retrato do verdadeiro suspeito de assassinato
      "Relatório",
      "SUSPEITO PRINCIPAL:\n" +
      "Com base nas pistas, qual hipótese é mais forte?\n\n" +
      "Respostas erradas levam a finais ruins.",
      g.assets.textboxSkin,
      g.assets.framePortrait
    );
// Opções de suspeitos
    opts = new OptionBox[3];
    opts[0] = new OptionBox("A) Marido", 60, 90, 520, 45);
    opts[1] = new OptionBox("B) Vizinha", 60, 145, 520, 45);
    opts[2] = new OptionBox("C) Intruso / fã obsessivo", 60, 200, 520, 45);
// Desenha as opções
    for (int i = 0; i < opts.length; i++) opts[i].draw();
  }
// ETAPA 3 — FINAL
  void drawEnding() {
    // Caixa de texto final com o desfecho
    g.box.drawWithPortrait(
      g.assets.police,
      "Conclusão",
      buildEndingText(),
      g.assets.textboxSkin,
      g.assets.framePortrait
    );

    // botão fica no topo, não tapa o texto. Botão para reiniciar o jogo
    restartBtn.draw();

    // Mostra pontuação final no canto superior
    fill(255);
    textAlign(LEFT, TOP);
    textSize(12);
    text("Pontos: " + g.points + "  Erros: " + g.errors, 20, 20);
  }
// CONSTRÓI O TEXTO DO FINAL
  String buildEndingText() {
    // ruins por erro
    if (g.errors >= 3) {
      return "FINAL RUIM:\n" +
             "O relatório tem falhas graves.\n" +
             "Evidências foram mal interpretadas.\n\n" +
             "O caso segue aberto e a investigação perde credibilidade.";
    }

    // bom (não revela foi stalker como certeza absoluta)
    if (suspectChoice == 2 && g.points >= 3) {
      return "FINAL BOM:\n" +
             "Relatório consistente.\n" +
             "A hipótese de intruso/fã obsessivo encaixa nas pistas.\n\n" +
             "A investigação avança com base em evidências sólidas.";
    }

    // ambíguos
    if (suspectChoice == 0 && g.points >= 3) {
      return "FINAL AMBÍGUO:\n" +
             "A teoria do marido é possível, mas faltam provas.\n\n" +
             "O caso continua em investigação.";
    }

    if (suspectChoice == 1 && g.points >= 3) {
      return "FINAL AMBÍGUO:\n" +
             "Suspeitar da vizinha sem provas diretas cria ruído.\n\n" +
             "O caso demora mais para avançar.";
    }

    // ruim padrão
    return "FINAL RUIM:\n" +
           "A tua conclusão foi apressada.\n" +
           "Faltou ligar as pistas de forma coerente.\n\n" +
           "Recomeça e tenta melhorar.";
  }
// CLIQUES DO RATO
  void mousePressed(float mx, float my) {
    // Fase da linha do tempo
    if (step == 0) {
      if (opts == null) return;
      for (int i = 0; i < opts.length; i++) {
        if (opts[i].hit(mx, my)) {
          // Avaliação da escolha
          if (i == 0) { g.points++; g.setToast("Linha do tempo aceitável."); }
          else { g.errors++; g.setToast("Linha do tempo fraca. (Erro +1)"); }
           // Avança para a próxima etapa
          step = 1;
          return;
        }
      }
    } 
    // Fase da escolha do suspeito
    else if (step == 1) {
      if (opts == null) return;
      for (int i = 0; i < opts.length; i++) {
        if (opts[i].hit(mx, my)) {
          // Guarda a escolha
          suspectChoice = i;
// Avaliação
          if (i == 2) { g.points++; g.setToast("Hipótese de intruso (com base em pistas)."); }
          else { g.errors++; g.setToast("Hipótese arriscada. (Erro +1)"); }
 // Avança para o final
          step = 2;
          return;
        }
      }
    } // Ecrã final
    else {
      // Reinicia o jogo
      if (restartBtn.hit(mx, my)) {
        g.resetAll();
      }
    }
  }
}
