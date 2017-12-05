import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

// ----- System Variables ------
AudioContext ac;
ControlWindow cWin;
ControlP5 p5;
TextToSpeechMaker ttsMaker;
SamplePlayer ttsVoice;
float[] gridVert = {2,4,6,8,10,12,14,16,18};
int gridWidth = 600;
int gridHeight = 600;
int buffer = 150;
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

//Draws the grid in the main window, updates the global variables gridX and gridY with values between -1 and 1 as apropriate.
void draw() {
  background(0);
  drawGrid(b2,b2,gridVert,repThresholds);
  stroke(0,255,255);
  fill(0,255,255);
  
  gridX = ((mouseX > b2) ? ((mouseX < gridWidth+b2) ? mouseX - (b2): gridWidth) : 0) / (gridWidth / 2.0) - 1;
  gridY = ((mouseY > b2) ? ((mouseY < gridHeight+b2) ? mouseY - (b2): gridHeight) : 0) / (-1 * gridHeight / 2.0) + 1;
  ellipse(gridX*(gridWidth/2) + gridWidth/2 + b2,-gridY*(gridHeight/2) + gridHeight/2 + b2,5,5);
  updateSound();
}

void mousePressed() {
  //resets workout, toggles start/stop
  startWorkout = !startWorkout;
  reps = 0; //Reps done
  repScores = new float[reps_wanted]; //For storing a score for a rep. Might need to find a better system.
  repHalfDone = false;
  repInProgress = false;
  repTimer = 0;
}

//Class for managing menu window.
public class ControlWindow extends PApplet {
  
  //Setup for menu window.
  ControlWindow() {
    super();
    PApplet.runSketch(new String[] {"Test"}, this);
  }

  //Setup for menu window.
  void settings() {
    size(700, 300);
  }

  //Setup for menu window.
  void setup() {
    surface.setTitle("Control Menu");
    p5 = new ControlP5(this);
    setupP5();
  }

  //Drawing menu window.
  void draw() {
    background(100);
    text((!startWorkout?"Workout Paused":"Workout In Progress"),200,90);
    text("Reps: " + reps + " / " + reps_wanted,200,110);
  }
  
  //Watches for keypresses and switches modes appropriately.
  void keyPressed() {
    switch(key) {
      case('0'): modeRadio.deactivateAll(); workout=-1;break;
      case('1'): modeRadio.activate(0); workout=0; break;
      case('2'): modeRadio.activate(1); workout=1;break;
      case('3'): modeRadio.activate(2); workout=2;break;
    }
    setThresholds();
  }
  
  //Switches mode when radio button is selected.
  void ModeRadioButton(int mode) {
    workout = mode;
    setThresholds();
  }
  
  //Adjusts master volume when slider is moved.
  void MasterVolume(float vol) {
    master_glide.setValue(vol/5.0);
  }
  
  void MirrorSound(int mirror) {
    println("Mirror Sound" + mirror);
    if (mirror == 1) {
      mirror_sound = true;
    } else {
      mirror_sound = false;
    }
  }
}