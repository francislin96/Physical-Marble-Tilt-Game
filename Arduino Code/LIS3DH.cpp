#include "LIS3DH.h"

LIS3DH::LIS3DH(int pin) {
  // CONSTRUCTOR FOR LIS3DH
  SPI.begin();
  pinMode(pin, OUTPUT);
  _pin = pin;
  writeRegister(0x20, 0b10001111);
}

void LIS3DH::writeRegister(int reg, int data) {
  // WRITES data TO REGISTER reg
  digitalWrite(_pin, LOW);
  SPI.transfer(reg);
  SPI.transfer(data);
  digitalWrite(_pin, HIGH);
}

int LIS3DH::readRegister(int reg) {
  // READS DATA AT REGISTER reg
  digitalWrite(_pin, LOW);
  SPI.transfer(reg | 0x80);
  byte reading = SPI.transfer(0);
  digitalWrite(_pin, HIGH);
  return reading;
}

void LIS3DH::calculateAccel() {
  // CALCULATE ACCELERATION BY READING REGISTER
  _x = (this->readRegister(0x28) + (this->readRegister(0x29) << 8))/32768.0*2.0;
  _y = (this->readRegister(0x2A) + (this->readRegister(0x2B) << 8))/32768.0*2.0;
  _z = (this->readRegister(0x2C) + (this->readRegister(0x2D) << 8))/32768.0*2.0;
}

float LIS3DH::angleY() {
  // CALCULATE ANGLEX
  float yA = average(y_avg, len);
  float zA = average(z_avg, len);
  return atan2(yA, zA);
}

float LIS3DH::angleX() {
  // CALCULATE ANGLEY
  float xA = average(x_avg, len);
  float yA = average(y_avg, len);
  float zA = average(z_avg, len);
  return -atan2((-xA), sqrt(yA*yA + zA*zA));
}

void LIS3DH::smoothData() {
  // SMOOTH ACCELERATION DATA
  if (count < len) {
    x_avg[count] = _x;
    y_avg[count] = _y;
    z_avg[count] = _z;
    count = count + 1;
  }
  else {
    for (int i = 0; i < len-1; i++) {
      x_avg[i] = x_avg[i+1];
      y_avg[i] = y_avg[i+1];
      z_avg[i] = z_avg[i+1];
    }
    x_avg[len-1] = _x;
    y_avg[len-1] = _y;
    z_avg[len-1] = _z;
  }
}

void LIS3DH::sendData() {
  // PRINT (SMOOTHED) ACCELERATION DATA
  Serial.print(average(x_avg, len), 6);Serial.print(",");
  Serial.print(average(y_avg, len), 6);Serial.print(",");
  Serial.println(average(z_avg, len), 6);
}

float LIS3DH::average (float * array, int len) {
  // CALCULATE AVERAGE OF A FLOAT ARRAY
  float sum = 0.0 ;
  for (int i = 0 ; i < len ; i++)
    sum += array [i] ;
  return  ((float) sum) / len ;
}

float LIS3DH::getX() {
  // RETURN X DATA
  return _x;
}

float LIS3DH::getY() {
  // RETURN Y DATA
  return _y;
}

float LIS3DH::getZ() {
  // RETURN Z DATA
  return _z;
}

void LIS3DH::moveServos(Servo servoX, Servo servoY) {
  // MOVE SERVOS BY ANGLEX AND ANGLEY

  // get angleX and angleY
  float angX = this->angleX();
  float angY = this->angleY();
//  Serial.print("angX: ");Serial.print(angX);Serial.print("  ");
//  Serial.print("angY: ");Serial.println(angY);
  servoX.write(-angX*180.0/PI + 90.0);
  delay(5);
  servoY.write(-angY*180.0/PI+90.0);
  delay(5);
}

