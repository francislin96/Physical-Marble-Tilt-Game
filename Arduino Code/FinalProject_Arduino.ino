// include necessary packages/libraries
#include "LIS3DH.h"
#define LIS3DH_CS 10
#define SERVO_X_PIN 6
#define SERVO_Y_PIN 5

// initialize accelerometer and servos
LIS3DH accel = LIS3DH(LIS3DH_CS);
Servo servoX;
Servo servoY;

void setup() {
  Serial.begin(9600);
  pinMode(SERVO_X_PIN, OUTPUT);
  pinMode(SERVO_Y_PIN, OUTPUT);
  servoX.attach(SERVO_X_PIN);servoX.write(90);
  servoY.attach(SERVO_Y_PIN);servoY.write(90);
  pinMode(A0, INPUT);
  delay(100);
}

void loop() {
  accel.calculateAccel();
  accel.smoothData();
  accel.moveServos(servoX, servoY);
//  Serial.println(analogRead(A0));
  if (analogRead(A0) < 50) {
    Serial.println("game_ended");
  }
  delay(25);
}

