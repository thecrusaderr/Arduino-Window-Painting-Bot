int i = 2;
int[] pts = new int[500];
int x1;
int x2;
int y1;
int y2;
boolean start = true;
int w = 200;
int h = 200;
int s = 8;
int scale = 3;
int aMin = 406;
int aMax = 616;
boolean homePoint = false;
boolean backHome = false;
boolean done = false;
float pi = 3.141;
int penCount = 0;

void setup() 
{
  size(1000, 750);
  background(0);
}

void mousePressed()
{
  x1 = mouseX;
  y1 = mouseY;
  if(start)
  {
    if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 150 && mouseY < height/4 + 180)
    {
      start = false;
      stroke(255);
      fill(50);
      rect(width/4, 50, w * 3, h * 3);
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 - 60 && mouseY < height/4 - 30)
    {
      if(mouseButton == LEFT)
      {
        aMax += 1;
      }
      else
      {
        aMax -=1;
      }
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 - 110 && mouseY < height/4 - 80)
    {
      if(mouseButton == LEFT)
      {
        aMin += 1;
      }
      else
      {
        aMin -=1;
      }
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 100 && mouseY < height/4 + 130)
    {
      if(mouseButton == LEFT)
      {
        s++;
      }
      else
      {
        s--;
      }
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 50 && mouseY < height/4 + 80)
    {
      if(mouseButton == LEFT)
      {
        w+=5;
      }
      else
      {
        w-=5;
      }
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 && mouseY < height/4 + 30)
    {
      if(mouseButton == LEFT)
      {
        h+=5;
      }
      else
      {
        h-=5;
      }
    }
  }
  if(!start)
  {
    if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 200 && mouseY < height/4 + 230)
    {
      if(mouseButton == LEFT && i > 0)
      {
        stroke(50);
        line(pts[i-4], pts[i-3], pts[i-2], pts[i-1]);
        i-=4;
        stroke(255);
      }
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 250 && mouseY < height/4 + 280)
    {
      homePoint = true;
    }
    else if(mouseX > 10 && mouseX < 210 && mouseY > height/4 + 300 && mouseY < height/4 + 330)
    {
      createCode(pts);
    }
  }
}

void mouseReleased()
{
  x2 = mouseX;
  y2 = mouseY;
  if(x1 > width/4 && x1 < width/4 + scale * w && y1 > 50 && y1 < 50 + scale * h && x2 > width/4 && x2 < width/4 + scale * w && y2 > 50 && y2 < 50 + scale * h)
  {
    pts[i] = x1;
    pts[i + 1] = y1;
    pts[i + 2] = x2;
    pts[i + 3] = y2;
    line(x1, y1, x2, y2);
    i+=4;
  }
  if(homePoint && x2 > width/4 && x2 < width/4 + scale * w && y2 > 50 && y2 < 50 + scale * h)
  {
    stroke(250, 0, 0);
    ellipse(x2, y2, 5, 5);
    stroke(255);
    homePoint = false;
    pts[0] = x2;
    pts[1] = y2; 
  }
}

void draw()
{
  if(start)
  {
    stroke(30,60,255);
    fill(255);
    rect(10, height/4, 200, 30);
    rect(10, height/4 + 50, 200, 30);
    rect(10, height/4 + 100, 200, 30);
    rect(10, height/4 + 150, 200, 30);
    rect(10, height/4 - 50, 200, 30);
    rect(10, height/4 - 100, 200, 30);
    rect(10, height/4 + 200, 200, 30);
    rect(10, height/4 + 250, 200, 30);
    rect(10, height/4 + 300, 200, 30);
    fill(0);
    text("Window Height (cm): " + h, 30, height/4 + 20);
    text("Window Width (cm): " + w, 30, height/4 + 70);
    text("Robot Speed (cm/s): " + s, 30, height/4 + 120);
    text("Done", 30, height/4 + 170);
    text("Min Accelerometer Value: " + aMin, 30, height/4 -80);
    text("Max Accelerometer Value: " + aMax, 30, height/4 -30);
    text("Undo", 30, height/4 + 220);
    text("Select Homepoint", 30, height/4 + 270);
    text("Generate Code", 30, height/4 + 320);
  }
}

