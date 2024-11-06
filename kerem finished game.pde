float[] xPositions = {50, 200, 50, 200};
float[] yPositions = {50, 50, 250, 250};
float baseSpeed = 2.5;
float[] xSpeeds = new float[4];
float[] ySpeeds = new float[4];
int initialRectSize = 50;
int rectSize = initialRectSize;
int score = 0;

float timer = 20;
color[] colors = new color[4];
boolean gameActive = true;
boolean secondPhase = false;
String gameOverMessage = ""; 

int buttonX, buttonY, buttonW = 100, buttonH = 50;

void setup() {
  size(400, 400);
  textSize(20);
  initializeGame();
}

void initializeGame() {
  score = 0;
  timer = 20;
  gameActive = true;
  secondPhase = false;
  gameOverMessage = "";
  rectSize = initialRectSize;

  for (int i = 0; i < 4; i++) {
    xPositions[i] = random(width - rectSize);
    yPositions[i] = random(height - rectSize);
    xSpeeds[i] = random(1, baseSpeed);
    ySpeeds[i] = random(1, baseSpeed);
    colors[i] = color(random(255), random(255), random(255));
  }

  buttonX = width / 2 - buttonW / 2;
  buttonY = height / 2 + 40;
}

void draw() {
  background(255);

  if (gameActive && timer > 0) {
    timer -= 1 / 60.0;
  }

  if (timer <= 0 && score < 20) {
    endGame("You Lose!", color(255, 0, 0)); 
  } else if (score >= 20) {
    endGame("You Win!", color(0, 255, 0)); 
  }

  
  if (score == 10 && !secondPhase) {
    activateSecondPhase();
  }

  if (gameActive) {
    
    for (int i = 0; i < 4; i++) {
      fill(colors[i]);
      rect(xPositions[i], yPositions[i], rectSize, rectSize);

     
      xPositions[i] += xSpeeds[i];
      yPositions[i] += ySpeeds[i];

   
      if (xPositions[i] > width - rectSize || xPositions[i] < 0) {
        xSpeeds[i] = -xSpeeds[i];
      }
      if (yPositions[i] > height - rectSize || yPositions[i] < 0) {
        ySpeeds[i] = -ySpeeds[i];
      }
    }

    
    fill(0);
    text("Score: " + score, 10, 30);
    text("Timer: " + int(timer) + " s", 10, 60);
  } else {
 
    fill(gameOverMessage.equals("You Win!") ? color(0, 255, 0) : color(255, 0, 0));
    rect(0, 0, width, height); 
    fill(255); 
    textAlign(CENTER, CENTER);
    textSize(32);
    text(gameOverMessage, width / 2, height / 2);

    
    fill(0);
    rect(buttonX, buttonY, buttonW, buttonH);
    fill(255);
    textSize(16);
    text("Play Again", buttonX + buttonW / 2, buttonY + buttonH / 2 + 5);
  }
}

void activateSecondPhase() {
  secondPhase = true;
  rectSize = int(initialRectSize * 0.8) ;
  baseSpeed *= 1.2;

  for (int i = 0; i < 4; i++) {
    xSpeeds[i] = (xSpeeds[i] < 0 ? -baseSpeed : baseSpeed);
    ySpeeds[i] = (ySpeeds[i] < 0 ? -baseSpeed : baseSpeed);
  }
}

void endGame(String message, color bgColor) {
  gameActive = false;
  gameOverMessage = message;
}

void mousePressed() {
  if (gameActive) {

    for (int i = 0; i < 4; i++) {
      if (mouseX > xPositions[i] && mouseX < xPositions[i] + rectSize &&
          mouseY > yPositions[i] && mouseY < yPositions[i] + rectSize) {

            respawnRectangle(i); 
        break;
      }
    }
  } else {
   
    if (mouseX > buttonX && mouseX < buttonX + buttonW && mouseY > buttonY && mouseY < buttonY + buttonH) {
      initializeGame(); 
    }
  }
}


void respawnRectangle(int i) {
  xPositions[i] = random(width - rectSize);
  yPositions[i] = random(height - rectSize);
  colors[i] = color(random(255), random(255), random(255));
}
