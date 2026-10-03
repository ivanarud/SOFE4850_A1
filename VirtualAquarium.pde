
ArrayList<Fish> fishes = new ArrayList<Fish>();
ArrayList<Food> foods = new ArrayList<Food>();

boolean nightMode = false;
boolean paused = false;

int fishCount = 18;

void setup() {
  size(1000, 650);
  frameRate(60);

  // Create our initial fish population.
  for (int i = 0; i < fishCount; i++) {
    float x = random(50, width - 50);
    float y = random(100, height - 100);

    fishes.add(new Fish(x, y));
  }
}

void draw() {
  drawAquarium();

  if (!paused) {

    // Update food and remove expired particles.
    for (int i = foods.size() - 1; i >= 0; i--) {
      Food food = foods.get(i);
      food.update();

      if (food.expired()) {
        foods.remove(i);
      }
    }

    // Update each fish.
    for (Fish fish : fishes) {
      fish.update(foods);
    }
  }

  // Draw the food.
  for (Food food : foods) {
    food.display();
  }

  // Draw all fish.
  for (Fish fish : fishes) {
    fish.display();
  }

  // Draw the interface above the aquarium.
  drawUI();
}
