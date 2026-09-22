class TextBox {
  // Posição e tamanho da caixa
  float x, y, w, h;
// Espaçamentos internos
  float pad = 18;
  float portraitSize = 92;
  float portraitPad = 10;
// Construtor
  TextBox(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h;
  }
// Caixa simples (fallback)
  void draw(String txt) {
    // Fundo semitransparente
    noStroke();
    fill(0, 180);
    rect(x, y, w, h, 14);
// Texto
    fill(255);
    textAlign(LEFT, TOP);
    textSize(14);
    text(txt, x+pad, y+pad, w-2*pad, h-2*pad);
  }

  // Caixa com retrato e moldura (principal)
  void drawWithPortrait(PImage portrait, String name, String txt, PImage skin, PImage frame) {

    // SKIN do textbox
    if (skin != null) {
      image(skin, x, y, w, h);
    } else {
      noStroke();
      fill(0, 180);
      rect(x, y, w, h, 14);
    }

    // portrait area 
    float px = x + pad;
    float py = y + h - portraitSize - pad;
    float ps = portraitSize;

    // Desenha o retrato
    if (portrait != null) {
      image(portrait,
        px + portraitPad, py + portraitPad,
        ps - 2*portraitPad, ps - 2*portraitPad
      );
    } else {
      noStroke();
      fill(60);
      rect(px, py, ps, ps, 10);
    }

    // Frame por cima do retrato
    if (frame != null) {
      image(frame, px, py, ps, ps);
    } else {
      noFill();
      stroke(255);
      rect(px, py, ps, ps, 10);
    }

    // TEXTO
    float tx = px + ps + 18;
    float ty = y + pad + 6;
    float tw = w - (tx - x) - pad;
    float th = h - pad*2;
// Nome do personagem
    fill(255);
    textAlign(LEFT, TOP);
    textSize(14);
    text(name, tx, ty);
// Texto do diálogo
    textSize(13);
    text(txt, tx, ty + 22, tw, th - 22);
  }
// Retorna o Y do topo da caixa
  float topY() { return y; } // para posicionar botões acima do textbox
}

class OptionBox {
  // Posição e tamanho do botão
  float x, y, w, h;
  // Texto do botão
  String label;
// Construtor
  OptionBox(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x; this.y = y; this.w = w; this.h = h;
  }
// Desenha o botão
  void draw() {
    // Verifica se o rato está por cima
    boolean over = hit(mouseX, mouseY);
// Contorno do botão
    stroke(255);
    strokeWeight(over ? 3 : 1);
    // Fundo muda se estiver em hover
    fill(over ? color(40, 40, 70, 220) : color(20, 20, 40, 220));
    // Desenha o botão
    rect(x, y, w, h, 10);
// Texto do botão
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(14);
    text(label, x+12, y + h/2);
  }
// Verifica se o ponto clicado está dentro do botão
  boolean hit(float mx, float my) {
    return (mx >= x && mx <= x+w && my >= y && my <= y+h);
  }
}
