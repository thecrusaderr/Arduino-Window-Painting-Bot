#include <Servo.h>

Servo motorL;
Servo motorR;
Servo pen;
int lf = 2000;
int lb = 1000;
int rf = 1000;
int rb = 2000;
int n = 1500;
int up = 0;
int down = 20;

void setup()
{
  motorL.attach(5);
  motorR.attach(6);
  pen.attach(3);
  delay(2000);
  
  // INSERT PROCESSING CODE HERE
  {
    
  }
}

void loop()
{
}

void angleLeft(int ms)
{
  motorL.writeMicroseconds(lb);
  motorR.writeMicroseconds(rf);
  delay(ms);
  motorL.writeMicroseconds(n);
  motorR.writeMicroseconds(n);
  delay(1);
}

void angleRight(int ms)
{
  motorR.writeMicroseconds(rb);
  motorL.writeMicroseconds(lf);
  delay(ms);
  motorL.writeMicroseconds(n);
  motorR.writeMicroseconds(n);
  delay(1);
}

void drive(int ms)
{
  motorL.writeMicroseconds(lf);
  motorR.writeMicroseconds(rf);
  delay(ms);
  motorL.writeMicroseconds(n);
  motorR.writeMicroseconds(n);
  delay(1);
}

void penLower()
{
  pen.write(down);
}

void penRaise()
{
  pen.write(up);
}
