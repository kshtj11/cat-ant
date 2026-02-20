// A single ant. Chases a target using Reynolds steering.
// scatter() makes it flee and go on cooldown before resuming chase.

class Ant {
  PVector loc, vel, acc;
  float maxSpd, maxForce;
  int scattered;  // frames left on scatter cooldown

  Ant() {
    // Spawn at edges
    if (random(1) > 0.5) {
      loc = new PVector(random(width), random(1) > 0.5 ? 0 : height);
    } else {
      loc = new PVector(random(1) > 0.5 ? 0 : width, random(height));
    }
    vel      = new PVector(0, 0);
    acc      = new PVector(0, 0);
    maxSpd   = random(0.6, 0.9); // Slower
    maxForce = 0.05;
    scattered = 0;
  }

  void update(PVector target) {
    if (scattered > 0) {
      scattered--;
      vel.mult(0.92);  // slow bleed-off after fleeing
    } else {
      seek(target);
      vel.add(acc);
      vel.limit(maxSpd);
    }
    acc.mult(0);
    loc.add(vel);
    bounce();
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, loc);
    desired.normalize();
    desired.mult(maxSpd);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    acc.add(steer);
  }

  // called when stomped or attacked by kitten
  void scatter(PVector src) {
    PVector flee = PVector.sub(loc, src);
    flee.normalize();
    flee.mult(maxSpd * 6);
    vel = flee;
    scattered = int(random(80, 150));
  }

  void bounce() {
    if (loc.x > width-5  || loc.x < 5)      { vel.x *= -1; loc.x = constrain(loc.x, 5, width-5);  }
    if (loc.y > height-5 || loc.y < 5)      { vel.y *= -1; loc.y = constrain(loc.y, 5, height-5); }
  }

  void show() {
    boolean under = room.covered(loc);
    if (scattered > 0) fill(150, 80, 30, under ? 45 : 175);
    else               fill( 55, 25,  0, under ? 60 : 255);
    noStroke();
    ellipse(loc.x, loc.y, 5, 5);
  }
}
