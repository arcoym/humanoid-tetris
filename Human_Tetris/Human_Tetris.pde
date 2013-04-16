/* TO DOS: 
1. Make shapes as a class
2. Make them be added to an array list when they reach the bottom 
(this way I can say only the last item in the array last should be changed)
3. Make the shapes stop at the bottom
4. Make certain keys trigger the rotation of the shapes thats falling
*/

PImage shapeT;
PImage shapeP;
PImage shapeBP;
PImage shapeSQ;
PImage shapeI;

int currentIndex;
PImage[] shapes = new PImage[5]; 

float xpos = 0;
float ypos = -10;
float yspeed = 1;
float yspeed2 = 1;

void setup() 
{
  size(300, 300);
  shapes[0] = loadImage("shape_T.png");
  shapes[1] = loadImage("shape_P.png");
  shapes[2] = loadImage("shape_BP.png");
  shapes[3] = loadImage("shape_SQ.png");
  shapes[4] = loadImage("shape_I.png");
  
  loadNext();
}

void draw()
{  
  background(255);
  image(shapes[currentIndex], xpos, ypos);
  ypos = ypos + yspeed;



  if(ypos == height-30) 
  {
    loadNext();
  }
}

void loadNext() {
  xpos = random(0, width-30);
  ypos = 0;
  currentIndex = (int) random(shapes.length);
}

