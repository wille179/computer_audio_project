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
int[] repThresholds = new int[2]; //For matching the sonification to the vertical motion and horizontal lines on grid.

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
  p.setPos(gridX*1.2);
  if (workout != -1 && abs(gridX) > 0.2) {
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
    //TODO: switch gridHoriz (horizontal red/green lines) and repThresholds (data regarding sonification) based on workout mode.
    case(0): 
      break;
    case(1): 
      break;
    case(2):
      break;
  }
    
}