import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

// ----- System Variables ------
ControlP5 p5;
AudioContext ac;
PWindow win;
TextToSpeechMaker ttsMaker;
SamplePlayer ttsVoice;
int[] gridHoriz = new int[9];
int[] gridVert = new int[9];
int gridWidth = 700;
int gridHeight = 700;

// ----- Sonification Vars -----

public void settings() {
  size(gridWidth,gridHeight);
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
  drawGrid(gridVert,gridHoriz);
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