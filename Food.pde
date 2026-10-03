
class Food {

  PVector position;

  float radius = 5;
  int lifetime = 900;

  Food(float x, float y) {

    position = new PVector(x, y);
  }

  void update() {

    // Food slowly sinks through the water.
    position.y += 0.35;

    // Food disappears after its lifetime.
    lifetime--;
  }

  boolean expired() {

    return lifetime <= 0 ||
           position.y > height - 50;
  }

  void display() {

    noStroke();

    fill(255, 195, 65);

    ellipse(
      position.x,
      position.y,
      radius * 2,
      radius * 2
    );
  }
}
