# 🕵️ Quarto 47 — Investigação

Jogo narrativo de investigação desenvolvido em **Processing (Java Mode)**.

O jogador assume o papel de um policial responsável por investigar a morte de uma cantora encontrada em seu quarto. Durante a investigação, é necessário analisar diferentes pontos da cena, conversar com uma vizinha, interpretar pistas e construir uma conclusão para o caso.

As decisões tomadas durante o jogo afetam a pontuação e podem levar a diferentes finais.

---

## 🎮 Como funciona

A investigação começa com uma introdução e um vídeo inicial. Depois disso, o jogador pode explorar o quarto e interagir com diferentes áreas.

Entre os principais pontos investigáveis estão:

- 🚪 Armário
- 🗄️ Cômoda
- 🛏️ Corpo / cama
- 🚶 Corredor e vizinha

Cada interação apresenta perguntas ou decisões relacionadas às evidências encontradas.

Para concluir o caso, todas as áreas principais precisam ter sido investigadas.

---

## 🔎 Mecânicas

O projeto utiliza um sistema simples de investigação baseado em:

- exploração por cliques;
- hotspots interativos;
- diálogos;
- perguntas de múltipla escolha;
- sistema de pontos e erros;
- progressão entre cenas;
- relatório final;
- escolha do principal suspeito;
- múltiplos finais.

As respostas consideradas mais coerentes com as pistas aumentam a pontuação. Decisões incorretas aumentam o número de erros.

---

## 🏁 Finais

O resultado final depende das decisões tomadas durante a investigação.

O jogo possui diferentes tipos de desfecho:

- **Final bom** — quando as evidências são interpretadas de forma consistente;
- **Final ambíguo** — quando existe uma hipótese possível, mas sem provas suficientes;
- **Final ruim** — quando há muitos erros ou as pistas não são relacionadas de forma coerente.

---

## 🧩 Estrutura do projeto

```text
a044499_MarcelaAlmeida/
│
├── a044499_MarcelaAlmeida.pde
├── Game.pde
├── AssetManager.pde
├── Hotspot.pde
├── UI.pde
│
├── SceneIntro.pde
├── SceneIntroVideo.pde
├── SceneRoom.pde
├── SceneQuiz.pde
├── SceneNeighbor.pde
├── SceneTimeline_Suspects_Ending.pde
│
└── data/
    ├── imagens
    ├── fontes
    ├── intro.mp4
    └── Mystery Unsolved.wav
```

### Principais arquivos

| Arquivo | Responsabilidade |
|---|---|
| `a044499_MarcelaAlmeida.pde` | Inicialização do Processing, música, vídeo e eventos principais |
| `Game.pde` | Controle do estado do jogo, cenas, pontuação e progresso |
| `AssetManager.pde` | Carregamento e gerenciamento das imagens |
| `Hotspot.pde` | Áreas clicáveis utilizadas durante a investigação |
| `UI.pde` | Caixas de diálogo e botões |
| `SceneIntro.pde` | Tela inicial |
| `SceneIntroVideo.pde` | Reprodução do vídeo de introdução |
| `SceneRoom.pde` | Exploração do quarto |
| `SceneQuiz.pde` | Perguntas relacionadas às evidências |
| `SceneNeighbor.pde` | Conversa com a vizinha |
| `SceneTimeline_Suspects_Ending.pde` | Linha do tempo, escolha do suspeito e finais |

---

## 🛠️ Tecnologias utilizadas

- **Processing**
- **Java Mode**
- `processing.sound`
- `processing.video`

O jogo é executado em uma janela de **960 × 540 pixels**.

---

## ▶️ Como executar

### 1. Instale o Processing

Baixe e instale o Processing:

https://processing.org/download

### 2. Instale as bibliotecas necessárias

No Processing, acesse:

```text
Sketch → Import Library → Manage Libraries
```

Instale:

- **Sound**
- **Video**

### 3. Abra o projeto

Abra o arquivo:

```text
a044499_MarcelaAlmeida.pde
```

no Processing.

### 4. Execute

Clique no botão **Run ▶**.

> A pasta `data` deve permanecer junto aos arquivos `.pde`, pois contém as imagens, fontes, música e vídeo utilizados pelo jogo.

---

## 🖱️ Controles

O jogo é controlado principalmente com o **mouse**.

- Clique nos botões para avançar;
- clique nas áreas do quarto para investigar;
- escolha respostas nas perguntas;
- passe o mouse sobre determinadas áreas para visualizar os hotspots disponíveis.

A música de fundo começa após a primeira interação do usuário.

---

## 🎯 Objetivo

Investigue todos os pontos disponíveis, interprete corretamente as evidências e construa uma linha do tempo coerente para chegar à melhor conclusão possível sobre o caso.

---

## 👩‍💻 Autoria

Projeto desenvolvido por **Marcela Almeida** utilizando Processing.
