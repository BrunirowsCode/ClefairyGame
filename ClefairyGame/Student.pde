class Student
{
  PVector position;
  PVector dimention;
  BarLife life;
  float xoff;
  int actualInput;
  int id;
  int[] inputs = new int[12];
  boolean winner;
  int actualMove;
  int counterStudent;
  int errors;

  Student(int i)
  {
    id = i;
    position = new PVector(width * (0 == id ? 0.25 : 0.75), height * 0.66);
    dimention = new PVector(100, 100);
    life = new BarLife(new PVector(-dimention.x * 0.5, dimention.y * 0.8), new PVector(dimention.x, dimention.y * 0.1));
    xoff = dimention.x / 6;
    actualInput = 0;
    actualMove = 0;
    counterStudent = 0;
    errors = 0;
    winner = true;
    resetInputs();
  }

  void resetInputs()
  {
    for (int i = 0; i < 12; ++i)
    {
      inputs[i] = 4;
    }
    errors = 0;
  }

  void render()
  {
    rectMode(CENTER);
    pushMatrix();
    fill(0);
    translate(position.x, position.y);
    text("P"+(id+1), 0, dimention.y * 1.4);
    if (state < 3)
    {
      image(brunirows[I_BACK], 0, 0, dimention.x * 2.2, dimention.y * 2.2);
    } else if (state < 6)
    {
      image(brunirows[I_FRONT], 0, 0, dimention.x * 2.2, dimention.y * 2.2);
    } else if (state == 6)
    {
      image(brunirows[inputs[actualMove]], 0, 0, dimention.x * 2.2, dimention.y * 2.2);
      PVector offset = new PVector(-dimention.x * 0.5, -dimention.y * 0.9);
      for (int i = 0; i < errors; ++i)
      {
        int row = i / 6;
        int col = i % 6;
        PVector pos = PVector.add(offset, new PVector(col * xoff + xoff * 0.5, row * 15));
        fill(255, 0, 0);
        ellipse(pos.x, pos.y, 10, 10);
      }
      ++counterStudent;
      if (counterStudent % 60 == 0)
      {
        actualMove++;
        if (inputs[actualMove] != teacher.instructions[actualMove])
        {
          ++errors;
          getDamage();
        }
      }
    } else if (state == 7)
    {
      if (winner)
        image(brunirows[I_FRONT], 0, 0, dimention.x * 2.2, dimention.y * 2.2);
      else 
      image(brunirows[I_BACK], 0, 0, dimention.x * 2.2, dimention.y * 2.2);
    }
    life.render();
    if (PRESS_BUTTON == state)
    {
      PVector offset = new PVector(-dimention.x * 0.5, -dimention.y * 0.9);
      for (int i = 0; i < 4 + round * 2; ++i)
      {
        int row = i / 6;
        int col = i % 6;
        PVector pos = PVector.add(offset, new PVector(col * xoff + xoff * 0.5, row * 15));
        fill(50);
        ellipse(pos.x, pos.y, 10, 10);
      }
      for (int i = 0; i < actualInput; ++i)
      {
        int row = i / 6;
        int col = i % 6;
        PVector pos = PVector.add(offset, new PVector(col * xoff + xoff * 0.5, row * 15));
        fill(255, 255, 100);
        ellipse(pos.x, pos.y, 7, 7);
      }
    }
    popMatrix();
  }

  void getDamage()
  {
    life.value -=0.2;
    if (life.value < 0.2)
    {
      life.value = 0;
      state = END_GAME;
      winner = false;
      messages[7] = "P"+ (id==0 ? "2" : "1") + " WINS!";
    }
  }

  void keyPressed()
  {
    if (actualInput == 4 + round * 2)return;
    if (1 == id)
    {
      if (UP == keyCode) {
        inputs[actualInput] = I_UP;
        ++actualInput;
      }
      if (RIGHT == keyCode) {
        inputs[actualInput] = I_RIGHT;
        ++actualInput;
      }
      if (DOWN == keyCode) {
        inputs[actualInput] = I_DOWN;
        ++actualInput;
      }
      if (LEFT == keyCode) {
        inputs[actualInput] = I_LEFT;
        ++actualInput;
      }
    } else if (0 == id)
    {
      if ('w' == key) {
        inputs[actualInput] = I_UP;
        ++actualInput;
      }
      if ('d' == key) {
        inputs[actualInput] = I_RIGHT;
        ++actualInput;
      }
      if ('s' == key) {
        inputs[actualInput] = I_DOWN;
        ++actualInput;
      }
      if ('a' == key) {
        inputs[actualInput] = I_LEFT;
        ++actualInput;
      }
    }
  }
}
