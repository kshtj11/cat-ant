// Cat, Ant & Stomps — main sketch

Player    player;
AntGroup[] groups;
Kitten    kitten;
Room      room;

void setup() {
  size(600, 600);
  room   = new Room();
  player = new Player(300, 260);
  groups = new AntGroup[5];
  for (int i = 0; i < groups.length; i++) groups[i] = new AntGroup();
  kitten = new Kitten();
}

void draw() {
  background(210, 184, 144);  // wood floor
  room.show();                // rug + furniture + walls

  for (AntGroup g : groups) {
    g.update(player.loc);
    g.show();
  }

  kitten.update(groups);
  kitten.show();

  player.update();
  room.check(player);  // push player out of furniture
  player.show();

  drawHint();
}

void drawHint() {
  fill(75, 55, 35, 175);
  noStroke();
  textAlign(CENTER);
  textSize(12);
  text("Arrow keys: move  |  Space: stomp", width/2, height - 12);
}

void keyPressed() {
  player.press(keyCode, key);
  if (key == ' ' && player.canStomp()) {
    player.startStomp();
    for (AntGroup g : groups) g.scatter(player.loc, player.stompR);
  }
}

void keyReleased() {
  player.release(keyCode, key);
}
