class AssetManager {
  PImage roomClosed, roomWardrobeOpen;

  // portraits (pequenos dentro da caixa)
  PImage police, vizinha, victimPortrait, victimBody;
  
   // fundo do corredor
  PImage corridorBg;

  // opcional (se ainda usas em algum lugar)
  PImage stalkerNormal, stalkerShadow;

  // UI
  PImage textboxSkin;     // Textbox.png
  PImage framePortrait;   // ex: simple.png (moldura)

  void loadAll() {
    roomClosed = loadImage("231_Sem_Titulo.png");
    roomWardrobeOpen = loadImage("231_Sem_Titulo2_1.png");

    police = loadImage("deseinhosvisual3.png");
    victimPortrait = loadImage("deseinhosvisual1.png");
    victimBody = loadImage("deseinhosvisual4.png");


    stalkerNormal = loadImage("443_Sem_Titulo_20251203195138.png");
    stalkerShadow = loadImage("443_Sem_Titulo_20251203195445.png");
    
    // corredor
    corridorBg = loadImage("udgr_fl_closed.png");

    textboxSkin = loadImage("Textbox.png");     // a imagem que enviaste
    framePortrait = loadImage("simple.png");    // escolhe uma das molduras
  }

  void drawRoom(boolean wardrobeOpen) {
    if (wardrobeOpen) image(roomWardrobeOpen, 0, 0, width, height);
    else image(roomClosed, 0, 0, width, height);
  }
  
  //novo helper (simples)
  void drawCorridor() {
    if (corridorBg != null) image(corridorBg, 0, 0, width, height);
    else background(15, 15, 25); // fallback
  }
}
