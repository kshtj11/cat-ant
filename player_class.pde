// The player you control. Arrow keys to move, space to stomp.

class Player {
  PVector loc;
  float spd, stompR;
  int stomping;  // frames of stomp effect remaining
  int stompWait; // cooldown frames
  boolean up, dn, lf, rt;

  Player(float x, float y) {
    loc    = new PVector(x, y);
    spd    = 3;
    stompR = 70;
    stomping = 0;
    stompWait = 0;
  }

  void update() {
    if (up) loc.y -= spd;
    if (dn) loc.y += spd;
    if (lf) loc.x -= spd;
    if (rt) loc.x += spd;
    loc.x = constrain(loc.x, 15, width - 15);
    loc.y = constrain(loc.y, 15, height - 15);  
    if (stomping > 0) stomping--;
    if (stompWait > 0) stompWait--;
  }

  boolean canStomp() {
    return stompWait == 0;
  }

  void press(int code, char k) {
    if (code == UP)    up = true;
    if (code == DOWN)  dn = true;
    if (code == LEFT)  lf = true;
    if (code == RIGHT) rt = true;
  }

  void release(int code, char k) {
    if (code == UP)    up = false;
    if (code == DOWN)  dn = false;
    if (code == LEFT)  lf = false;
    if (code == RIGHT) rt = false;
  }

  void startStomp() {
    stomping = 25;
    stompWait = 90; // 1.5 second cooldown at 60fps
  }

  void show() {
    // stomp ready icon (small yellow pulse above head)
    if (canStomp()) {
      fill(255, 230, 0, 150 + sin(frameCount*0.2)*100);
      noStroke();
      ellipse(loc.x, loc.y - 25, 8, 8);
    }

    // stomp shockwave ring
    if (stomping > 0) {
      noFill();
      stroke(255, 220, 50, stomping * 9);
      strokeWeight(4);
      ellipse(loc.x, loc.y, stompR * 2, stompR * 2);
    }

    // head
    fill(255, 212, 130);
    stroke(160, 110, 55);
    strokeWeight(2);
    ellipse(loc.x, loc.y, 24, 24);

    // eyes
    fill(50, 25, 0);
    noStroke();
    ellipse(loc.x - 5, loc.y - 2, 3, 3);
    ellipse(loc.x + 5, loc.y - 2, 3, 3);
  }
}
