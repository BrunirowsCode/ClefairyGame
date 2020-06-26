class Teacher
{
  int[] instructions = new int[12];
  PVector position;
  PVector dimention;
  Blackboard blackboard;
  BarLife time;
  String phrase;
  int instructionToShow = 0;

  Teacher()
  {
    position = new PVector(width * 0.5, height * 0.45);
    dimention = new PVector(200, 200);
    state = 0;
    phrase = "";
    for (int i = 0; i < instructions.length; ++i)
    {
      instructions[i] = int(random(0, 4));
    }
    blackboard = new Blackboard();
    time = new BarLife(new PVector(width * 0.25, height * 0.1), new PVector(width * 0.5, height * 0.05));
  }

  void render()
  {
    blackboard.render();
    if (INSTRUCTIONS == state)
    {
      for (int i = 0; i < instructionToShow; ++i)
      {
        image(
          arrows[instructions[i]], 
          blackboard.instructionsPositions[i].x, 
          blackboard.instructionsPositions[i].y, 
          30, 
          30
          );
      }
      if (frameCount % 50 == 0)
      {
        if (instructionToShow < (round * 2 + 4))
        {
          instructionToShow++;
        } else
        {
          instructionToShow = 0;
          state = PRESS_BUTTON;
        }
      }
    } else if (PRESS_BUTTON == state)
    {
      time.render();
    }
    pushMatrix();
    fill(0);
    rectMode(CENTER);
    translate(position.x, position.y);
    image(brunirows[I_TEACHER], 0, 0, dimention.x, dimention.y);
    popMatrix();
  }

  void showMessage(String message)
  {
    fill(255);
    text(message, width * 0.5, height * 0.22);
  }

  void update()
  {
    if (PRESS_BUTTON == state)
    {
      if (time.value > 0)
      {
        time.value-=0.004;
        if (time.value < 0)
        {
          time.value = 1;
          state = STOP;
        }
      }
    }
  }
}
