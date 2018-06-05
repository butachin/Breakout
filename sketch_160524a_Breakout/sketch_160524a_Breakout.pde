void setup() {
  size(400, 500);
}

float x = 0;
float y = 300;
float dx = 3;
float dy = 4;

int life_count = 3;

int hit1[][] = {{0,0,0,0}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}, {1,1,1,1}};

float r_w = 50.0; // racket width
float b_w = 30.0; // block width
float b_h = 30.0; // block height
float a_w = 15.0; // ball width
float a_h = 15.0; // ball height
float racket_x=0.0;
float racket_speed=25.0;

boolean started = false;

boolean checkHit1(float x, float y) {
  if (y + a_h < 460) return false;

  if (x + a_w >= mouseX && x <= mouseX + r_w) {
    return true;
  } else {
    return false;
  }
}
  
void show_block(int n, int j) {
  rect(b_w * n, 180+30*j, b_w, b_h);
}

int checkHitBlock(int n, int j, float x, float y) {
  float left   = b_w * n;
  float right  = b_w * (n + 1);
  float top    = 190+j*30;
  float bottom = 190+j*30 + b_h;
  float dx, dy;

  if ((x + a_w < left) ||
    (x >= right) ||
    (y + a_h < top) ||
    (y >= bottom)) {
    return 0;
  }

  if (x + a_w - left > right - x) {
    dx = right -x;
  } else {
    dx = x + a_w -left;
  } 

  if (y + a_h - top > bottom - y) {
    dy = bottom - y;
  } else {
    dy = y + a_h - top;
  } 

  if (dx > dy) {
    return 1;
  } else {
    return 2;
  }
}

void START(){
background(200,255,0);
  fill(0);
  textSize(55);
  text("Breakout",width/5,height/3);
  textSize(30);
  text("Press ENTER to START",width/8,height*2/3);
}
 
void BASE() {
  // move ball
  x = x + dx; 
  y = y + dy;
  textSize(20);
  
   if (keyPressed) {
     if (keyCode==RIGHT) {
        racket_x +=racket_speed;
      } else if (keyCode==LEFT) {
        racket_x -=racket_speed;
      }
    }
  
  if(y<=50 && y>=46){
    if(x>=racket_x && x<=racket_x+r_w){
      dy=4;
     }
  }

  // check reflection
  if (x + a_w >= width) {
    dx = -3;
  } else if (x < 0) {
    dx = 3;
  }

  if (y + a_w > height) {
    x = 0;
    y = 300;
    dx = 3;
    dy = 4;
    life_count --;
  } else if (y < 0) {
    x =0;
    y =140;
    dx =3;
    dy =-4;
    life_count --;
  }
  
  background(255);
  fill(250,255,0);
  ellipse(x, y, a_w, a_w); // ball
  fill(0, 255, 0);
  rect(mouseX, 450, r_w, 4); // pad_sita
  rect(racket_x, 40, r_w, 4);//pad_ue

  for (int i = 0; i<hit1.length; i++) { // <---
  for(int m=0;m<4;m++){
    if (hit1[i][m] > 0) { // <---
      show_block(i,m); // <---
      switch (checkHitBlock(i,m, x, y)) { // <---
      case 1:
        dy = -dy;
        hit1[i][m]--; // <---
        break;
      case 2:
        dx = -dx;
        hit1[i][m]--;
        break;
      }
    }
  }
  } // <---

  fill(0); 
  text(life_count, 10, height); 
  text("LIFE", 10, height-20);

  if (checkHit1(x, y)) {
    dy = -4;
     }
   if(life_count==0){
     noLoop();
     textSize(40);
     text("GAME OVER",width/5,height/2);
   }
 }


void draw(){
  START();
  if(keyCode==ENTER) started = true;
  if(started == true){
    BASE();
  }
}
    
  