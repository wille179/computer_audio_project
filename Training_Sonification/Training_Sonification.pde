import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

// ----- System Variables ------
AudioContext ac;
ControlWindow cWin;
ControlP5 p5;
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


public void settings() {
  size(gridWidth+buffer,gridHeight+buffer);
}

void setup() {
  ttsMaker = new TextToSpeechMaker();
  ac = new AudioContext();
  cWin = new ControlWindow();
  surface.setTitle("Wizard's Magic Grid");
  setupSound();
}

void draw() {
  background(0);
  drawGrid(b2,b2,gridVert,gridHoriz);
  stroke(0,255,255);
  fill(0,255,255);
  
  gridX = ((mouseX > b2) ? ((mouseX < gridWidth+b2) ? mouseX - (b2): gridWidth) : 0) / (gridWidth / 2.0) - 1;
  gridY = ((mouseY > b2) ? ((mouseY < gridHeight+b2) ? mouseY - (b2): gridHeight) : 0) / (-1 * gridHeight / 2.0) + 1;
  ellipse(gridX*(gridWidth/2) + gridWidth/2 + b2,-gridY*(gridHeight/2) + gridHeight/2 + b2,5,5);
  updateSound();
}



public class ControlWindow extends PApplet {
  
  ControlWindow() {
    super();
    PApplet.runSketch(new String[] {"Test"}, this);
  }

  void settings() {
    size(700, 300);
  }

  void setup() {
    surface.setTitle("Control Menu");
    p5 = new ControlP5(this);
    setupP5();
  }

  void draw() {
    background(100);
  }
  
  void keyPressed() {
  switch(key) {
    case('0'): modeRadio.deactivateAll(); workout=-1;break;
    case('1'): modeRadio.activate(0); workout=0; break;
    case('2'): modeRadio.activate(1); workout=1;break;
    case('3'): modeRadio.activate(2); workout=2;break;
  }
  
}
  void ModeRadioButton(int mode) {
    workout = mode;
  }
  
  void MasterVolume(float vol) {
    master_glide.setValue(vol/10.0);
  }
}