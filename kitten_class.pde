// The kitten: wanders aimlessly, but every few seconds picks an ant group
// and charges at it. When it reaches the group, it scatters all the ants.

class Kitten {
  PVector loc, vel;
  float spd;
  int cooldown;    // frames until next hunt
  boolean hunting;
  AntGroup prey;

  Kitten() {
    loc      = new PVector(random(60, width-60), random(60, height-60));
    vel      = new PVector(0, 0);
    spd      = 1.5;
    cooldown = int(random(220, 380));
    hunting  = false;
  }

  void update(AntGroup[] groups) {
    if (!hunting) {
      cooldown--;
      wander();
      if (cooldown <= 0) {
        prey     = groups[int(random(groups.length))];
        hunting  = true;
        cooldown = int(random(220, 380));
      }
    } else {
      huntPrey();
    }
    loc.add(vel);
    loc.x = constrain(loc.x, 12, width - 12);
    loc.y = constrain(loc.y, 12, height - 12);
  }

  void wander() {
    vel.x += random(-0.3, 0.3);
    vel.y += random(-0.3, 0.3);
    vel.limit(spd);
  }

  void huntPrey() {
    PVector dir = PVector.sub(prey.ants[0].loc, loc);
    if (dir.mag() < 25) {
      prey.scatterAll(loc);  // pounce!
      hunting = false;
      prey    = null;
    } else {
      dir.normalize();
      dir.mult(spd * 4);
      vel.lerp(dir, 0.15);   // smooth acceleration into charge
    }
  }

  void show() {
    int al = room.covered(loc) ? 80 : 255;
    pushMatrix();
    translate(loc.x, loc.y);

    // body
    fill(hunting ? color(225, 120, 40, al) : color(210, 175, 130, al));
    stroke(150, 105, 65, al);
    strokeWeight(1);
    ellipse(0, 2, 22, 16);

    // eyes
    fill(hunting ? color(255, 50, 0, al) : color(40, 200, 50, al));
    ellipse(-5, -1, 5, 5);
    ellipse( 5, -1, 5, 5);

    // pupils
    fill(0, 0, 0, al);
    ellipse(-5, -1, 2, 4);
    ellipse( 5, -1, 2, 4);

    popMatrix();
  }
}
