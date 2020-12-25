#include <Servo.h>

Servo motorL;
Servo motorR;
Servo pen;
int xRead; 
int xRest = 616;
int sensorpin = 0;
int n = 1500;
int lf = 1000;
int lb = 2000;
int rf = 2000;
int rb = 1000;
int up = 150;  //  Servo position to have pen not touching window
int down = 165;  //  Servo position to have pen touching window
int pos = 0;
int cur = 0;
double convert = 0.857;
int dest = 0;
int buf = 20;
int bufSpeed = 1;
int zero = 2;
int one80 = 178;

void setup()
{
  motorL.attach(6);
  motorR.attach(5);
  pen.attach(3);
  delay(1000);
  buffer();
  pen.write(up);
  delay(1000);
  // COPY CODE HERE
  {

  }
}

void loop()
{
}

void calibrate(int aMax, int aMin)
{
  xRest = aMax;
  convert = (180.0/(aMax - aMin));
}

void angleLeft(int angle)
{
  if(pos + angle < 360)
  {
    dest = pos + angle;
  }
  else
  {
    dest = pos + angle - 360;
  }
  motorL.writeMicroseconds(lb);
  motorR.writeMicroseconds(rf);
  delay(1);
  if(pos <= 180 && dest <= 180 && dest >= pos)
  {
    while(cur <= dest)
    {
      buffer();
    }
  }
  else if(pos <= 180 && dest > 180)
  {
    while(cur <= one80)
    {
      buffer();
    }
    while(cur >= 360 - dest)
    {
      buffer();
    }
  }
  else if(pos >= 180 && dest >= 180 && angle <= 180)
  {
    while(cur >= 360 - dest)
    {
      buffer();
    }
  }
  else if(pos >= 180 && dest < 180)
  {
    while(cur >= zero)
    {
      buffer();
    }
    while(cur <= dest)
    {
      buffer();
    }
  }
  else if(pos <= 180 && dest <= 180 && pos >= dest)
  {
    while(cur >= zero)
    {
      buffer();
    }
    while(cur <= dest)
    {
      buffer();
    }
  }
  else
  {
    while(cur <= one80)
    {
      buffer();
    }
    while(cur >= 360 - dest)
    {
      buffer();
    }
  }
  motorL.writeMicroseconds(n);
  motorR.writeMicroseconds(n);
  delay(1);
  pos = dest;
}

void angleRight(int angle)
{
  if(pos - angle > 0)
  {
    dest = pos - angle;
  }
  else
  {
    dest = pos - angle + 360;
  }
  motorL.writeMicroseconds(lf);
  motorR.writeMicroseconds(rb);
  delay(1);
  if(pos >= 180 && dest >= 180 && dest < pos)
  {
    while(cur < (360 - dest))
    {
      buffer();
    }
  }
  else if(pos >= 180 && dest >= 180)
  {
    while(cur >= zero)
    {
      buffer();
    }
    while(cur <= 360 - dest)
    {
      buffer();
    }
  }
  else if(pos >= 180 && dest <= 180)
  {
    while(cur <= one80)
    {
      buffer();
    }
    while(cur >= dest)
    {
      buffer();
    }
  }
  else if(pos <= 180 && dest <= 180 && pos > dest)
  {
    while(cur >= dest)
    {
      buffer();
    }
  }
  else if(pos <= 180 && dest <= 180)
  {
    while(cur <= one80)
    {
      buffer();
    }
    while(cur >= dest)
    {
      buffer();
    }
  }
  else
  {
    while(cur >= zero)
    {
      buffer();
    }
    while(cur <= 360 - dest)
    {
      buffer();
    }
  }
  motorL.writeMicroseconds(n);
  motorR.writeMicroseconds(n);
  delay(1);
  pos = dest;
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

void buffer()
{
  int temp = 0;
  int total = 0;
  for(int i = 0; i < buf; i++)
  {
    xRead = analogRead(sensorpin);
    temp = xRest - xRead;
    delay(bufSpeed);
    total += temp;
    temp = 0;
  }
  cur = round((total * 1.0 / buf) * convert);
}
