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
  //initializes the ControlP5 instance, this is later used to create the buttons and slider
  cp5 = new ControlP5(this);
  //Creates the slider
  slider = cp5.addSlider("speed");
  slider.setPosition(20,20).setSize(20,400).setMin(1).setMax(10).setNumberOfTickMarks(10);
  // This uses the controlP5 library to create the WASD buttons on screen
  button_w = cp5.addButton("W").setPosition(190,100).setSize(70,70);
  button_a = cp5.addButton("A").setPosition(90,200).setSize(70,70);
  button_s = cp5.addButton("S").setPosition(190,200).setSize(70,70);
  button_d = cp5.addButton("D").setPosition(290,200).setSize(70,70);
  
  // Starts the serial (Bluetooth) communication using the Serial library
  myPort = new Serial(this, Serial.list()[1], 9600);
  //Prints the list of serial connections available to the host computer.
  printArray(Serial.list());
  myPort.bufferUntil('\n'); // Defines that the Bluetooth (seral) connection will read up to the new line character
}

void draw() {
  //Dawws the status and the background of the GUI
  background(0);
  text("Status:", 190, 50);
  text(motorStatus, 190, 70); // Prints the string comming from the bluetooth connection (Arduino)
  println(speed);
}
void serialEvent (Serial myPort){ // Checks for data from the Bluetooth connection
  motorStatus = myPort.readStringUntil('\n'); //Reads the data sent from the car
}

//Handles key pressed events
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

//Handles the key released events, ie. when the key is released change the color of the button back to normal and tell the car to stop
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
//This is for variable speed
void speed(int speed){
  myPort.write(speed);
}
