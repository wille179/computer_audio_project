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

void setup() {
  size(700,700);
  ttsMaker = new TextToSpeechMaker();
  ac = new AudioContext();
  p5 = new ControlP5(this);
  wp = new WavePlayer(ac,440,Buffer.SINE);
  p = new Panner(ac);
  
  glide = new Glide(ac,0.5,20);
  gain = new Gain(ac,1,glide);
  //gain.addInput(wp);
  p.addInput(wp);
  ac.out.addInput(p);
  p5.addSlider("Balance").setPosition(20,20).setSize(600,20).setRange(-1,1).setValue(0).setLabel("Balance Position");
  
  ac.start();
}

void draw() {
  background(0);
}

void Balance(float b) {
  p.setPos(b);
  glide.setValue(abs(b/2));
}