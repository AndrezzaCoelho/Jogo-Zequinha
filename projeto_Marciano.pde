// Variáveis Globais
int arvoreZequinha, cont = 0;
int limite = 10; // Objetivo: Limite de 10 tentativas
int recorde = -1; // Objetivo: Sistema de recordes
String palpite = "", mensagem = "";
boolean jogoFinalizado = false, emIntro = true; // Objetivo: Introdução com história

void setup() {
  size(1000, 800); 
  surface.setResizable(true); // Lógica para aumentar a tela
  textAlign(CENTER, CENTER);
  reiniciar();
}

void draw() {
  background(255, 230, 100); // Cores do Frevo (Amarelo)
  
  if (emIntro) {
    desenharZequinha(width/2, height/2 - 80);
    fill(200, 0, 0); textSize(26); text("ZEQUINHA EM OLINDA", width/2, height/2 + 20);
    
    // História com instrução clara de 1 a 100
    fill(50); textSize(15); 
    text("Zequinha desembarcou no Marco Zero na abertura do Carnaval.\n" +
         "Subiu o Morro da Conceição, dançou frevo, mas em Olinda\n" +
         "se perdeu entre os Bonecos Gigantes! Ele se escondeu em uma\n" +
         "das 100 árvores mágicas. Encontre-o em 10 chances antes que a\n" +
         "Quarta-feira de Cinzas chegue!", width/2, height/2 + 90);
         
    fill(0, 0, 255); text("Pressione ENTER para começar", width/2, height - 60);
  } else {
    // HUD - Recordes e Tentativas
    fill(0); textSize(14); text("Melhor Jogada: " + (recorde == -1 ? "Nenhuma" : recorde), width/2, 30);
    fill(200, 0, 0); text("Tentativas: " + cont + " / " + limite, width/2, 60);
    
    // Status e Instrução de intervalo
    fill(0, 50, 150); textSize(22); text(mensagem, width/2, height/2 - 80);
    textSize(16); fill(100); text("(Escolha um número entre 1 e 100)", width/2, height/2 - 50);

    // Campo de entrada
    fill(255); rect(width/2 - 60, height/2 - 20, 120, 60, 15);
    fill(0); textSize(30); text(palpite, width/2, height/2 + 10);

    if (jogoFinalizado) {
      desenharZequinha(width/2, height - 120);
      fill(200, 0, 0); text("Pressione ESPAÇO para reiniciar", width/2, height - 40);
    }
  }
}

void keyPressed() {
  if (emIntro && key == ENTER) emIntro = false;
  else if (!jogoFinalizado) {
    if (key >= '0' && key <= '9') palpite += key;
    else if (key == BACKSPACE && palpite.length() > 0) palpite = palpite.substring(0, palpite.length()-1);
    else if (key == ENTER && palpite.length() > 0) verificar();
  } else if (key == ' ') reiniciar();
}

void verificar() {
  int chute = int(palpite);
  cont++; 
  
  if (chute == arvoreZequinha) {
    mensagem = "É FREVO! Achou na árvore " + arvoreZequinha;
    if (recorde == -1 || cont < recorde) recorde = cont;
    jogoFinalizado = true;
  } else if (cont >= limite) {
    mensagem = "FIM DE JOGO! Ele estava na árvore " + arvoreZequinha;
    jogoFinalizado = true;
  } else {
    // Dicas de maior ou menor
    mensagem = (chute < arvoreZequinha) ? "MAIS ALTO!" : "MAIS BAIXO!";
  }
  palpite = "";
}

void reiniciar() {
  arvoreZequinha = int(random(1, 101)); // Sorteia entre 1 e 100
  cont = 0;
  palpite = "";
  mensagem = "Em qual árvore Zequinha se escondeu?";
  jogoFinalizado = false;
}

void desenharZequinha(float x, float y) {
  pushMatrix();
  translate(x, y);
  
  // Antenas
  stroke(0, 200, 80);
  strokeWeight(2);
  line(-10, -25, -20, -45);
  line(10, -25, 20, -45);
  fill(0, 255, 100);
  noStroke();
  ellipse(-20, -45, 8, 8);
  ellipse(20, -45, 8, 8);
  
  // Cabeça e Corpo (Formato de Gota Invertida)
  fill(0, 255, 100);
  ellipse(0, 0, 50, 60); 
  
  // Olhos de Alien (Grandes e Pretos)
  fill(0);
  pushMatrix();
  rotate(radians(15));
  ellipse(15, -10, 18, 28);
  popMatrix();
  pushMatrix();
  rotate(radians(-15));
  ellipse(-15, -10, 18, 28);
  popMatrix();
  
  // Brilho nos olhos
  fill(255, 50);
  ellipse(-12, -15, 5, 8);
  ellipse(12, -15, 5, 8);
  
  // Sombrinha de Frevo
  stroke(255, 0, 0);
  strokeWeight(3);
  line(15, 5, 40, -25); // Cabo
  noStroke();
  fill(255, 255, 0);
  arc(40, -25, 40, 25, PI, TWO_PI); // Cúpula Amarela
  fill(0, 100, 255);
  arc(40, -25, 20, 15, PI, TWO_PI); // Detalhe Azul
  
  popMatrix();
}
