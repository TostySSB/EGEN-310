import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Slider slider;
Serial myPort;
Button button_w,button_a,button_s,button_d;
int signal = 0;
String motorStatus= "Not connected";
int speed = 0;
boolean[] triggers;
void setup() {
  triggers = new boolean[4];
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
  text("" + triggers[0], 190, 300);
  text("" + triggers[1], 190, 310);
  text("" + triggers[2], 190, 320);
  text("" + triggers[3], 190, 330);
  if (!triggers[0] && !triggers[1] && !triggers[2] && !triggers[3]){
    myPort.write(0);
  }
  if (triggers[0] && !triggers[2] && !triggers[3]){ //just right motor reverse
    myPort.write(101);
  } else if (triggers[0] && triggers[2]) { //bolth right and left motor forward
    myPort.write(102);
    text("102", 190, 350);
  } else if (triggers[2] && !triggers[0] && !triggers[1] && !triggers[3]){ //just forward right motor
    myPort.write(103);
    text("103", 190, 350);
  } else if (triggers[1] && !triggers[2] && !triggers[3] && !triggers[0]){ //just reverse left motor
    myPort.write(104);
    text("104", 190, 350);
  } else if (triggers[1] && triggers[3]){ //both left and right motor reverse
    myPort.write(105);
    text("105", 190, 350);
  } else if (triggers[3] && !triggers[0] && !triggers[1]){ //just right motor reverse
    myPort.write(106);
    text("106", 190, 350);
  } else if (triggers[0] && triggers[3]){ //left forward, right reverse
    myPort.write(107);
    text("107", 190, 350);
  } else if (triggers[1] && triggers[2]){ //left reverse, right forward
    myPort.write(108);
    text("108", 190, 350);
  }
}
void serialEvent (Serial myPort){ // Checks for available data in the Serial Port
  motorStatus = myPort.readStringUntil('\n'); //Reads the data sent from the Arduino (the String "LED: OFF/ON) and it puts into the "ledStatus" variable
}
 
void keyPressed(){
  switch(key){
    case 's':
      button_w.setColorBackground( color(0,114,221) );
      myPort.write(119);
      break;
    case 'a':
      button_a.setColorBackground( color(0,114,221) );
      myPort.write(97);
      break;
    case 'w':
      button_s.setColorBackground( color(0,114,221) );
      myPort.write(115);
      break;
    case 'd':
      button_d.setColorBackground( color(0,114,221) );
      myPort.write(100);
      break;
    case 'f':
      triggers[0] = true;
      //myPort.write(101);
      break;
    case 'r':
      triggers[1] = true;
      //myPort.write(102);
      break;
    case 'o':
      triggers[2] = true;
      //myPort.write(103);
      break;
    case 'l':
      triggers[3] = true;
      //myPort.write(104);
      break;
  }
  //if (triggers[0] && !triggers[2] && !triggers[3]){ //just right motor reverse
  //  myPort.write(101);
  //} else if (triggers[0] && triggers[2]) { //both right and left motor forward
  //  myPort.write(102);
  //} else if (triggers[2] && !triggers[0] && !triggers[1] && !triggers[3]){ //just forward right motor
  //  myPort.write(103);
  //} else if (triggers[1] && !triggers[2] && !triggers[3] && !triggers[0]){ //just reverse left motor
  //  myPort.write(104);
  //} else if (triggers[1] && triggers[3]){ //both left and right motor reverse
  //  myPort.write(105);
  //} else if (triggers[3] && !triggers[0] && !triggers[1]){ //just right motor reverse
  //  myPort.write(106);
  //} else if (triggers[0] && triggers[3]){ //left forward, right reverse
  //  myPort.write(107);
  //} else if (triggers[1] && triggers[2]){ //left reverse, right forward
  //  myPort.write(108);
  //}
  
  
  //if (key == 'w' || key == 'W') {
  //  button.setColorBackground( color(255, 0, 0 ) );
  //}
}
void keyReleased(){
  switch(key){
    case 's':
      button_w.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'a':
      button_a.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'w':
      button_s.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'd':
      button_d.setColorBackground( color(0,44,92) );
      myPort.write(0);
      break;
    case 'f':
      triggers[0] = false;
      //myPort.write(101);
      break;
    case 'r':
      triggers[1] = false;
      //myPort.write(102);
      break;
    case 'o':
      triggers[2] = false;
      //myPort.write(103);
      break;
    case 'l':
      triggers[3] = false;
      //myPort.write(104);
      break;
  }
  //if (key == 'w' || key == 'W') {
  //  button.setColorBackground( color(255, 0, 0 ) );
  //}
}
void speed(int speed){
  myPort.write(speed);
}
