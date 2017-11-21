import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

// ----- System Variables ------
ControlP5 p5;
AudioContext ac;
PWindow win;
TextToSpeechMaker ttsMaker;
SamplePlayer ttsVoice;
int[] gridHoriz = {2,4,6,8,10,12,14,16,18};
int[] gridVert = {2,4,6,8,10,12,14,16,18};
int gridWidth = 600;
int gridHeight = 600;
int buffer = 100;
int b2 = buffer/2;
// gridX and gridY are a value between -1 and 1 showing the position of the mouse on the grid.
float gridX = 0;
float gridY = 0;

// ----- Sonification Vars -----

public void settings() {
  size(gridWidth+buffer,gridHeight+buffer);
}

void setup() {
  ttsMaker = new TextToSpeechMaker();
  ac = new AudioContext();
  win = new PWindow();
  surface.setTitle("Wizard's Magic Grid");
  
  //ac.start();
}

void draw() {
  background(0);
  drawGrid(b2,b2,gridVert,gridHoriz);
  stroke(0,255,255);
  fill(0,255,255);
  ellipse(mouseX,mouseY,5,5);
  
  gridX = ((mouseX > b2) ? ((mouseX < gridWidth+b2) ? mouseX - (b2): gridWidth) : 0) / (gridWidth / 2.0) - 1;
  gridY = ((mouseY > b2) ? ((mouseY < gridHeight+b2) ? mouseY - (b2): gridHeight) : 0) / (-1 * gridHeight / 2.0) + 1;
}

class PWindow extends PApplet {
  
  PWindow() {
    super();
    PApplet.runSketch(new String[] {"Test"}, this);
  }

  void settings() {
    size(700, 200);
  }

  void setup() {
    p5 = new ControlP5(this);
    setupP5();
    surface.setTitle("Control Menu");
  }

  void draw() {
    background(100);
  }
}