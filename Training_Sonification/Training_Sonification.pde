import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

ControlP5 p5;
AudioContext ac;
TextToSpeechMaker ttsMaker;
SamplePlayer ttsVoice;

SamplePlayer sp;

WavePlayer wp;
Panner p;
Gain gain;
Glide glide;

float balance = 0;
int framecount = 0;
boolean speak = true;

void setup() {
  size(700,700);
  ttsMaker = new TextToSpeechMaker();
  ac = new AudioContext();
  p5 = new ControlP5(this);
  wp = new WavePlayer(ac,440,Buffer.SINE);
  p = new Panner(ac);
  
  glide = new Glide(ac,0.5,20);
  gain = new Gain(ac,1,glide);
  gain.addInput(wp);
  p.addInput(gain);
  ac.out.addInput(p);
  p5.addSlider("Balance").setPosition(20,20).setSize(600,20).setRange(-1,1).setValue(0).setLabel("Balance Position");
  
  ac.start();
}

void draw() {
  background(0);
  if (abs(balance) > 0.5 && speak) {
     speach("Lean " + ((balance>0)?"left.":"right.")); 
     speak = false;
  } 
  framecount++;
  if (framecount > 150) {
     framecount=0;
     speak = true;
  }

}

void Balance(float b) {
  balance = b;
  p.setPos(b);
  glide.setValue(abs(b/4));
  wp.setFrequency(440 + (b * 50));
}