class BarLife
{
  PVector position;
  PVector dimention;
  color bg;
  color fg;
  float value;
  
  BarLife(PVector p, PVector d)
  {
    position = p;
    dimention = d;
    bg = color(0,0,150);
    fg = color(255,255,100);
    value = 1;
  }
  
  void render()
  {
    rectMode(CORNER);
    pushMatrix();
    fill(bg);
    translate(position.x, position.y);
    rect(0,0,dimention.x,dimention.y);
    fill(fg);
    rect(0,0,dimention.x * value, dimention.y);
    popMatrix();
  }
}
