
void drawAquarium() {

  // Day/night background.
  if (nightMode) {
    background(12, 32, 75);
  } else {
    background(35, 145, 200);
  }

  noStroke();

  // Draw floating bubbles.
  for (int i = 0; i < 20; i++) {

    float x = (i * 73 + 35) % width;

    float y = (i * 49 - frameCount * 0.6)
              % (height - 40);

    if (y < 0) y += height - 40;

    noFill();

    stroke(200, 240, 255, 110);

    ellipse(x, y, 10, 10);
  }

  noStroke();

  // Draw the sandy bottom.
  fill(225, 195, 135);

  rect(0, height - 50, width, 50);

  // Draw underwater plants.
  for (int i = 0; i < 12; i++) {

    float x = i * 90 + 20;

    stroke(30, 130, 80);
    strokeWeight(5);
    noFill();

    // Slight movement of the plants.
    float sway = sin(frameCount * 0.025 + i) * 10;

    bezier(
      x, height - 50,
      x - 15, height - 85,
      x + sway, height - 115,
      x + sway, height - 140
    );
  }

  strokeWeight(1);
  noStroke();
}

void drawUI() {

  // Top information bar.
  fill(15, 45, 70, 220);

  rect(0, 0, width, 65);

  fill(255);

  textAlign(LEFT);
  textSize(24);

  text("VIRTUAL AQUARIUM", 20, 35);

  textSize(15);

  String mode = nightMode ? "Night" : "Day";

  text("Fish: " + fishes.size(), 620, 25);
  text("Food: " + foods.size(), 620, 48);

  text("Mode: " + mode, 810, 25);

  if (paused) {
    text("PAUSED", 810, 48);
  }

  // Bottom instruction bar.
  fill(15, 45, 70, 220);

  rect(0, height - 32, width, 32);

  fill(255);

  textSize(14);
  textAlign(CENTER);

  text(
    "Click: Feed Fish  |  N: Day/Night  |  P: Pause  |  R: Reset",
    width / 2,
    height - 11
  );
}
