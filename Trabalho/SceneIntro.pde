class SceneIntro {
  // Referência ao jogo principal
  Game g;
  // Botão para iniciar a investigação
  OptionBox startBtn;
  // Construtor
  SceneIntro(Game g) {
    this.g = g;
    // Criação do botão
    startBtn = new OptionBox("Começar investigação", 60, 360, 360, 52);
  }
  // Desenho da cena inicial
  void draw() {
    // Fundo escuro
    background(10);
    // Título
    fill(255);
    textAlign(LEFT, TOP);
    textSize(32);
    text("Quarto 47 — Investigação", 60, 60);
    // Texto introdutório da narrativa
    textSize(16);
    text(
      "Uma cantora foi encontrada morta.\n" +
      "Tu és o policial chamado para investigar.\n" +
      "Analisa o quarto, fala com a vizinha e conclui o relatório.",
      60, 120
      );
    // Desenha o botão
    startBtn.draw();
  }
  // Deteta cliques do rato
  void mousePressed(float mx, float my) {
    // Se o botão for clicado, vai para o vídeo introdutório
    if (startBtn.hit(mx, my)) {
      g.go(Game.INTRO_VIDEO);
    }
  }
}
