// ----- Sonification vars -----
int workout = -1; // -1 means no sonification.
final String[] workoutLabel = {"Bench Press","Squat","Dead Lift"};
Gain master_gain;
Glide master_glide;
SamplePlayer beep;
Glide beepRateGlide;
Panner p;


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