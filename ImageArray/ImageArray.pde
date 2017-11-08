/*********************************************************
*
*           ImageArray v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
 SceneManager SceneMgr;
 Plot APlot;
 int ScreenSizeX;
 int ScreenSizeY;
 int StartPositionX;
 int StartPositionY;
 int LayerSum= 6;
 float SkyRatioLand= 0.3;
 int press= 0;
 int release= 1;

int Sum= 54;

String MMPrefix= "ImgMM/";

GoghUnit GU[]= new GoghUnit[Sum];

//Movie Movies[]= new Movie[Sum];

PImage MMImages[]= new PImage[Sum];

String MovieList[]= {
    "1.mov",
    "2.mov",
    "3.mov"
  };

Object _this= this;

class GoghUnit{
  //Movie Mov;
  public int PosX= 0; 
  public int PosY= 0;
  int SizeX;
  int SizeY;
  int ImageIndex= 0;
  PImage Gogh;
  int Div= 1;
  public boolean firsttime= true;
  public 
  
  
  boolean ReduceLog= true;
  int PosIndex;
  int DX, DY;
  public int StepCount= 0;
  public int ReduceCount= 0;
  void drawFrame(int ImageIndex, int PosIndex)
  {
    this.ImageIndex= ImageIndex;
    this.PosIndex= PosIndex;
            PosX= (ScreenWidth / Div) * (PosIndex % Div) + Sp;
            PosY= (ScreenHeight / Div) * (PosIndex / Div) + Sp;
           image(
             MMImages[ImageIndex], 
             (ScreenWidth / Div) * (PosIndex % Div) + Sp, 
             (ScreenHeight / Div) * (PosIndex / Div) + Sp, 
             ScreenWidth / Div - 2 * Sp,
             ScreenHeight / Div - 2 * Sp);
  }
  
  void drawFrameQ(int ImageIndex, int PosIndex)
  {
    this.ImageIndex= ImageIndex;
    this.PosIndex= PosIndex;
           image(
             MMImages[ImageIndex], 
             (ScreenWidth / Div) * (PosIndex % Div) + Sp, 
             (ScreenHeight / Div) * (PosIndex / Div) + Sp, 
             ScreenWidth / Div - 2 * Sp,
             ScreenHeight / Div - 2 * Sp);
  }
  
  void goCenter(int Steps)
  {
    if(firsttime== true){
      PosX= (ScreenWidth / Div) * (PosIndex % Div);
      PosY= (ScreenHeight / Div) * (PosIndex / Div);
           DX= (PosX - CenterX + MMImages[ImageIndex].width / this.Div / 2 ) / Steps;//int(a * cos(atan((PosY - CenterY) / (PosX - CenterX))));
           DY= (PosY - CenterY + MMImages[ImageIndex].height / this.Div / 2) / Steps;//int(a * sin(atan((PosY - CenterY) / (PosX - CenterX))));

      firsttime= false;
    }
    if(StepCount < Steps){
             PosX-= DX; 
             PosY-= DY; 
             StepCount++;
             println(StepCount);
    }else{
    }
    //image(MMImages[ImageIndex], PosX, PosY, ScreenWidth / Div - 2 * Sp, ScreenHeight / Div - 2 * Sp);
  }  
  
  void reduce(int Steps)
  {
    if(ReduceLog == true){
      ReduceCount= Steps;
      ReduceLog= false;
    }
    if(ReduceCount > 0){
      long oa= 0, r=0, g= 0, b= 0;
      long ColorCount= 0;
      int l;
      int wp= (MMImages[ImageIndex].width / ReduceCount),
          hp= (MMImages[ImageIndex].height / ReduceCount);
     for(int ia= 0, w= 0; ia < ReduceCount; ia++, w+= wp){
      for(int idx= 0, h= 0; idx < ReduceCount; idx++, h+= hp){
        for(int i= 0; i < hp; i++){
          for(int a= 0; a < wp; a++){
           l= MMImages[ImageIndex].get(w + a, h + i);
           r+= ((0xff0000 & l) >> 16);
           g+= ((0x00ff00 & l) >> 8);
           b+= ((0x0000ff & l));
           oa++;
          }           
        }  
        for(int i= 0; i < hp; i++){
          for(int a= 0; a < wp; a++){
              MMImages[ImageIndex].set(w + a, h + i, color(r / oa, g / oa, b / oa));
              //println(r / oa , g / oa, b / oa);
          }           
        }
        ColorCount= 0;
        oa= 0;
        r= g= b= 0;
      }
    }
  }
  }
}

  
  
  
  
  
  float Ratio= 2700 / 3200;
  int ScreenHeight= 480;
  int ScreenWidth= 360;
  int InitDiv= 2;
  int i;
  int Sp= 1;
  int SpMax= 4;
  int CenterX= ScreenWidth / 2;
  int CenterY= ScreenHeight / 2;
  
     void setup()
     {
       //fullScreen();
       //ScreenHeight/= InitDiv; 
       //ScreenWidth/= InitDiv;
       
       size(360, 480);
       
       ScreenSizeX= 1080;
       ScreenSizeY= 813; 
       StartPositionX= ScreenSizeX / 2;
       StartPositionY= ScreenSizeY / 2;
       println(width);
       background(0);
       SceneMgr= new SceneManager(ScreenSizeX, ScreenSizeY, LayerSum);
       APlot= new Plot();
       
       loadMMImages();
       genGoghUnit();
       //SceneMgr.StartAnimation();
       //SceneMgr.update();
     }
     
     void draw()
     {
       SceneMgr.update();
       return;
     }
     
     void mouseClicked(){
     //SceneMgr.update();
       return;
     }
     
     void mouseReleased()
     {
     //SceneMgr.update();
     }
     
     void mouseMoved()
     {
       //SceneMgr.update();
     }










int FrameIndex= 0;

void genFrame()
{
  String N= "";
  if(FrameIndex < 10) N= "00"; else if(FrameIndex > 10 && FrameIndex < 100)  N= "0";
   saveFrame("frame/" + N + str(FrameIndex) + ".png");
   FrameIndex++;
}


int ThumbIndex= 0;
void genThumb()
{
  String N= "";
  if(ThumbIndex < Sum){
    if(ThumbIndex <= 10) N= "0"; else N= "";
             image(
               MMImages[ThumbIndex], 
               0, 
               0, 
               ScreenWidth,
               ScreenHeight);
           saveFrame(MMPrefix + N + str(ThumbIndex) + ".png");
  }
           ThumbIndex++;
}

void initGogh(int VideoIndex)
{
    
}

//void movieEvent(Movie M)
//{
//  M.read();
//}


void loadMovie()
{
    for(int i= 0; i < MovieList.length ; i++){
       //Movies[i]= new Movie(this, MovieList[i % this.MovieList.length]);
    }
}

void loadMMImages()
{
  String N= "";
  for(int i= 0; i < Sum; i++){
    if(i < 10) N= "000"; else N= "00";
    MMImages[i]= loadImage(MMPrefix + "" + N + str(i) + ".png");
    MMImages[i].loadPixels();
  }
}

void genGoghUnit()
{
  String N= "";
  for(int idx= 0; idx < Sum; idx++){
    GU[idx]= new GoghUnit();
    if(idx < 10) N= "000"; else N= "00";
    GU[idx].Gogh= new PImage();
    GU[idx].Gogh= loadImage(MMPrefix + "" + N + str(idx) + ".png");
    println(MMPrefix + "" + N + str(idx) + ".png");
  }
}

int FrameSum= 128;
String OutPrefix= "/out/";


void genLattics()
{
 String N= "";
  for(int idx= 0; idx < FrameSum; idx++){
    GU[idx]= new GoghUnit();
    if(idx < 10) N= "00"; else if(idx > 10 && idx < 100)  N= "0";
    
    GU[idx].Gogh= loadImage(OutPrefix + "" + N + str(idx) + ".png");
    println(OutPrefix + "" + N + str(idx) + ".png");
    delay(100);
  }
    
  for(int i= 0; i < 20; i++){
         int w= 30, h= 30;
          for(int idx= 0; idx < Sum ; idx++){
            GU[idx].Div= 2;
            GU[idx].drawFrame(idx % Sum, idx);
          }   
     delay(100);
  }   
}