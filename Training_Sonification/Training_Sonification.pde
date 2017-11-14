import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

ControlP5 p5;
AudioContext ac;
TextToSpeechMaker ttsMaker;

SamplePlayer sp;

WavePlayer wp;

void setup() {
  size(700,700);
  ttsMaker = new TextToSpeechMaker();
  ac = new AudioContext();
  p5 = new ControlP5(this);
}

void draw() {
  background(0);
}