// ----- Sonification vars -----
Gain master_gain;
Glide master_glide;

SamplePlayer beep;
Glide beepRateGlide;
Panner p;
boolean mirror_sound = false;

WavePlayer power_tone;
Gain power_tone_gain;
Glide power_tone_glide;

SamplePlayer rep_ding;
SamplePlayer lean_left;
SamplePlayer lean_right;



// ----- Logic vars -----
int workout = -1; // -1 means no sonification.
final String[] workoutLabel = {"Bench Press","Squat","Dead Lift"};
int reps = 0; //Reps done
int reps_wanted = 10; //Reps desired for a set
float[] repScores = new float[reps_wanted]; //For storing a score for a rep. Might need to find a better system.
float[] repThresholds = new float[2]; //For matching the sonification to the vertical motion and horizontal lines on grid.
boolean repHalfDone = false;
boolean repInProgress = false;
int repTimer = 0;
boolean startWorkout = false;

//Initializes the sonification.
void setupSound() {  
  beep = getSamplePlayer("beep.wav");
  beep.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  beep.pause(true);
  beepRateGlide = new Glide(ac,1.0,10);
  p = new Panner(ac);
  p.addInput(beep);
  
  lean_left = getSamplePlayer("tts_common/lean_left.wav");
  lean_left.pause(true);
  lean_right = getSamplePlayer("tts_common/lean_right.wav");
  lean_right.pause(true);
  
  p.addInput(lean_left);
  p.addInput(lean_right);
  
  master_glide = new Glide(ac,0.1,20);
  master_gain = new Gain(ac,2,master_glide);
  master_gain.addInput(p);
  ac.out.addInput(master_gain);
  ac.start();
  
}

//Updates the sonification.
//This is where all the magic happens.
void updateSound() {
  if (workout == -1) {
    startWorkout = false;
  }
  if(lean_left.getSample().getLength() * 3 < lean_left.getPosition()){
    lean_left.setPosition(0);
  }
  if (lean_right.getSample().getLength() * 3 < lean_right.getPosition()) {
    lean_right.setPosition(0);
  }
  
  p.setPos(gridX*1.2*(mirror_sound?-1:1));
  if (startWorkout && workout != -1 && abs(gridX) > 0.2) {
    beep.pause(false);
    lean_left.pause(true);
    lean_right.pause(true);
    float lean_limit = 0.5 * (mirror_sound?-1:1);
    if (gridX < -1 * lean_limit) {
      lean_right.pause(false);
    } else if (gridX > lean_limit) {
      lean_left.pause(false);
    }
  } else {
    beep.pause(true);
  }
  beepRateGlide.setValue(1.01+abs(gridX)*2.3);
  beep.setRate(beepRateGlide);
  updateWorkout();
}

//Helper method for updating the thresholds when workout mode changes.
void setThresholds() {
  switch(workout) {
    //Green red Green
    //Voice at second green
    case(0):
      //Down
      repThresholds[0] = 14;
      repThresholds[1] = 6;
      break;
    case(1):
      //Down
      repThresholds[0] = 17;
      repThresholds[1] = 5;
      break;
    case(2):
      //Up
      repThresholds[0] = 7;
      repThresholds[1] = 19;
      break;
    default:
      repThresholds[0] = 0;
      repThresholds[1] = 0;
  }
    
}

void updateWorkout() {
  if (!startWorkout || workout < 0) {
    return;
  }
  float bottom = max(repThresholds[0],repThresholds[1]) / (lines*-1.0);
  float top = min(repThresholds[0],repThresholds[1]) / (lines*-1.0);
  boolean down = repThresholds[0] > repThresholds[1];
  float green = -1.0*repThresholds[1]/(lines/2) + 1;
  float red = -1.0*repThresholds[0]/(lines/2) + 1;
  if (down && reps < reps_wanted) {
    if (repInProgress) {
      if (repHalfDone) {
        if (gridY >= green) {
          repHalfDone = false;
          repInProgress = false;
          reps += 1;
        }
      } else {
        if (gridY <= red) {
          repHalfDone = true;
          //TODO: play ding
        }
      }
    } else {
      if (gridY <= green) {
        repInProgress = true;
      }
    }
  } else if (!down && reps < reps_wanted) {
    if (repInProgress) {
      if (repHalfDone) {
        if (gridY <= green) {
          repHalfDone = false;
          repInProgress = false;
          reps += 1;
        }
      } else {
        if (gridY >= red) {
          repHalfDone = true;
          //TODO: play ding
        }
      }
    } else {
      if (gridY >= green) {
        repInProgress = true;
      }
    }
  } else {
    //TODO: Summarize workout, startWorkout = false
  }
  //println("Rep in progress: " + repInProgress);
  //println("Rep halfDone: " + repHalfDone);
  //println("Reps: " + reps);
  
  //if (workout == 0) { //Bench Press
    
  //} else if (workout == 1) {//Squat
    
  //} else { //Dead Lift
    
  //}
}