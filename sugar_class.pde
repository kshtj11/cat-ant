class Sugar {
  PVector location;

  Sugar(float x, float y) {
    location = new PVector(x, y);
  }

  void show() {
    fill(240);
    stroke(180);
    strokeWeight(3);
    ellipse(location.x, location.y, 8, 8);
  }
}
