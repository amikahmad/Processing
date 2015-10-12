int stepX;
int stepY;

void setup() {
  size(800, 400);
  background(0);
}

void draw() {
  // This sets the value range for hue and saturation at 800 or 400 using the colorMode command.
  // Thus hue is no longer defined as a number between 0 and 360 but instead one between 0 and 800.
  // Saturation is "re-mapped" to be a value between 0 and 400.
  colorMode(HSB, width, height, 100);
  
  // We add the value 2 to stepX and step Y to prevent them from being too small which would lead to longer display times.
  stepX = mouseX+2;
  stepY = mouseY+2;
  
  // These two nested loops process all the positions on the grid.
  // The y-position of the rectangle to be drawn is defined by gridY in the outer loop.
  // The value of y-position only increases when the inner loop has been processed (once a complete row of rectangles has been drawn).
  for (int gridY=0; gridY<height; gridY+=stepY){
    for (int gridX=0; gridX<width; gridX+=stepX){
      // The variables gridX and gridY are used not only to position the tile but also define the fill color.
      // The hue is determined by gridX.
      // The saturation value decreases proportionally to increases in the value of gridY.
      fill(gridX, height-gridY, 100);
      rect(gridX, gridY, stepX, stepY);
    }
  }
}