void createCode(int[] pt)
{
  println("calibrate(" + aMax + ", " + aMin + ");");
  int a = 0;
  int d = 0;
  a = angle(pt[0], pt[1] + 1, pt[0], pt[1], pt[2], pt[3]);
  d = drive(pt[0], pt[1], pt[2], pt[3]);
  int adjust = 0;
  if(a > 0)
  {
    println("angleRight(" + (a + adjust) + ");");
  }
  else
  {
    println("angleLeft(" + (-a + adjust) + ");");
  }
  println("drive(" + d + ");");
  for(int c = 2; c <= pt.length/2 - 5; c+=2)
  {
    a = angle(pt[c - 2], pt[c - 1], pt[c], pt[c + 1], pt[c + 2], pt[c + 3]);
    d = drive(pt[c], pt[c + 1], pt[c + 2], pt[c + 3]);
    if(pt[c + 2] != 0 && pt[c + 3] != 0)
    {
      if(a > 180)
      {
        println("angleLeft(" + (a - 180 + adjust) + ");");
      }
      else if(a > 0)
      {
        println("angleRight(" + (a + adjust) + ");");
      }
      else
      {
        println("angleLeft(" + (-a + adjust) + ");");
      }
      if(penCount % 2 == 0)
      {
        println("penLower();");
      }
      println("drive(" + d + ");");
      if(penCount % 2 == 0)
      {
        println("penRaise();");
        penCount += 1;
      }
      else
      {
        penCount += 1; 
      }
    }
    else
    {
      pt[c + 2] = pt[0];
      pt[c + 3] = pt[1];
      a = angle(pt[c - 2], pt[c - 1], pt[c], pt[c + 1], pt[c + 2], pt[c + 3]);
      d = drive(pt[c], pt[c + 1], pt[c + 2], pt[c + 3]);
      if(a > 0)
      {
        println("angleRight(" + (a + adjust) + ");");
        println("drive(" + d + ");");
        c = pt.length / 2 - 4;
      }
      else
      {
        println("angleLeft(" + (-a + adjust) + ");");
        println("drive(" + d + ");");
        c = pt.length / 2 - 4;
      }
    }
  } 
}

int angle(int p1, int p2, int p3, int p4, int p5, int p6)
{
  float m1 = atan2(p1 - p3, p2 - p4) * (180 / pi);
  float m11 = atan2(p3 - p1, p4 - p2) * (180 / pi);
  float m2 = atan2(p5 - p3, p6 - p4) * (180 / pi);
  float angle = 0;
  if(m2 - m1 < 0)
  {
    angle = 360 + m2 - m1;
  }
  else 
  {
    angle = m2 - m1;
  }
  if(abs(round(m2)) == 180)
  {
    if(p2 < p6)
    {
      if(p1 < p3)
      {
          return round(180 - angle);
      }
      else
      {
          return -round(angle - 180);
      }
    }
    else
    {
      if(p1 < p3)
      {
          return -round(angle - 180);
      }
      else
      {
          return round(180 - angle);
      }
    }
  }
  else if(p1 == p3)
  {
    if(m2 >= 0)
    {
      if(p5 < p3)
      {
        return -round(180 - angle); 
      }
      else
      {
        return round(180 - angle); 
      }
    }
    else
    {
      if(p5 < p3)
      {
        return round(180 - angle);
      }
      else
      {
        return -round(180 - angle);
      }
    }
  }
  else if(m2 > 0 && m11 < 0)
  {
    if(p3 - p1 > 0 && p3 - p5 < 0 || p3 - p1 < 0 && p3 - p5 > 0)
    {
      return -round(angle - 180);
    }
    else
    {
      return round(180 - angle);
    }
  }
  else if(m2 < 0 && m11 > 0)
  {
    if(p3 - p1 > 0 && p3 - p5 < 0 || p3 - p1 < 0 && p3 - p5 > 0)
    {
      return round(180 - angle);
    }
    else
    {
      return -round(angle - 180);
    }
  }
  else
  {
      if(angle > 180)
      {
        return -round(angle - 180);
      }
      else if(angle > 90)
      {
        return round(180 - angle);
      }
      else
      {
        return round(180 - angle);
      }
  }
}

int drive(int p1, int p2, int p3, int p4)
{
  float dist = sqrt(sq(p3 - p1) + sq(p4 - p2));
  int run = round(dist * 1000 / (scale * s));
  if(run !=0)
  {
    return run;
  }
  else
  {
    return 1;
  }
}
