class Game {
  // CENAS EM ORDEM
  static final int INTRO = 0; // Ecrã inicial
  static final int INTRO_VIDEO = 1; // Cena do vídeo introdutório
  static final int ROOM  = 2; // Quarto principal (investigação)
  static final int QUIZ_WARDROBE = 3; // Quiz do guarda-roupa
  static final int QUIZ_COMMODE  = 4; // Quiz da cómoda
  static final int QUIZ_BODY     = 5; // Quiz do corpo
  static final int NEIGHBOR      = 6; // Cena do vizinho
  static final int REPORT        = 7; // Relatório final

  // Vídeo da introdução
  Movie introMovie;

  // Cena atual (começa na INTRO)
  int scene = INTRO;

  // PROGRESSO
  // Booleans para saber se o jogador já visitou cada local
  boolean visitedWardrobe = false;
  boolean visitedCommode  = false;
  boolean visitedBody     = false;
  boolean visitedNeighbor = false;

  // Pontuação e erros, começa em zero
  int points = 0;
  int errors = 0;

  // UI / ASSETS

  AssetManager assets; // Gere imagens, sons, etc. Pela classe AssetManager
  TextBox box; // Caixa de texto para diálogos, na parte UI

  // Mensagem temporária (toast)
  String toast = "";
  int toastTimer = 0;

  // CENAS (em classes)
  SceneIntro scIntro;
  SceneIntroVideo scIntroVideo;
  SceneRoom scRoom;
  SceneQuiz scQuiz;
  SceneNeighbor scNeighbor;
  SceneTimelineSuspectsEnding scReport;

  void setup() {
    // Cria o gestor de assets e carrega tudo
    assets = new AssetManager();
    assets.loadAll();

    // Caixa de texto na parte inferior do ecrã
    box = new TextBox(20, height - 155, width - 40, 135);

    // Criação de todas as cenas, pelas classes
    scIntro = new SceneIntro(this);
    scIntroVideo = new SceneIntroVideo(this);
    scRoom = new SceneRoom(this);
    scQuiz = new SceneQuiz(this);
    scNeighbor = new SceneNeighbor(this);
    scReport = new SceneTimelineSuspectsEnding(this);
  }

  // MOSTRAR MENSAGEM TEMPORÁRIA. Mensagens rápidas que aparecem no inicio da investigação, tipo Entraste no quarto. Investiga com cuidado.
  void setToast(String msg) {
    toast = msg;
    toastTimer = 110;
  }

  // TROCAR DE CENA
  void go(int nextScene) {
    // Atualiza a cena atual
    scene = nextScene;
    // Se entrar na cena do vídeo, inicia o vídeo
    if (scene == INTRO_VIDEO) {
      scIntroVideo.start();
    }

    // Sempre que entra no relatório final,
    // garante que tudo começa do início
    if (scene == REPORT) {
      scReport.step = 0;
      scReport.suspectChoice = -1;
      scReport.opts = null;
    }
  }

  // VERIFICA SE PODE IR PARA O RELATÓRIO
  // Só permite o relatório quando todas as áreas foram visitadas
  boolean canGoReport() {
    return visitedWardrobe && visitedCommode && visitedBody && visitedNeighbor;
  }

  // Diminui o tempo do toast
  void update() {
    if (toastTimer > 0) toastTimer--;
  }

  void draw() {

    // Desenha a cena atual definida em cada classe
    if (scene == INTRO) scIntro.draw();
    else if (scene == INTRO_VIDEO) scIntroVideo.draw();
    else if (scene == ROOM) scRoom.draw();
    else if (scene == QUIZ_WARDROBE) scQuiz.drawWardrobe();
    else if (scene == QUIZ_COMMODE) scQuiz.drawCommode();
    else if (scene == QUIZ_BODY) scQuiz.drawBody();
    else if (scene == NEIGHBOR) scNeighbor.draw();
    else if (scene == REPORT) scReport.draw();

    // toast pequeno no topo
    if (toastTimer > 0 && toast != null && toast.length() > 0) {
      fill(0, 160);
      noStroke();
      rect(20, 20, width - 40, 44, 10);
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(14);
      text(toast, 34, 42);
    }
  }

  // CLIQUES DO RATO

  void mousePressed(float mx, float my) {
    // Encaminha o clique para a cena correta
    if (scene == INTRO) scIntro.mousePressed(mx, my);
    else if (scene == INTRO_VIDEO) scIntroVideo.mousePressed(mx, my);
    else if (scene == ROOM) scRoom.mousePressed(mx, my);
    else if (scene == QUIZ_WARDROBE) scQuiz.mousePressedWardrobe(mx, my);
    else if (scene == QUIZ_COMMODE) scQuiz.mousePressedCommode(mx, my);
    else if (scene == QUIZ_BODY) scQuiz.mousePressedBody(mx, my);
    else if (scene == NEIGHBOR) scNeighbor.mousePressed(mx, my);
    else if (scene == REPORT) scReport.mousePressed(mx, my);
  }

  // RESET COMPLETO DO JOGO
  void resetAll() {
    // Reset do progresso
    visitedWardrobe = false;
    visitedCommode = false;
    visitedBody = false;
    visitedNeighbor = false;

    // Reset da pontuação
    points = 0;
    errors = 0;
    // Limpa mensagens
    toast = "";
    toastTimer = 0;
    // Volta para a introdução
    go(INTRO);
  }
}
