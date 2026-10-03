
void mousePressed() {

  if (paused) return;

  // Only allow feeding inside the aquarium.
  if (mouseY > 70 && mouseY < height - 50) {

    // Drop several food particles.
    for (int i = 0; i < 5; i++) {

      float x = mouseX + random(-12, 12);
      float y = mouseY + random(-12, 12);

      foods.add(new Food(x, y));
    }
  }
}

void keyPressed() {

  // Press N to toggle night mode.
  if (key == 'n' || key == 'N') {

    nightMode = !nightMode;
  }

  // Press P to pause/resume.
  if (key == 'p' || key == 'P') {

    paused = !paused;
  }

  // Press R to reset the aquarium.
  if (key == 'r' || key == 'R') {

    foods.clear();

    fishes.clear();

    for (int i = 0; i < fishCount; i++) {

      fishes.add(new Fish(
        random(50, width - 50),
        random(100, height - 100)
      ));
    }
  }
}
