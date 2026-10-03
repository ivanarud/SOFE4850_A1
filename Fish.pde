
class Fish {

  PVector position;
  PVector velocity;

  float speed;
  int fishColor;

  Fish(float x, float y) {

    position = new PVector(x, y);

    // Start swimming in a random direction.
    velocity = PVector.fromAngle(random(TWO_PI));

    speed = random(1.2, 2.2);

    fishColor = color(
      random(100, 255),
      random(100, 255),
      random(100, 255)
    );
  }

  void update(ArrayList<Food> foodList) {

    PVector desired = velocity.copy();

    // Mouse avoidance takes priority.
    if (mouseY > 65 &&
        dist(position.x, position.y,
             mouseX, mouseY) < 85) {

      desired = avoidMouse();

    } else {

      // Find a nearby food particle.
      Food nearest = findNearestFood(foodList);

      if (nearest != null) {

        desired = PVector.sub(
          nearest.position, position
        );

      } else {

        // Wander in a slightly random direction.
        desired.rotate(random(-0.05, 0.05));
      }
    }

    // Keep fish inside the aquarium.
    if (position.x < 30) desired.x = abs(speed);
    if (position.x > width - 30)
      desired.x = -abs(speed);

    if (position.y < 90) desired.y = abs(speed);
    if (position.y > height - 65)
      desired.y = -abs(speed);

    if (desired.mag() > 0) {
      desired.setMag(speed);

      // Smoothly change direction.
      velocity.lerp(desired, 0.08);
      velocity.setMag(speed);
    }

    position.add(velocity);

    // Final boundary protection.
    position.x = constrain(
      position.x, 20, width - 20
    );

    position.y = constrain(
      position.y, 80, height - 55
    );

    // Eat food when close enough.
    for (int i = foodList.size() - 1; i >= 0; i--) {

      Food food = foodList.get(i);

      if (PVector.dist(position, food.position) < 14) {
        foodList.remove(i);
      }
    }
  }

  // Find the closest food within detection range.
  Food findNearestFood(ArrayList<Food> foodList) {

    Food nearest = null;
    float closestDistance = 230;

    for (Food food : foodList) {

      float d = PVector.dist(
        position, food.position
      );

      if (d < closestDistance) {
        closestDistance = d;
        nearest = food;
      }
    }

    return nearest;
  }

  // Swim away from the mouse cursor.
  PVector avoidMouse() {

    PVector mouse = new PVector(mouseX, mouseY);

    PVector away = PVector.sub(
      position, mouse
    );

    if (away.mag() > 0) {
      away.normalize();
      away.mult(speed * 2);
    }

    return away;
  }

  void display() {

    pushMatrix();

    translate(position.x, position.y);
    rotate(velocity.heading());

    noStroke();

    // Tail
    fill(fishColor);
    triangle(-11, 0, -23, -10, -23, 10);

    // Body
    ellipse(0, 0, 29, 17);

    // Eye
    fill(255);
    ellipse(8, -4, 6, 6);

    fill(0);
    ellipse(9, -4, 3, 3);

    popMatrix();
  }
}
