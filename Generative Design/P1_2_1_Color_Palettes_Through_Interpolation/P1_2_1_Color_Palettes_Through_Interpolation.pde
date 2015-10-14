// For Processing 3.x

// P.1.2.1
// Color Palettes Through Interpolation

// Color is defined by several values, so it is necessary to interpolate between the values.
// Interpolation is a method of constructing new data points within the range of a discrete set of known data points.
// Depending on the color model, HSB or RGB, the same color is defined by different values.
// Depending on which color model you choose, the path from one color to another is different.
// This is true even if the origin color and destination color is the same.
// HSB or RGB will take a different course to get from one to the other.
// Thus it is important to choose the appropriate color model to solve a specific problem.

// MOUSE
// LEFT CLICK: new random color set
// POSITION X: resolution
// POSITION Y: number of rows

// KEYS
// 1-2: interpolation style
// S: save PNG
// P: Save PDF
// C: save ASE pallete

import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int tileCountX = 2;
int tileCountY = 10;

color[] colorsLeft = new color[tileCountY];
color[] colorsRight = new color[tileCountY];
color[] colors;

boolean interpolateShortest = true;


void setup() { 
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100); 
  noStroke();
  shakeColors();
}

void draw() {
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    noStroke();
    colorMode(HSB, 360, 100, 100, 100);
  }

  // A variable for the number of color gradations mapped to the mouse
  tileCountX = (int) map(mouseX, 0, width, 2, 100);
  // A variable for the number of rows mapped to the mouse
  tileCountY = (int) map(mouseY, 0, height, 2, 10);
  float tileWidth = width / (float)tileCountX;
  float tileHeight = height / (float)tileCountY;
  color interCol;

  // For ASE export
  colors = new color[tileCountX*tileCountY];
  int i = 0;

  // Draw the grid row by row
  for (int gridY = 0; gridY < tileCountY; gridY++) {
    // The colors are set for the left and right columns in the arrays colorsLeft and colorsRight.
    color col1 = colorsLeft[gridY];
    color col2 = colorsRight[gridY];

    for (int gridX = 0; gridX < tileCountX; gridX++) {
      float amount = map(gridX, 0, tileCountX - 1, 0, 1);

      if (interpolateShortest) {
        colorMode(RGB, 255, 255, 255, 255);
        // The intermediary colors are calculated with lerpColor().
        // This function performs interpolation between the individual color values.
        // The variable amount, a value between 0 and 1, specifies the position between the start and end color.
        interCol = lerpColor(col1, col2, amount);
        // Switch back to HSB
        colorMode(HSB, 360, 100, 100, 100);
      } else {
        interCol = lerpColor(col1, col2, amount);
      }
      fill(interCol);

      float posX = tileWidth*gridX;
      float posY = tileHeight*gridY;
      rect(posX, posY, tileWidth, tileHeight);

      // For ASE export
      colors[i] = interCol;
      i++;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void shakeColors() {
  for (int i=0; i<tileCountY; i++) {
    colorsLeft[i] = color(random(0, 60), random(0, 100), 100);
    colorsRight[i] = color(random(160, 190), 100, random(0, 100));
  }
}

void mouseReleased() {
  shakeColors();
}

void keyReleased() {
  if (key == 'c' || key == 'C') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;

  if (key == '1') interpolateShortest = true;
  if (key == '2') interpolateShortest = false;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}