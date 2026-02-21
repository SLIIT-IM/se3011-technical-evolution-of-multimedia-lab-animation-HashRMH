
int state = 0; 
int startTime;
int duration = 30; 


float px = 350, py = 175;
float step = 6;
float pr = 20;


float ox = 200, oy = 100;
float xs = 3, ys = 3;
float or = 15;


int score = 0;


boolean trails = false;

void setup() {
  size(700, 350);
}

void draw() {

  
  if (!trails) {
    background(240);  
  } else {
    fill(240, 40);     
    noStroke();
    rect(0, 0, width, height);
  }

 
  if (state == 0) {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Catch The Orb", width/2, height/2 - 20);
    text("Press ENTER to Start", width/2, height/2 + 20);
  }

  
  if (state == 1) {

    
    int timePassed = (millis() - startTime) / 1000;
    int timeLeft = duration - timePassed;

    if (timeLeft <= 0) {
      state = 2;
    }

    
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == DOWN)  py += step;
      if (keyCode == UP)    py -= step;
    }

    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    
    ox += xs;
    oy += ys;

    if (ox > width - or || ox < or) xs *= -1;
    if (oy > height - or || oy < or) ys *= -1;

   
    float d = dist(px, py, ox, oy);
    if (d < pr + or) {
      score++;
      ox = random(or, width - or);
      oy = random(or, height - or);
    }

    
    fill(255, 100, 100);
    ellipse(ox, oy, or*2, or*2);

    
    fill(50, 120, 220);
    ellipse(px, py, pr*2, pr*2);

    
    fill(0);
    textSize(16);
    textAlign(LEFT);
    text("Score: " + score, 20, 20);
    text("Time: " + timeLeft, 20, 40);
    text("Press T for Trails", 20, 60);
  }

  
  if (state == 2) {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Time Over!", width/2, height/2 - 20);
    text("Final Score: " + score, width/2, height/2 + 20);
    text("Press R to Restart", width/2, height/2 + 50);
  }
}

void keyPressed() {

 
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
    score = 0;
  }

  
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }

 
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}
