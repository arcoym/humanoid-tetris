/* TO DOS: 
 1. Geomerative - make them RShapes, run hit test that looks if shapes intersect
 2. Record people as shaped - find anoter girl to be a shape. Make them little GIFS that are bored, waiting...
 3. Make shapes move consistently - velocity and then stop on a specific key pressed.
 4. Think about how I could have each caller be assigned a color and that color is then randomly given to shapes.
     (how would I make that shape only controllable by that caller then? Ask Chris / Rune next week)
 5.
 */

//setting up TinyPhone
import com.itpredial.tinyphone.client.*;
String host = "166.78.159.225";
int port = 12002;
String phoneNumber = "1(206)-279-6024";
TinyphoneClient tp;
ArrayList<Caller> callers = new ArrayList<Caller>();

//temp shapes for game -- LATER CHANGE TO IMAGES / VIDEOS OF PEOPLE
PImage shapeT;
PImage shapeP;
PImage shapeBP;
PImage shapeSQ;
PImage shapeI;
PImage BGImage;

PImage[] shapes = new PImage[5];

ArrayList<Block> blocks = new ArrayList<Block>();

void setup() 
{
  size(1400, 720);
  BGImage = loadImage("BGImage.png");
  tp = new TinyphoneClient(this, host, port, phoneNumber);
  tp.start();
  imageMode(CENTER);
  shapes[0] = loadImage("shape_T.png");
  shapes[1] = loadImage("shape_P.png");
  shapes[2] = loadImage("shape_BP.png");
  shapes[3] = loadImage("shape_SQ.png");
  shapes[4] = loadImage("shape_I.png");

  loadNext();
}

void draw()
{ 
  background(BGImage);
  synchronized(callers) {
    for (int i = 0; i < callers.size(); i++) {
      Caller caller = callers.get(i);
    }
  }

  for (int i = 0; i < blocks.size() - 1; i++)
  {
    blocks.get(i).display();
  }

  Block curBlock = lastBlock();
  curBlock.move();
  curBlock.display();

  // DEBUGGGING FREAKIN STOPPING AT BOTTOM OF SCREEN - ARRRRGGGGH!!
  //println(curBlock.ypos);


  if (curBlock.ypos == height-50) 
  {
    loadNext();
  }

  if (keyPressed) {
    if (key == 'n') { 
      lastBlock().rotVal -=90; //rotate left
    }
    if (key == 'm') {
      lastBlock().rotVal +=90; //rotate right
    }
    if (key == ',') {

      lastBlock().xpos -=2; //move left
    }
    if (key == '.') {
      lastBlock().xpos +=2; //move right
    }
  }
}

Block lastBlock()
{
  return blocks.get(blocks.size() - 1);
}

void loadNext()
{
  int ranIndex = (int) random(shapes.length);
  Block newBlock = new Block(shapes[ranIndex]);
  blocks.add(newBlock);
}



//////// TINYPHONE //////////

public void newCallerEvent(TinyphoneEvent event) {
  Caller caller = new Caller(event.getId(), event.getCallerNumber(), event.getCallerLabel());
  synchronized(callers) {
    callers.add(caller);
  }
}

public void keypressEvent(TinyphoneEvent event) {
  synchronized(callers) {
    Caller caller = getCaller(event.getId());
    if (caller != null) {
      caller.newKeypress(event.getValue());
    }
  }
}

Caller getCaller(String id) {
  for (int i = 0; i < callers.size(); i++) {
    Caller caller = callers.get(i);
    if (caller.isCaller(id)) {
      return caller;
    }
  }
  return null;
}

public void hangupEvent(TinyphoneEvent event) {
  synchronized(callers) {
    for (int i = 0; i < callers.size(); i++) {
      Caller caller = callers.get(i);
      if (caller.isCaller(event.getId())) {
        callers.remove(i);
        break;
      }
    }
  }
}

