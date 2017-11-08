


/*********************************************************
*
*               Avalon Scene Manager v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/

class Cursor{
  int IconSum= 0;
  private float PosX= 0, PosY= 0;
  private PImage CursorIcon[];
  boolean BOOL_ShowCursor= false;
  
  public void hideCursor()
  {
    noCursor();
  }
  
  public void showCursor()
  {
    cursor();
  }
  
  public void setCursor(int IconIndex, int PosX, int PosY)
  {
    if(IconIndex >= IconSum)return;
    cursor(CursorIcon[IconIndex], PosX, PosY);
    this.PosX= PosX;
    this.PosY= PosY;
    return;
  }
  
  public Cursor(String FileList[])
  {
    this.IconSum= FileList.length;
    for(int idx= 0; idx < this.IconSum && idx < IconSum; idx++){
      CursorIcon[idx]= loadImage(FileList[idx]);
    }
  }
}

class Layer{
  private int LayerSum= 32;
  private PImage Layers[]= new PImage[32];
  public int newLayer()
  {
    return ErrorTypes.NO_ERROR;
  }
  
  public PImage getLayerByIndex(int LayerIndex)
  {
    return Layers[LayerIndex % LayerSum];
  }
  
  public int getLayerSum()
  {
    return LayerSum;
  }

  
  public Layer(int SizeX, int SizeY, int LayerSum){
    this.LayerSum= (LayerSum > this.LayerSum)? this.LayerSum : LayerSum;
    for(int idx= 0; idx < this.LayerSum; idx++){
      Layers[idx]= createImage(SizeX, SizeY, ARGB);
    }
  }
}


class Painter{
  private int SceneSizeX;
  private int SceneSizeY;
  private int LayerSum= 6;
  private int TextureSum= 6;
  private int TextureIndex= 0;
  private String FolderName= "";
  private String PaintTextureList[];
 
  private PImage Textures[]= new PImage[TextureSum];
  
  private Layer Layers;
  
  
  public String setTextureFolder(String FolderName)
  {
    return this.FolderName= FolderName;
  }
  
  public void addTexture(String FileName)
  {
    println(FolderName + FileName);
    Textures[TextureIndex++]= loadImage(FolderName + FileName);
  }
  
  
  public int paintTextureIntoLayer(int TextureIndex, int LayerIndex, int PosX, int PosY)
  {
    PImage L, T;
    if(TextureIndex < 0 
    || LayerIndex < 0 
    || TextureIndex >= TextureSum 
    || LayerIndex > Layers.getLayerSum()){
      return ErrorTypes.INDEX_OUT_OF_RANGE;
    }
    L= Layers.getLayerByIndex(LayerIndex);
    T= Textures[TextureIndex];
    L.blend(T, 0, 0, T.width, T.height, PosX, PosY, T.width, T.height, BLEND);
    return ErrorTypes.NO_ERROR;
  }
  
  
  public int paintLayerToScreen(int LayerIndex)
  {
    if(TextureIndex < 0 || LayerIndex < 0){
      return ErrorTypes.INDEX_OUT_OF_RANGE;
    }
    image(Layers.getLayerByIndex(LayerIndex), 0, 0);
   return ErrorTypes.NO_ERROR;
  }
  
  
  public void paint(int PaintMode, int StartX, int StartY, int EndX, int EndY)
  {
    int Limit = 3;
    StartX-= Textures[PaintMode % Limit].width / 2;
    StartY-=  Textures[PaintMode % Limit].height;
    switch(PaintMode){
      case 0:
        paintTextureIntoLayer(PaintMode, 0, StartX, StartY);
        break;
      case 1:
        paintTextureIntoLayer(PaintMode, 0, StartX, StartY);
        break;
      case 2:
        paintTextureIntoLayer(PaintMode, 0, StartX, StartY);
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
       default:
        break;
    }
  }
  
  public Painter(int SceneSizeX, int SceneSizeY, int LayerSum)
  {
     Layers= new Layer(SceneSizeX, SceneSizeY, LayerSum);
  }
}
//Simplified GUI generator, no redundent funtions please!
class SceneManager {
     private  Painter Pt;
     private int LayerSum= 6; 
     private float SkyRatioLand;
     private int SizeX, SizeY;
     
      private String GUI_FILEPREFIX= DATA_PATH + "/GUI/HexButtonIcon/";
      private boolean BOOL_ShowGui= false;
      private boolean BOOL_LockGui= false;
      
      private int HexButtonSum= 6;
      private int SelectedUID= 0;
      private int SaveCursorPosX= 0;
      private int SaveCursorPosY= 0;
      
      private float ButtonDegree= TWO_PI / HexButtonSum;
      private float HexCenterX= 0.0;
      private float HexCenterY= 0.0;

      private float HexButtonDistance= 0;
      private float HexButtonDistanceToCenter= 128;
      private float HexButtonMoveSpeed= 10;
      
      private boolean BOOL_ShowHexButtons= false;
      private boolean BOOL_AnimateSwitch= false;
      private boolean BOOL_Expanded= false;
      private boolean BOOL_RightMouseSwitch= false;
      private boolean BOOL_StartSwitch= false;
      
      public int AbstractArtworksSum= 2;
      public String AbstractArtworkName[]= {"1.jpg", "2.jpg"};
      public PImage AbstractArtworks[]= new PImage[2];
      public boolean BOOL_AbstractButtons= false;

      
      private int PaintMode= 0;
      
      private int PreMouseClickX, PreMouseClickY, MouseClickX, MouseClickY;
      
      private int AbstractButtonArtID= -1;
      private int PreAbstractButtonArtID= -1;
      private boolean BOOL_FirstTime= true;
      private int setAbstractTarget= -1;
      
      public int AlphaAmount= 90;
      
      public AnimationSequencer AnimationSequence= new AnimationSequencer();
      
      private String DefaultButtonTexture[]= {
        "play&pause.png",
        "replay.png",
        "stop.png",
        "forbiden.png",
        "forbiden.png",
        "forbiden.png"
      };
      private String ButtonName[]= {
        "SpiralMaker",
        "BackgroundColor",
        "CircleMaker",
        "NA",
        "NA",
        "NA"
      };
      private String ButtonHelp[]= {
        "An animated spiral",
        "An animated spiral",
        "An animated spiral",
        "An animated spiral",
        "An animated spiral",
        "An animated spiral"
      };
      
      private String StartButtonTexture= "startbutton.png";
      
      private float ButtonPos[][]={
                    {-1000, -1000},
                    {-1000, -1000},
                    {-1000,-1000},
                    {-1000, -1000},
                    {-1000, -1000},
                    {-1000, -1000}
      };
      
      
      private Button HexButtons[]= new Button[HexButtonSum];
      
      private void flushBackground()
      {
        background(10);
        //background(255);
      }
  
      public int makeButton()
      {
        int idx= 0;
        for(idx= 0; idx < HexButtonSum; idx++){
          this.HexButtons[idx]= new Button(
                                idx,
                                this.ButtonName[idx], 
                                this.GUI_FILEPREFIX + DefaultButtonTexture[idx], 
                                ButtonHelp[idx], 
                                ButtonPos[idx][0], 
                                ButtonPos[idx][1]);
          this.HexButtons[idx].setActiveAction(new EventHandler(){
            @Override
            public void callback(int UID)
            {
              setSelectedHexButton(UID);
              PreMouseClickX= MouseClickX;
              PreMouseClickY= MouseClickY;
              MouseClickX= mouseX;
              MouseClickY= mouseY;
              PaintMode= UID;
              //Pt.paintTextureIntoLayer(0, 0, MouseClickX, MouseClickY);
              //background(UID);
              return;
            }
          });
          /*ERROR CHECK NEEDED*/
        }
        return ErrorTypes.NO_ERROR;
      }
      
      public boolean lockGui(boolean lock)
      {
        return this.BOOL_LockGui= lock;
      }
      public boolean isGuiLocked()
      {
        return this.BOOL_LockGui;
      }
      
      public boolean showGui()
      {
        return this.BOOL_ShowGui= true;
      }
      
      public boolean hideGui()
      {
        return this.BOOL_ShowGui= false;
      } 
      
      public boolean showHexButtons()
      {
        for(int idx= 0; idx < HexButtonSum; idx++){
          this.HexButtons[idx].show();
        }
        return this.BOOL_ShowHexButtons= true;
      }
      
      public boolean hideHexButtons()
      {
        for(int idx= 0; idx < HexButtonSum; idx++){
          this.HexButtons[idx].hide();
        }
        return this.BOOL_ShowHexButtons= false;
      }      
      
      public boolean isGuiShowed()
      {
        return this.BOOL_ShowGui;
      }
      
      public void drawBackground()
      {
        background(255);
      }
      
      public void setSelectedHexButton(int UID)
      {
        SelectedUID= UID;
      }
      
      public float[] updateHexButtonLocation(boolean IsMoveable)
      {
        float SINV= sin(ButtonDegree / 2) * HexButtonDistance, COSV= cos(ButtonDegree / 2) * HexButtonDistance;
        float Positions[]= {
          HexCenterX, HexCenterY - HexButtonDistance,
          HexCenterX + COSV, HexCenterY - SINV,
          HexCenterX + COSV, HexCenterY + SINV,
          HexCenterX, HexCenterY + HexButtonDistance,
          HexCenterX - COSV, HexCenterY + SINV,
          HexCenterX - COSV, HexCenterY - SINV
        };
        if(IsMoveable){
          this.HexCenterX= mouseX - HexButtons[0].getSizeX() / 2.0;
          this.HexCenterY= mouseY - HexButtons[0].getSizeY() / 2.0;
        }
        for(int idx= 0; idx < HexButtonSum; idx++){
          HexButtons[idx].setPosX(ButtonPos[idx][0]);
          HexButtons[idx].setPosY(ButtonPos[idx][1]);
        }
        return Positions;
      }
      
      public void switchHexButton(boolean visiable)
      {
        float Positions[]= updateHexButtonLocation(false);
        
        if(visiable){
          showHexButtons();
        }else{
          hideHexButtons();
        }
        
        if(BOOL_AnimateSwitch == false){
          for(int idx= 0; idx < HexButtonSum; idx++){
            ButtonPos[idx][0]= (this.HexCenterX);
            ButtonPos[idx][1]= (this.HexCenterY);
          }
          BOOL_AnimateSwitch= true;
        }else{
          for(int idx= 0; idx < HexButtonSum; idx++){
            ButtonPos[idx][0]= Positions[idx * 2];
            ButtonPos[idx][1]= Positions[idx * 2 + 1];
          }          
        }
        
        if(BOOL_ShowHexButtons == true){
          if(BOOL_Expanded == false){
            updateHexButtonLocation(true);
            if(HexButtonDistance < HexButtonDistanceToCenter){
                for(int idx= 0; idx < HexButtonSum; idx++){
                  ButtonPos[idx][0]= Positions[idx * 2];
                  ButtonPos[idx][1]= Positions[idx * 2 + 1];
              }
              HexButtonDistance+= HexButtonMoveSpeed;
            }else{
              BOOL_Expanded= true;
            }
          }
        }else{
          if(BOOL_Expanded == true){
            if(HexButtonDistance  >= 0){
                for(int idx= 0; idx < HexButtonSum; idx++){
                  ButtonPos[idx][0]= Positions[idx * 2];
                  ButtonPos[idx][1]= Positions[idx * 2 + 1];
              }
              HexButtonDistance-= HexButtonMoveSpeed * 1.2;
            }else{
              BOOL_Expanded= false;
              BOOL_AnimateSwitch= false;
              updateHexButtonLocation(true);
              hideHexButtons();
            }
          }
        }
      }  
      

