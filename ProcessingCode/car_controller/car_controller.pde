import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Slider slider;
Serial myPort;
Button button_w,button_a,button_s,button_d;
int signal = 0;
String motorStatus= "Not connected";
int speed = 0;
void setup() {
  size(450,500);
  cp5 = new ControlP5(this);
  slider = cp5.addSlider("speed");
  slider.setPosition(20,20).setSize(20,400).setMin(1).setMax(10).setNumberOfTickMarks(10);
  button_w = cp5.addButton("W").setPosition(190,100).setSize(70,70);
  button_a = cp5.addButton("A").setPosition(90,200).setSize(70,70);
  button_s = cp5.addButton("S").setPosition(190,200).setSize(70,70);
  button_d = cp5.addButton("D").setPosition(290,200).setSize(70,70);
  myPort = new Serial(this, Serial.list()[1], 9600); // Starts the serial communication
  printArray(Serial.list());
  myPort.bufferUntil('\n'); // Defines up to which character the data from the serial port will be read. The character '\n' or 'New Line'
}

void draw() {
  background(0);
  text("Status:", 190, 50);
  text(motorStatus, 190, 70); // Prints the string comming from the Arduino
  println(speed);
}
void serialEvent (Serial myPort){ // Checks for available data in the Serial Port
  motorStatus = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable
}
 
void keyPressed(){
  switch(key){
    case 'w':
      button_w.setColorBackground( color(0,114,221) );
      myPort.write(119);
      break;
    case 'a':
      button_a.setColorBackground( color(0,114,221) );
      myPort.write(97);
      break;
    case 's':
      button_s.setColorBackground( color(0,114,221) );
      myPort.write(115);
      break;
    case 'd':
      button_d.setColorBackground( color(0,114,221) );
      myPort.write(100);
      break;
  }
  //if (key == 'w' || key == 'W') {
  //  button.setColorBackground( color(255, 0, 0 ) );
  //}
}
void keyReleased(){
  switch(key){
    case 'w':
      button_w.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'a':
      button_a.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 's':
      button_s.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'd':
      button_d.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
  }
  //if (key == 'w' || key == 'W') {
  //  button.setColorBackground( color(255, 0, 0 ) );
  //}
}
void speed(int speed){
  myPort.write(speed);
}
