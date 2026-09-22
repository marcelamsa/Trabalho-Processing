import processing.sound.*;   // Importa a biblioteca de som (para música e efeitos)
import processing.video.*;   // Importa a biblioteca de vídeo (para o vídeo de introdução)

// Objeto que vai tocar a música de fundo
SoundFile music;

// Indica se a música foi carregada corretamente
boolean musicOk = false;

// Indica se a música já começou a tocar (evita tocar várias vezes)
boolean musicStarted = false;

// Fonte usada na interface (textos do jogo)
PFont uiFont;

// Vídeo de introdução (global para ser usado por várias cenas)
Movie introMovie;   // ✅ global

// Objeto principal do jogo (controla cenas, lógica, etc.)
Game game;

void setup() {
  // Define o tamanho da janela do jogo
  size(960, 540);

  // Ativa suavização gráfica
  smooth();

  // Cria a fonte personalizada (tem de estar na pasta data/)
  uiFont = createFont("m5x7.ttf", 16, true);

  // Caso a fonte personalizada falhe, usa Arial como fallback
  if (uiFont == null) uiFont = createFont("Arial", 16, true);

  // Define esta fonte como padrão para todos os textos
  textFont(uiFont);

  // ✅ cria o vídeo aqui (tem de estar em data/intro.m4v)
  // Associa o vídeo ao sketch atual (this)
  introMovie = new Movie(this, "intro.mp4");

  // Dá play uma vez para "acordar" o decoder de vídeo
  introMovie.play();

  // Pausa imediatamente o vídeo
  introMovie.pause();

  // Garante que o vídeo começa no frame inicial
  introMovie.jump(0);

  // --------- MÚSICA ---------
  try {
    // Carrega o ficheiro de música (tem de estar em data/)
    music = new SoundFile(this, "Mystery Unsolved.wav");

    // Define o volume da música
    music.amp(0.6);

    // Marca que a música está pronta para tocar
    // (vai tocar no primeiro clique do rato)
    musicOk = true;
  }
  catch(Exception e) {
    // Caso a música falhe, escreve o erro no console
    println("ERRO música: " + e);
    musicOk = false;
  }

  // Cria o objeto principal do jogo
  game = new Game();

  // Inicializa todos os assets e cenas do jogo
  game.setup();

  // ✅ passa o movie para dentro do Game
  // Assim as cenas podem controlar o vídeo
  game.introMovie = introMovie;
}

void draw() {
  // Atualiza estados do jogo (timers, lógica, etc.)
  game.update();

  // Desenha a cena atual do jogo
  game.draw();
}

void mousePressed() {
  // Em alguns sistemas a música só pode tocar após interação do utilizador
  if (musicOk && !musicStarted && music != null) {
    try {
      // Começa a tocar a música em loop
      music.loop();
      musicStarted = true;
    }
    catch(Exception e) {
      // Ignora erro silenciosamente
    }
  }

  // Encaminha o clique do rato para o jogo
  game.mousePressed(mouseX, mouseY);
}

// obrigatório pro vídeo atualizar frames
// Esta função é chamada automaticamente quando o vídeo tem um novo frame
void movieEvent(Movie m) {
  // Lê o frame atual do vídeo para poder desenhá-lo
  m.read();
}
