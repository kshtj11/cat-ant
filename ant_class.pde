class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxForce;
  float maxSpeed;

  Ant() {
    location = new PVector(random(0, width), random(0, height));
    velocity = new PVector(random(-2,2), random(-2,2));
    acceleration = new PVector(0, 0);
    maxSpeed = random(0.4, 0.6);
    maxForce = 0.1;
  }

  void show() {
    fill(255,102,102);
    stroke(175,66,66);
    strokeWeight(4);
    ellipse(location.x, location.y, 4, 4);
    
    noStroke();
    ellipse(location.x, location.y, 4, 4);
  }

  void move() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);    
    location.add(velocity);
    acceleration.mult(0);
  }

  void bounce() {
    if (location.x > width || location.x <0){
      velocity.x *= -1; }
    if (location.y > height || location.y <0){
      velocity.y *= -1; } 
    }
    
    void applyForce(PVector force){
      acceleration.add(force);
    }
    
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);
    
    desired.normalize();
    desired.mult(maxSpeed);
    
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxForce);
    
    applyForce(steer);
  }
}
