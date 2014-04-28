PImage sil;
PImage outline;
PImage skeleton;
int step = 0;

void setup() {
  size(400, 400);
  sil = loadImage("silhouette.png");
  outline = createImage(400, 400, ARGB);
  skeleton = createImage(400, 400, ARGB);
  outline.loadPixels();
  skeleton.loadPixels();
  for (int i = 0; i < sil.pixels.length; i++) {
    outline.pixels[i] = color(0, 0);
    skeleton.pixels[i] = color(0, 0);
  }
  outline.updatePixels();
  skeleton.updatePixels();
  sil.loadPixels();
  for (int i = 0; i < sil.pixels.length; i++) {
    if (alpha(sil.pixels[i]) > 50) {
      sil.pixels[i] = color(0);
    }
    else {
      sil.pixels[i] = color(0, 0);
    }
  }
  sil.updatePixels();
}

void draw() {
  //background(255);
  image(sil, 0, 0);
  image(skeleton, 0, 0);
  image(outline, 0, 0);
}

PImage peel(PImage from) {
  PImage to = createImage(400, 400, ARGB);
  to.loadPixels();
  for (int i = 0; i < width*height; i++) {
    int y = i / width;
    int x = i % width;
    //stroke(255, 0, 0);
    if (alpha(from.pixels[i]) > 50) {
      //println("x: " + x + ", y: " + y);
      int nbs = 0;
      for (int k = -1; k < 2; k++) {
        for (int j = -1; j < 2; j++) {
          try {
            //println((y + k)*width + x + j);
            if (alpha(from.pixels[(y + k)*width + x + j]) > 50) {
              nbs++;
            }
          }
          catch (Exception e) {
          }
        }
      }
      int nbsB = 0;
      for (int k = -4; k < 5; k++) {
        for (int j = -4; j < 5; j++) {
          try {
            //println((y + k)*width + x + j);
            if (alpha(from.pixels[(y + k)*width + x + j]) > 50) {
              nbsB++;
            }
          }
          catch (Exception e) {
          }
        }
      }
      if (nbs < 9) {
        to.pixels[i] = color(0, 0);
        if (step == 0) {
          outline.loadPixels();
          outline.pixels[i] = color(255);
          outline.updatePixels();
        }
        if (nbsB < 32) {
          println("here");
          skeleton.loadPixels();
          skeleton.pixels[i] = color(0, 0, 0);
          skeleton.updatePixels();
        }
      }
      else {
        to.pixels[i] = color(step*5, 127 + step*2.5, 0);
      }
    }
    else {
      to.pixels[i] = color(0, 0);
    }
  }
  to.updatePixels();
  return(to);
}

void keyPressed() {
  println(step);
  sil = peel(sil);
  //sil = peel;
  step++;
}
