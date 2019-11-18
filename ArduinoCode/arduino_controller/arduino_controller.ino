#include <Servo.h>

Servo servoLeft, servoRight;
char state = 'Not Connected';
void setup() {
  servoLeft.attach(9);
  servoRight.attach(10);
  //pinMode(ledPin, OUTPUT);
  //digitalWrite(ledPin, LOW);
  Serial.begin(9600); // Default communication rate of the Bluetooth module
  Serial.println("Motors OFF");
}
void loop() {
  if (Serial.available() > 0) { // Checks whether data is comming from the serial port
    state = Serial.read(); // Reads the data from the serial port
    Serial.println(state);
  }
  // if (state == '0') {
  //  digitalWrite(ledPin, LOW); // Turn LED OFF
  //  Serial.println("LED: OFF"); // Send back, to the phone, the String "LED: ON"
  //  state = 0;
  // }
  // else if (state == '1') {
  //  digitalWrite(ledPin, HIGH);
  //  Serial.println("LED: ON");;
  //  state = 0;
  // }
  switch(state){
    case 'w':
      Serial.println(state);
      servoRight.write(135);
      servoLeft.write(45);
      break;
    case 'a':
      Serial.println(state);
      servoRight.write(135);
      servoLeft.write(135);
      break;
    case 's':
      Serial.println(state);
      servoRight.write(45);
      servoLeft.write(135);
      break;
    case 'd':
      Serial.println(state);
      servoRight.write(45);
      servoLeft.write(45);
      break;
    default:
      Serial.println(state);
      servoRight.write(95);
      servoLeft.write(94);
      break;
  }
  
//  if (state == 119) { //w
//    Serial.println(state);
//    servoRight.write(135);
//    servoLeft.write(45);
//    
//  } else if (state == 115) {//s
//    Serial.println(state);
//    servoRight.write(45);
//    servoLeft.write(135);
//  } else if (state == 97) {//a
//    Serial.println(state);
//    servoRight.write(135);
//    servoLeft.write(135);
//  } else if (state == 100) { //d
//    Serial.println(state);
//    servoRight.write(45);
//    servoLeft.write(45);
//  } else {
//    Serial.println(state);
//    servoRight.write(95);
//    servoLeft.write(94);
//  }
}
