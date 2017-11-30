// ----- Sonification vars -----
Gain master_gain;
Glide master_glide;
SamplePlayer beep;
Glide beepRateGlide;
Panner p;

// ----- Logic vars -----
int workout = -1; // -1 means no sonification.
final String[] workoutLabel = {"Bench Press","Squat","Dead Lift"};
int reps = 0; //Reps done
int reps_wanted = 10; //Reps desired for a set
float[] repScores = new float[reps_wanted]; //For storing a score for a rep. Might need to find a better system.
float[] repThresholds = new float[2]; //For matching the sonification to the vertical motion and horizontal lines on grid.
boolean startWorkout = false;

//Initializes the sonification.
void setupSound() {  
  beep = getSamplePlayer("beep.wav");
  beep.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  beep.pause(true);
  beepRateGlide = new Glide(ac,1.0,10);
  p = new Panner(ac);
  p.addInput(beep);
  master_glide = new Glide(ac,0.05,20);
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
  p.setPos(gridX*1.2);
  if (startWorkout && workout != -1 && abs(gridX) > 0.2) {
    beep.pause(false);
  } else {
    beep.pause(true);
  }
  beepRateGlide.setValue(1.01+abs(gridX)*2.3);
  beep.setRate(beepRateGlide);
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