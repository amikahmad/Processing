// P.1.0
// Hello, color

void setup() {
  size(720, 720);
  noCursor();
}

void draw() {
  // Set the color mode to the code passes through the hue spectrum.
  // HSB specifies the color model, the three values following specify the respective range.
  // NOTE: Hue can only be specified between 0 and 360.
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  noStroke();
  
  // We devide the y-value of the mouse position by 2 to get values from 0 to 360 on the color wheel.
  background(mouseY/2, 100, 100);
  
  // The halved y-value of the mousr position is subtracted from 360, creating values from 360 to 0.
  fill(360-mouseY/2, 100, 100);
  // The size of the color field changes relative to the x-value of the mouse position, with a side length between 1 and 720 pixels.
  rect(360, 360, mouseX+1, mouseX+1);
}