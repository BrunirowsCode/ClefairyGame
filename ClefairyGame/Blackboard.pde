class Blackboard
{
  PVector position;
  PVector dimention;
  int columns = 6;
  float xoff;
  float yoff;
  PVector[] instructionsPositions = new PVector[12];

  Blackboard()
  {
    position = new PVector(width * 0.5, height * 0.22);
    dimention = new PVector(width * 0.75, height * 0.37);
    xoff = dimention.x / columns;
    yoff = dimention.y / 2;
    PVector upperLeft = PVector.sub(position, PVector.mult(dimention, 0.5));
    for (int i = 0; i < instructionsPositions.length; ++i)
    {
      float x = (i % columns) * xoff + upperLeft.x + xoff * 0.5;
      float y = (i / columns) * yoff + upperLeft.y + yoff * 0.5;
      instructionsPositions[i] = new PVector(x, y);
    }
  }

  void render()
  {
    rectMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    fill(99, 69, 8);
    rect(0, 0, dimention.x, dimention.y);
    fill(50, 110, 49);
    rect(0, 0, dimention.x * 0.95, dimention.y *0.9);
    popMatrix();
    for (int i = 0; i < instructionsPositions.length; ++i)
    {
      PVector p = instructionsPositions[i];
      fill(255);
      //ellipse(p.x, p.y, 20, 20);
    }
  }
}