/*      
      public void handleInputEvent(int EventType)
      {
        switch(EventType){
          case 0:
            if((mouseButton == LEFT)){
                 BOOL_RightMouseSwitch= false;
                 if(BOOL_ShowHexButtons == false)
                   Pt.paint(PaintMode, mouseX, mouseY, 0, 0);
            } 
            if((mouseButton == RIGHT)){
                 BOOL_RightMouseSwitch= (BOOL_RightMouseSwitch == true)? false : true;
            }   
            break;
        }
      }
*/ 
     
     public void drawDottedLine(
                    float StartX, 
                    float StartY, 
                    float Degree, 
                    float Spacing, 
                    float SpaceRandomness, 
                    float DotSize, 
                    float SizeRandomness, 
                    int Step)
      {
        noStroke();
        fill(255);
        float x=StartX, y= StartY;
        float a= radians(Degree);
        for(int idx= 0; idx < Step; idx++){
          float R= random(SizeRandomness);
          x+= Spacing * cos(a) * random(1, SpaceRandomness);
          y+= Spacing * sin(a) * random(1, SpaceRandomness);
          ellipse(x, y, DotSize * R, DotSize * R);
        }
      }
      
      public void genLand(float w, float h, float HeightRatio)
      {
        int Perspeca= 12;
        float space= 0;
        noStroke();
        fill(17, 53, 103, 9);
        rect(0, h * (1 - HeightRatio), w, h * HeightRatio);
        for(int i= 0; i < 4; i++){
          drawDottedLine(0, h * (1 - HeightRatio) + i * 2, 0, 9, 1, 2, 1, 500);
        }
        for(int degree= 11; degree < 162; degree+= 18, space+= 20){
          for(int idx= 0; idx < 10; idx+= 3){
            drawDottedLine(750 - space, 1050, degree + idx, 9, 1, 2.5, 1, 100);
          }
        }
      }  
      
      
      void setMouseSwitch()
      {
        if((mouseButton != 0) && (mousePressed)){
              if((mouseButton == LEFT)){
                   if((BOOL_RightMouseSwitch == false) && (BOOL_Expanded == false)){
                     if(BOOL_Expanded == false){
                       //Pt.paint(PaintMode, mouseX, mouseY, 0, 0);
                     }
                   }
                   BOOL_RightMouseSwitch= false;
              }
              if(mouseButton == RIGHT){
                   BOOL_RightMouseSwitch= (BOOL_RightMouseSwitch == true)? false : true;
              }   
              mouseButton= 0;
              mousePressed= false;
        }
      }
      
      void evalHexButtons()
      {
        if(BOOL_RightMouseSwitch){
            switchHexButton(true);
          }else{
            switchHexButton(false);
            updateHexButtonLocation(false);
          }
        if(BOOL_ShowHexButtons || BOOL_Expanded)  
          for(int idx= 0; idx < this.HexButtonSum; idx++){
          HexButtons[idx].update();
        }else{
          updateHexButtonLocation(true);
        }   
      }
      
      public void update()
      {
        //if(!AnimationSequence.isFrameReady())return;
        this.flushBackground();
        //setMouseSwitch();
        noTint();
        AnimationSequence.startTasks();
        //Pt.paintLayerToScreen(0);
        /*
        if(this.BOOL_StartSwitch == false){
          StartButton.show();
          AnimationSequence.pauseTasks();
          StartButton.update();
        }else if(this.BOOL_StartSwitch && (StartButton.BOOL_PostSelected == false)){
          StartButton.shrinkButton();
          StartButton.show();
        }else{
          AnimationSequence.startTasks();
        }
        */
        AnimationSequence.evalAnimateQueue(); 
      }
      
      public void addAnimationTask(AnimationTask A)
      {
        AnimationSequence.addTask(A);
      }
      
      public void savAbstractArtID(int ArtID)
      {
        if(BOOL_FirstTime){
          BOOL_FirstTime= false;
          this.PreAbstractButtonArtID= this.AbstractButtonArtID= ArtID;
        }
      this.PreAbstractButtonArtID= this.AbstractButtonArtID;
        this.AbstractButtonArtID= ArtID;
      }
      
      public void setAbstractTarget(int TargetID)
      {
         if(this.BOOL_FirstTime){ 
           this.BOOL_FirstTime= false;
           this.setAbstractTarget= TargetID;
         }else{
           return;
         }
      }
      
      public boolean isAbstractButtonSame()
      {
        if(BOOL_FirstTime){
          return true;
        }
        return this.PreAbstractButtonArtID == this.AbstractButtonArtID;
      }
      
      public boolean isTagetSame()
      {
        if(BOOL_FirstTime){
          return true;
        }
        return this.setAbstractTarget == this.AbstractButtonArtID;
      }
      
      
      public void makeCharacters()
      {
       Girl= new Girls("Girl", 0);
       Goo01= new Goos("Goo01", 12);
       Goo00= new Goos("Goo00", 33);
      }
      
      int init()
      {
        this.Pt= new Painter(ScreenSizeX, ScreenSizeY, LayerSum);
        Pt.setTextureFolder("");
        this.makeButton();
        buildCubeSpace();
        makeCharacters();
        loadGameMap();
        AnimationSequence= new AnimationSequencer();
        APlot= new Plot();
        AnimationSequence.startSequencer();
        return 0;
      }
      
      
      public SceneManager(int SceneSizeX, int SceneSizeY, int LayerSum)
      {
        SizeX= SceneSizeX;
        SizeY= SceneSizeY;
      }

};

     
     
     
     
/************************************************************************
                  Revision History
V0.01a                  
  Button widget implemented;
  Layer system partially implemented;
  Demo program(Avalon Painter) partially implemented;
  
  Java's GUI system turn to be old fashioned, so the GUI system's design
  goal is to give processing a native feeling user interface. The GUI should be:
  1) K.I.S.S.
  2) Ergonomics
  3) User Friendly
  4) Visually stunt
  Hopefully it is not a practice of reinventing the wheels ;)
  By the way, Avalon is just a code name for the project. It actually came from
  the movie Avalon.
  
  Mouse button has a pattern of inresponsiveness problem;
  PImage's copy(...) function may not be suitable to implement layer function; 
  
v0.02a  
  mouse button function improved; layer function improved;
  
  Fixed the mouse responsiveness problem. The problem turn out result from 
  that the processing's mouseButton variable is not reset immediately 
  to 0 after the mouse button has been released;
  Alpha blend problem was fixed by Using PImage's blend(...) instead 
  of copy(...) function to implement the layer functions;
  
  GUI(Widget system) need to be implemented as a standalone library. Its name
  could be Avalon GUI;
  Other widgets need to be added to the library, depended on their necessarity.
  Some redundant functions need to be eliminated
*************************************************************************/