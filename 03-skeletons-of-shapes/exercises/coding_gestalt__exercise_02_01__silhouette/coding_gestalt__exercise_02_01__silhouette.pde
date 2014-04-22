PImage silhouette;

void setup() {
  size(400, 400);
  silhouette = loadImage("silhouette.png");
}

void draw() {
  image(silhouette, 0, 0);
}
