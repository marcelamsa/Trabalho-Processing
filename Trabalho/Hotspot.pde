class Hotspot {
  // definindo as variaveis de posição e do texto
  float x, y, w, h;
  String label;
  // Construtor: define nome e área clicável
  Hotspot(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  // Verifica se o rato está dentro do hotspot
  boolean hit(float mx, float my) {
    return (mx >= x && mx <= x+w && my >= y && my <= y+h);
  }
  // Mostra um retangulo vermelho quando o rato passa por cima que mostra onde podes clicar
  void drawHint() {
    // Só desenha se o rato estiver dentro do hotspot
    if (hit(mouseX, mouseY)) {
      // Desenha um retângulo vermelho de destaque
      noFill();
      stroke(255, 0, 0);
      strokeWeight(2);
      rect(x, y, w, h);
      // Mostra o texto do hotspot por cima
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(14);
      text(label, x + w/2, y - 6);
    }
  }
}
