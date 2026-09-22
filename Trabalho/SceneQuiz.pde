class SceneQuiz {
  // Referência ao jogo principal
  Game g;
  // Opções de resposta por botões
  OptionBox[] opts;

  // Construtor
  SceneQuiz(Game g) {
    this.g = g;
  }

  // ---------------- ARMÁRIO ----------------
  void drawWardrobe() {
    // Desenha o quarto com iluminação ativa
    g.assets.drawRoom(true);
    // Caixa de texto com retrato do policial
    g.box.drawWithPortrait(
      g.assets.police,
      "Policial",
      "ARMÁRIO:\n" +
      "O armário está semiaberto. Há roupas e algo no fundo...\n\n" +
      "Encontras um casaco masculino com manchas escuras.\n" +
      "O que isso sugere?",
      g.assets.textboxSkin, // skin (fundo da textbox)
      g.assets.framePortrait    // moldura do portrait
      );
    // Criação das opções
    opts = new OptionBox[3];
    // Opção A
    opts[0] = new OptionBox("A) É só sujidade comum.", 60, 120, 520, 45);
    // Opção B
    opts[1] = new OptionBox("B) Alguém tentou esconder algo aqui.", 60, 175, 520, 45);
    // Opção C
    opts[2] = new OptionBox("C) Alguém tentou limpar-se aqui.", 60, 230, 520, 45);
    // Desenha todas as opções
    for (int i = 0; i < opts.length; i++) opts[i].draw();
  }
  // Vê o clique ao clicar armário
  void mousePressedWardrobe(float mx, float my) {

    // Segurança: evita erros se não houver opções
    if (opts == null) return;

    for (int i = 0; i < opts.length; i++) {
      if (opts[i].hit(mx, my)) {
        // Marca progresso
        g.visitedWardrobe = true;
        // Avaliação da escolha
        if (i == 2) {
          g.points++;
          g.setToast("Boa: sugere presença recente.");
        } else {
          g.errors++;
          g.setToast("Fraco: conclusão apressada. (Erro +1)");
        }
        // Volta para o quarto
        g.go(Game.ROOM);
        return;
      }
    }
  }

  // ---------------- CÔMODA ----------------
  void drawCommode() {
    // Desenha o quarto
    g.assets.drawRoom(false);
    // Caixa de texto com o policial
    g.box.drawWithPortrait(
      g.assets.police, // aqui é o policial no portrait
      "Policial", // nome do personagem
      "CÔMODA:\n" +
      "Entre objetos pessoais, há um bilhete dobrado.\n" + // texto do diálogo
      "A tinta parece recente.\n\n" +
      "O que fazes?",
      g.assets.textboxSkin, // ✅ faltava isto
      g.assets.framePortrait
      );
    // Criação das opções de resposta
    opts = new OptionBox[3];

    opts[0] = new OptionBox("A) Ignoras (pode ser irrelevante).", 60, 120, 520, 45);
    // Opção B
    opts[1] = new OptionBox("B) Guardas como pista e registas.", 60, 175, 520, 45);
    // Opção C (resposta correta)
    opts[2] = new OptionBox("C) Rasgas e deitas fora.", 60, 230, 520, 45);
    // Desenha todas as opções no ecrã
    for (int i = 0; i < opts.length; i++) opts[i].draw();
  }
  // Vê clique ao clicar na comoda
  void mousePressedCommode(float mx, float my) {
    // Proteção: evita erro se as opções ainda não existirem
    if (opts == null) return;
    // Percorre as opções
    for (int i = 0; i < opts.length; i++) {
      // Se clicou numa opção
      if (opts[i].hit(mx, my)) {
        // Marca a cômoda como visitada
        g.visitedCommode = true;
        // Avalia a decisão
        if (i == 1) {
          g.points++;
          g.setToast("Boa: preservaste evidência.");
        } else {
          g.errors++;
          g.setToast("Má decisão. (Erro +1)");
        }
        // Volta para o quarto
        g.go(Game.ROOM);
        return;
      }
    }
  }

  // ---------------- CAMA / CORPO ----------------
  void drawBody() {
    // Desenha o quarto
    g.assets.drawRoom(false);

    //  corpo só aparece nesta cena (ao clicar na cama)
    image(g.assets.victimBody, 80, 120, 260, 380);
    // Caixa de texto com análise do corpo
    g.box.drawWithPortrait(
      g.assets.police,
      "Policial",
      "CAMA:\n" +
      "Agora vês o corpo mais de perto.\n" +
      "Há sinais de luta e ferimentos graves.\n\n" +
      "Qual interpretação é mais cuidadosa?",
      g.assets.textboxSkin, // ✅ faltava isto também
      g.assets.framePortrait
      );
    // Criação das opções
    opts = new OptionBox[3];
    opts[0] = new OptionBox("A) Parece um acidente.", 60, 120, 520, 45);
    opts[1] = new OptionBox("B) Houve confronto e possível encenação.", 60, 175, 520, 45);
    opts[2] = new OptionBox("C) O culpado é óbvio, não preciso de mais nada.", 60, 230, 520, 45);

    for (int i = 0; i < opts.length; i++) opts[i].draw();
  }
  // Processa o  clique ao analisar o corpo
  void mousePressedBody(float mx, float my) {
    // Proteção contra erro
    if (opts == null) return;
    // Percorre as opções
    for (int i = 0; i < opts.length; i++) {
      // Verifica clique
      if (opts[i].hit(mx, my)) {
        // Marca o corpo como analisado
        g.visitedBody = true;
        // Avalia a resposta
        if (i == 1) {
          g.points++;
          g.setToast("Boa: leitura prudente.");
        } else {
          g.errors++;
          g.setToast("Fraco: hipótese frágil. (Erro +1)");
        }
        // Retorna ao quarto
        g.go(Game.ROOM);
        return;
      }
    }
  }
}
