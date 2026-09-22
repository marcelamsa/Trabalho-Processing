class SceneIntroVideo {
  // Referência ao jogo principal
  Game g;
// Estado do vídeo
  boolean started = false;
  boolean finished = false;
// Botão para continuar após o vídeo
  OptionBox continueBtn;
// Construtor
  SceneIntroVideo(Game g) {
    this.g = g;
    continueBtn = new OptionBox("Continuar", 60, 360, 360, 52);
  }
// Inicia o vídeo sempre que entra nesta cena
  void start() {
    started = true;
    finished = false;
// Reinicia e reproduz o vídeo
    if (g.introMovie != null) {
      g.introMovie.stop();
      g.introMovie.jump(0);
      g.introMovie.play();
    }
  }
// Desenho da cena do vídeo
  void draw() {
    background(0);

    // desenha vídeo
    if (g.introMovie != null) {
      image(g.introMovie, 0, 0, width, height);

      // Verifica se chegou ao fim
      if (!finished && g.introMovie.duration() > 0 && g.introMovie.time() >= g.introMovie.duration() - 0.05) {
        finished = true;
        g.introMovie.stop();
      }
    } else {
      // Caso o vídeo não exista
      fill(255);
      textAlign(CENTER, CENTER);
      text("Vídeo não encontrado em data/intro.mp4", width/2, height/2);
      finished = true;
    }
// Enquanto o vídeo ainda não terminou
    if (!finished) {
      // dica para saltar
      fill(0, 140);
      noStroke();
      rect(20, height - 50, 260, 30, 8);
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(12);
      text("Clique para saltar", 34, height - 35);
    } else {
     // Após o vídeo terminar: botão continuar
      continueBtn.draw();
    }
  }
// Cliques do rato
  void mousePressed(float mx, float my) {
    if (!finished) {
      // clicar salta, mas NÃO começa o jogo ainda — só mostra botão
      if (g.introMovie != null) g.introMovie.stop();
      finished = true;
      return;
    }
// Após terminar, o botão leva para o quarto
    if (continueBtn.hit(mx, my)) {
      g.go(Game.ROOM);
      g.setToast("Entraste no quarto. Investiga com cuidado.");
    }
  }
}
