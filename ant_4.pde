int num = 250;
Ant[] ants = new Ant[num];
Sugar s;
PVector mouse;

void setup() {
  size(400, 400);
  noStroke();
  fill(0);
  for (int i=0; i<ants.length; i++) {
    ants[i] = new Ant();
  }
}

void draw() {

  background(255,255,191);
  mouse = new PVector(mouseX, mouseY);

  for (int i=0; i<ants.length; i++) {
    ants[i].show();
    ants[i].move();
    ants[i].bounce();
    
    if (s != null) {
      if (i==0){
        ants[0].seek(s.location);
      } else {
      ants[i].seek(ants[i-1].location);
      }    
    } 
  }

  if (mousePressed == true) {
    s = new Sugar(mouseX, mouseY);
  }

  if (s != null) {
    s.show();
  }
}
