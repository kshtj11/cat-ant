// 10 ants in a chain: ant[0] chases the target, each next ant chases the one before it.
// scatter() shoos ants within a given radius (stomp or kitten attack).

class AntGroup {
  Ant[] ants;

  AntGroup() {
    ants = new Ant[10];
    for (int i = 0; i < ants.length; i++) ants[i] = new Ant();
  }

  void update(PVector target) {
    ants[0].update(target);
    for (int i = 1; i < ants.length; i++) ants[i].update(ants[i-1].loc);
  }

  void scatter(PVector src, float radius) {
    for (Ant a : ants) {
      if (PVector.dist(a.loc, src) < radius) a.scatter(src);
    }
  }

  // scatter whole group regardless of distance (used by kitten after pounce)
  void scatterAll(PVector src) {
    for (Ant a : ants) a.scatter(src);
  }

  void show() {
    for (Ant a : ants) a.show();
  }
}
