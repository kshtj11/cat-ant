// Minimal Furniture class. Blocks player movement.
class Furniture {
  float x, y, w, h;
  color c;

  Furniture(float x, float y, float w, float h, color c) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.c = c;
  }

  boolean hits(float px, float py) {
    return px > x && px < x+w && py > y && py < y+h;
  }

  // Simple "push out" logic: find which side is closest and snap there
  void block(Player p) {
    if (!hits(p.loc.x, p.loc.y)) return;
    float dl = p.loc.x - x;
    float dr = (x + w) - p.loc.x;
    float dt = p.loc.y - y;
    float db = (y + h) - p.loc.y;
    
    float min = min(min(dl, dr), min(dt, db));
    if (min == dl) p.loc.x = x;
    else if (min == dr) p.loc.x = x + w;
    else if (min == dt) p.loc.y = y;
    else p.loc.y = y + h;
  }

  void draw() {
    fill(c);
    stroke(thickness(c));
    rect(x, y, w, h, 3);
  }

  color thickness(color c) {
    return color(red(c)*0.8, green(c)*0.8, blue(c)*0.8);
  }
}

class Room {
  Furniture[] stuff;

  Room() {
    stuff = new Furniture[] {
      new Furniture(20,  20, 100, 200, color(100, 70, 40)), // Wardrobe
      new Furniture(400, 20, 180, 100, color(120, 90, 60)), // Desk
      new Furniture(180, 380, 240, 200, color(160, 130, 90)), // Bed
      new Furniture(440, 400, 120, 150, color(110, 80, 50))  // Dresser
    };
  }

  void check(Player p) {
    for (Furniture f : stuff) f.block(p);
  }

  boolean covered(PVector v) {
    for (Furniture f : stuff) if (f.hits(v.x, v.y)) return true;
    return false;
  }

  void show() {
    // Floor rug
    fill(150, 80, 70, 100);
    rect(180, 150, 240, 180, 10);
    
    for (Furniture f : stuff) f.draw();
    
    // Walls
    stroke(100, 70, 40);
    strokeWeight(10);
    noFill();
    rect(5, 5, width-10, height-10);
    strokeWeight(1);
  }
}
