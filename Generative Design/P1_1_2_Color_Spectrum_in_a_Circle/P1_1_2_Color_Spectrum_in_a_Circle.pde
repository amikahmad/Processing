// For Processing 3.x

// P.1.1.2
// Color Spectrum in a Circle

// KEYS
// 1-5: segment count
// S: save PNG
// P: Save PDF

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int segmentCount = 360;
int radius = 300;

void setup(){
  size(800, 800);
}

void draw(){
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  noStroke();
  // The range for sauturation and brightness is re-mapped to the mouse coordinates via height and width.
  colorMode(HSB, 360, width, height);
  background(360);
    
  // The angle increment depends on how many segments are to be drawn (segmentCount).
  float angleStep = 360/segmentCount;

  
  beginShape(TRIANGLE_FAN);
  // The first vertex point is in the middle of the screen.
  vertex(width/2, height/2);
  for (float angle = 0; angle <= 360; angle += angleStep){
    // For other vertices, angle has to be converted from degrees (0-360) to radians (0-2pi) becasue the functions cos() and sin() require the angle be input this way.
    float vx = width/2 + cos(radians(angle))*radius;
    float vy = height/2 +sin(radians(angle))*radius;
    vertex(vx, vy);
    // The fill color for the next segment is defined: the hue (angle), saturation (mouseX), and brightness (mouseY). 
    fill(angle, mouseX, mouseY);
  }
  // The end of the color segment.
  endShape();
  
  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyReleased(){
  // The switch command checks the last key pressed, which enables easy switching between different cases.
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;

  switch(key){
  case '1':
    segmentCount = 360;
    break;
  case '2':
    segmentCount = 45;
    break;
  case '3':
    // If key 3 is pressed then the segmentCount value is set to 24.
    segmentCount = 24;
    break;
  case '4':
    segmentCount = 12;
    break;
  case '5':
    segmentCount = 6;
    break;
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}