Teacher teacher;
Student[] students = new Student[2];
Background background;
int state = 0;
int round = 0;
int counter = 0;
PImage[] arrows = new PImage[4];
PImage[] brunirows = new PImage[7];

void setup()
{
  arrows[0] = loadImage("upArrow.png");
  arrows[1] = loadImage("rightArrow.png");
  arrows[2] = loadImage("downArrow.png");
  arrows[3] = loadImage("leftArrow.png");

  brunirows[0] = loadImage("Up.png");
  brunirows[1] = loadImage("Right.png");
  brunirows[2] = loadImage("Down.png");
  brunirows[3] = loadImage("Left.png");
  brunirows[4] = loadImage("Front.png");
  brunirows[5] = loadImage("Back.png");
  brunirows[6] = loadImage("Teacher.png");

  size(1000, 600);
  noStroke();
  teacher = new Teacher();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(60);
  for (int i = 0; i < students.length; ++i)
  {
    students[i] = new Student(i);
  }
  background = new Background();
  students[0].winner = true;
}

void draw()
{
  update();
  background.render();
  teacher.update();
  teacher.render();
  teacher.showMessage(messages[state]);
  for (Student s : students)
  {
    s.render();
  }
}

void update()
{
  switch(state)
  {
  case LISTEN_UP:
    counter++;
    if (counter > 60)
    {
      counter = 0;
      state = REMEMBER_THIS;
      students[0].resetInputs();
      students[1].resetInputs();
    }
    break;
  case REMEMBER_THIS:
    counter++;
    if (counter > 60)
    {
      counter = 0;
      state = INSTRUCTIONS;
    }
    break;
  case INSTRUCTIONS:

    break;
  case PRESS_BUTTON:

    break;
  case STOP:
    counter++;
    if (counter > 60)
    {
      counter = 0;
      state = READY_SET;
    }
    break;
  case READY_SET:
    counter++;
    if (counter > 60)
    {
      counter = 0;
      state = NOTHING;
      for (Student s : students)
      {
        if (s.inputs[0] != teacher.instructions[0])
        {
          ++s.errors;
          s.getDamage();
        }
      }
    }
    break;
  case NOTHING:
    counter++;
    if (counter > ((4 + round * 2) * 60)-10)
    {
      if (round < 4)
      {
        ++round;
        for (Student s : students)
        {
          s.actualInput = 0;
          s.actualMove = 0;
          s.counterStudent = 0;
        }
        state = LISTEN_UP;
      } else
      {
        if (students[0].life.value > students[1].life.value)
        {
          students[1].winner = false;
          messages[7] = "P2 WINS!";
        }else if(students[1].life.value > students[0].life.value)
        {
          students[0].winner = false;
          messages[7] = "P1 WINS!";
        }else
        {
          messages[7] = "TIE!";
        }
        state = END_GAME;
      }
    }
    break;
  }
}

void keyPressed()
{
  if (PRESS_BUTTON == state)
  {
    students[0].keyPressed();
    students[1].keyPressed();
  }
}
