/***********************************************
/*            Simplified Avalon
/*Move mouse to attract the graph
/*Click mouse to shrink the graph
/*Release mouse to let the graph grow back
************************************************/
//Constants
int GRAPH_SHRINK= 1;
int GRAPH_GROWTH= 2;
int GraphMode= 0;
int Global_Itr= 0;
int Global_ItrSum= 19;
int ColorDefault= 190;
float Global_LineWeight= 8;
float Global_LineWeightDefault= 8;
float EyeWidthFactor= 0.85;
float EyeWidthFactorDefault= 0.85;
int SIZE_X= 1280;
int SIZE_Y= 1280;
float amount= 0.011;
String BackgroundFileName= "screen-0001.png";
PImage BackgroundImage;
//Emulate C struct
class UnitGraph { 
    float PosX= 0;
    float PosY= 0;
    float W= 0;
    float H= 0;
    int LineThick= 0;
    int RadiusFactor= 1;
    float HW_Ratio= 1.2;
    float LeftEyeFactor= 0.2;
    float RightEyeFactor= 0.8;
    float MouseFactor= 0.8;
    UnitGraph LeftEye;
    UnitGraph RightEye;
    UnitGraph Mouse;
    UnitGraph Parent;
}

UnitGraph ROOT= new UnitGraph();

//Mode 0= spiral, 1= concnteral
void drawUnitGraph(float PosX, float PosY, float W, float H, int Mode, float mX, float mY)
{
  float HWRatio= 1;
  if((Mode == GRAPH_SHRINK) && (EyeWidthFactor > amount)) EyeWidthFactor-= amount;
  if((Mode == GRAPH_GROWTH) && (EyeWidthFactor < EyeWidthFactorDefault)) EyeWidthFactor+= amount;
  /*
  if(Mode == 0){
    switch((Global_Itr++) % 4){
      case 0:
        PosX-= W * (1 - EyeWidthFactor) / 2.0 + mX;
        break;
      case 1:
        PosY-= W * HWRatio * (1 - EyeWidthFactor) / 2.0 + mY;
        break;
      case 2:
        PosX+= W * (1 - EyeWidthFactor) / 2.0 + mX;
        break;
      case 3:
        PosY+= W * HWRatio * (1 - EyeWidthFactor) / 2.0 + mY;
        break;
    }
  }*/
    fill(random(ColorDefault, 255), 
         random(ColorDefault, 255), 
         random(ColorDefault, 255),
         random(0, 90));
  strokeWeight(Global_LineWeight);
  ellipse(PosX, PosY, W, W * HWRatio);
  if(((Global_Itr) >= Global_ItrSum) || ((Global_LineWeight-= 0.5) < amount)){
    PFont font = createFont("Helvetica.dfont", 15);
    textFont(font);
    fill(255, 255, 255, 255);
    text("Avalon", PosX - 25, PosY + 5);
    return;
  }
  //Left eye
  drawUnitGraph(PosX + mX,// - W * LeftEyeXFactor,
            PosY + mY,
            W * EyeWidthFactor,
            W * EyeWidthFactor * HWRatio,
            Mode, mX, mY);
}

/*
void drawLine(int x1, int y1, int x2, int y2)
{
  //this is the line function
  //line(x1, y1, x2, y2)
  //line(x1, y1, x2, y2);
  ellipse(x1, y1, x2, y2);
}
*/

//Not sure how to check file's existence in Java
void drawBackground()
{
  int count= 2500;
  int idx= 0;
  background(40, 40, 50);
  try{
    BackgroundImage= loadImage(BackgroundFileName);
    if(BackgroundImage.width != SIZE_X){
    }
  }
  catch(NullPointerException error){
    for(idx= 0; idx < count; idx++){
      draw();
    }
    saveFrame(BackgroundFileName);
    BackgroundImage= loadImage(BackgroundFileName);
  }
    BackgroundImage= loadImage(BackgroundFileName);
    image(BackgroundImage, 0, 0);
  if(BackgroundImage.width != SIZE_X){
  }
}

void setup()
{
  size(1280,1280);
  ROOT.W= SIZE_X / 2.0;
  ROOT.H= ROOT.W * ROOT.HW_Ratio; 
  ROOT.PosX= SIZE_X / 2.0;
  ROOT.PosY= SIZE_Y / 2.0 - ROOT.H / 5.0;
  //noLoop();
}


void draw()
{
  float x= 0, y= 0;
  x= (mouseX - SIZE_X / 2.0) / 10;
  y= (mouseY - SIZE_Y / 2.0) / 10 + 15;
  Global_Itr= 0;
  Global_LineWeight= Global_LineWeightDefault;
  drawBackground();
  drawUnitGraph(ROOT.PosX, ROOT.PosY, ROOT.H, ROOT.W, GraphMode, x, y);
}


void mousePressed()
{
  GraphMode= GRAPH_SHRINK;
  loop();
}


void mouseReleased()
{
  GraphMode= GRAPH_GROWTH;
}