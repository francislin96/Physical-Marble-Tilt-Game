#include <Servo.h>
#include <Arduino.h>
#include <SPI.h>

class LIS3DH {
  public:
    LIS3DH(int pin);
    void writeRegister(int reg, int data);
    int readRegister(int reg);
    void calculateAccel();
    float angleX();
    float angleY();
    void smoothData();
    void sendData();
    float average (float * array, int len);
    void moveServos(Servo servoX, Servo servoY);
    float getX();
    float getY();
    float getZ();
  private:
    int _pin;
    float _x = 0.0;
    float _y = 0.0;
    float _z = 0.0;
    int count = 0;
    static const int len = 5;
    float x_avg[len];
    float y_avg[len];
    float z_avg[len];
};

