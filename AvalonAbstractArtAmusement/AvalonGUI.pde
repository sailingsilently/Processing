/*********************************************************
*
*               Avalon GUI v0.02a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
import java.util.*;

class ErrorIndex{
      final int NO_ERROR= 0x0000,
          ERROR= 0xffff,
          FILE_DOES_NOT_EXIST= 0xfffe, 
          INDEX_OUT_OF_RANGE= 0xfffd,
          ENUM_DOES_NOT_WORK= 0xffff,
          SOMTHING_OVERFLOWED= 0xffff,
          NO_FOOD_FOR_WATCHDOG= 0xffff,
          FOODS_ARE_TOO_EXPENSIVE= 0xffff,
          TUITION_IS_TOO_EXPENSIVE= 0xffff,
          EVERYTHING_IS_TOO_EXPENSIVE= 0xffff;
  }
  
final ErrorIndex ErrorTypes= new ErrorIndex();
//Global variables

//Object definations


//GUI base class

class Widget {
      private int UID;
      private String Name;
      private String Help;
      private float PosX= 0.0;
      private float PosY= 0.0;
      private float SlidePos= 0.0;
      private float Scale= 1.0;
      private boolean BOOL_Visible= false;
      protected boolean BOOL_Lock= false;
      protected boolean BOOL_Pressed= false;
      protected boolean BOOL_MouseOver= false;
      protected float SizeX= 0.0;
      protected float SizeY= 0.0;
      protected PImage BackgroundTexture;
      
/*********Overrided by specified widgets*********/
      
      private boolean mouseOver()
      {
        return this.BOOL_MouseOver= true;
      }
      
      private boolean mouseLeave()
      {
        return this.BOOL_MouseOver= false;
      }
      
      private void drag()
      {
        return; 
      }
      
      private void drawSelf()
      {
        return;
      }

/*********End of overridable functions definition*********/     

      public float setSizeX()
      {
        return this.SizeX;
      }
      
      public float setSizeY()
      {
        return this.SizeY;
      }
      
      protected boolean pressed()
      {
        return this.BOOL_Pressed= true;
      }
      
      protected boolean release()
      {
        return this.BOOL_Pressed= false;
      }
      
      public boolean hide()
      {
        return this.BOOL_Visible= false;
      }
      
      public boolean show()
      {
        return this.BOOL_Visible= true;
      }
      
      public boolean isVisiable()
      {
        return this.BOOL_Visible;
      }
      
      public boolean isLocked()
      {
        return this.BOOL_Lock;
      }
      
      public boolean isPressed()
      {
        return this.BOOL_Pressed;
      }
      
      public boolean isMouseOver()
      {
        return false;
      }
      
      public boolean lockSelf()
      {
        return this.BOOL_Lock= true;
      }
      
      public void setHelp(String HelpContent)
      {
        this.Help= HelpContent;
      }
      
      public void showHelp()
      {
        return;
      }
 
      public void setName(String Name)
      {
        this.Name= Name;
      }
 
      public String getName()
      {
        return this.Name;
      }
      
      public int getUID()
      {
        return this.UID;
      }
      
      public float getPosX()
      {
        return this.PosX;
      }
      
      public float getPosY()
      {
        return this.PosY;
      }
      
      public float setPosX(float PosX)
      {
        return this.PosX= PosX;
      }
      
      public float setPosY(float PosY)
      {
        return this.PosY= PosY;
      }
      
      public float setScale(float Scale)
      {
         return this.Scale= Scale;
      }
      
      public float getScale()
      {
         return this.Scale;
      }
      
      public float getSizeX()
      {
        return this.SizeX;
      }
      
      public float getSizeY()
      {
        return this.SizeY;
      }        
      
      protected int setUID(int UID)
      {
        return this.UID= UID;
      }

      //GUI "Call back object", just to emulate the classic callback mechanism
      public int callback_MouseOver()
      {
        this.mouseOver();
        return ErrorTypes.NO_ERROR;
      }
      
      public int callback_MouseLeave()
      {
        return ErrorTypes.NO_ERROR;
      }
      
      public int callback_Pressed()
      {
        return ErrorTypes.NO_ERROR;
      }
      
      public void callback_drag()
      {
      }
}

interface EventHandler{
  public void callback(int UID);
}

class EventCallback implements EventHandler{
  void callback(int UID){
  }
}

class Button extends Widget{
      protected float MiddleTone= 128;
      protected float HighTone= 255;
      protected float[] TintColor={MiddleTone, MiddleTone, MiddleTone};
      protected float TintSpeed= 8;
      protected float RecoverRate= 0.425;
      protected float RedYellowRatio= 0.75;
      protected EventHandler Handlerins;
      protected PImage ButtonTexture;

      public float setSizeX()
      {
        return this.SizeX= ButtonTexture.width;
      }
      
      public float setSizeY()
      {
        return this.SizeY= ButtonTexture.height;
      }      
      
      public boolean isPressed()
      {
        if(isMouseOver() && (mouseButton != 0)){
          this.pressed();
          return true;
        }else{
          BOOL_Pressed= false;
          return false;
        }
      }
      
      protected void drawSelf()
      {
        image(ButtonTexture, 
              this.getPosX(), 
              this.getPosY());
      }

//Hue-> 0: red, 1: green, 2: blue, 3: reset
      protected void helper_tintButton(int Hue, float ValueInc)
      {
        if(Hue > 2){
          noTint();
          return;
        }
        TintColor[Hue]= (TintColor[Hue] + ValueInc) > 255? 255 : TintColor[Hue] + ValueInc;
        TintColor[Hue]= (TintColor[Hue] + ValueInc) < 0? 0 : TintColor[Hue] + ValueInc;
        tint(TintColor[0], TintColor[1], TintColor[2]);
      }
      
      public boolean mouseOver()
      {
        if(BOOL_MouseOver == false){
          TintColor[0]= TintColor[1]= TintColor[2]= MiddleTone;
          BOOL_MouseOver= true;
        }
        if((TintColor[0] <= HighTone) || (TintColor[0] <= HighTone) || (TintColor[0] <= HighTone)){
          helper_tintButton(0, TintSpeed);
          helper_tintButton(1, TintSpeed * RedYellowRatio);
          drawSelf();
        }else{
          tint(TintColor[0], TintColor[1], TintColor[2]);
          drawSelf();
        }
        return true;
      }
      
      public boolean isMouseOver()
      {
        float ImgX, ImgY, sx, sy;
        ImgX= mouseX - (this.getPosX());
        ImgY= mouseY - (this.getPosY());
        sx= this.getSizeX();
        sy= this.getSizeY();
        if((ImgX < 0.0) || (ImgY < 0.0) || (ImgX >= sx) || (ImgY >= sy)){
          return false;
        }
        if(alpha(this.ButtonTexture.pixels[int(sx * ImgY + ImgX)]) != 0){
          if(isVisiable())cursor(HAND);
          return true;
        }else{
          cursor(ARROW);
          return false;
        }
      }
      
      public boolean mouseLeave()
      {
        if(BOOL_MouseOver == true){
          BOOL_MouseOver= false;
        }
        if((TintColor[0] >= HighTone) & (TintColor[0] >= HighTone) & (TintColor[0] >= HighTone)){
          helper_tintButton(0, 255);
          helper_tintButton(1, 255);
          helper_tintButton(2, 255);
          drawSelf();
        }else{
          noTint();
          this.drawSelf();
        }
        return true;
      }
      
      public void highlightButton()
      {
        return;
      }
      
      public void drawPressedButton()
      {
        return;
      }
      

      public void setActiveAction(EventHandler callback){
        this.Handlerins= callback;
      }
      
      public int onActive()
       {
         this.Handlerins.callback(this.getUID());
         return 0;
       }
       
        public void update()
      {
        if(isMouseOver()){
          this.mouseOver();
          if(isPressed()){
            onActive();
          }
        }else{
          this.mouseLeave();
        }
      }     
      
      //Constructor
      public Button(int UID, String ButtonName, String ButtonTexture, String Help, float PosX, float PosY)
      {
         this.setName(ButtonName);
         this.ButtonTexture= loadImage(ButtonTexture);
         this.setHelp(Help);
         this.setUID(UID);
         this.setPosX(PosX);
         this.setPosY(PosY);
         this.setSizeX();
         this.setSizeY();
      }
}




class BrokenButton extends Button{ 
      private int BrokenSum= 12;
      private PImage BrokenIcons[]= new PImage[BrokenSum];
      private PImage DropIcon= new PImage();
      private int BrokenWidth, BrokenHeight;
      private PImage ActiveIcon;
      private float BrokenIndex= 0;
      private float BrokenRate= 0.2;
      private boolean BOOL_PostSelected= false;
      private float ResizeRatio= 1.0;
      private float ResizeUnit= 0.025;
      private float ResizeLimit= 0.05;
      private float T= 0;
      private float TimeUnit= 0.25;
      
      public void setVideo(String FileName)
      {
        
      }      
      
      protected void drawSelf()
      {
        image(ActiveIcon, 
              this.getPosX(), 
              this.getPosY());
      }
      
      private void brakeButton()
      {
        int ShiftAmount[]={
          19,
          -29,
          -19,
          15,
          9,
          9,
          -9,
          -9
        };
        int ClipHeight[]={
          12,
          90,
          18,
          30,
          19,
          9,
          11,
          1
        };
        int X= 0, Y= 0;
        for(int i= 1; i < BrokenSum; i++){
        BrokenIcons[i].blend(this.BrokenIcons[i - 1], 
                              0, 
                              0, 
                              this.BrokenIcons[0].width, 
                              this.BrokenIcons[0].height,
                              0,
                              0,
                              this.BrokenIcons[0].width,
                              this.BrokenIcons[0].height,
                              BLEND);
         BrokenIcons[i].loadPixels();
         for(int h= 0; h < ClipHeight.length; h++){
             BrokenIcons[i].copy(this.BrokenIcons[i - 1], 
                                 0, 
                                 Y, 
                                 BrokenIcons[0].width, 
                                 ClipHeight[h], 
                                 ShiftAmount[h], 
                                 Y, 
                                 BrokenIcons[0].width, 
                                 ClipHeight[h]);
             Y+= ClipHeight[h];
         }
         BrokenIcons[i].updatePixels(); 
        }
      }
      
      private void resetIcon(PImage icon)
      {
        icon.blend(this.ButtonTexture, 
                                0, 
                                0, 
                                this.ButtonTexture.width, 
                                this.ButtonTexture.height,
                                (BrokenWidth - this.ButtonTexture.width) / 2,
                                (BrokenHeight - this.ButtonTexture.height) / 2,
                                this.ButtonTexture.width,
                                this.ButtonTexture.height,
                                BLEND);
      }  
      
      public boolean isMouseOver()
      {
        float ImgX, ImgY, sx, sy;
        ImgX= mouseX - (this.getPosX());
        ImgY= mouseY - (this.getPosY());
        sx= this.BrokenIcons[0].width;
        sy= this.BrokenIcons[0].height;
        if((ImgX < 0.0) || (ImgY < 0.0) || (ImgX >= sx) || (ImgY >= sy)){
          return false;
        }
        if(alpha(this.ActiveIcon.pixels[int(sx * ImgY + ImgX)]) != 0){
          if(isVisiable())cursor(HAND);
          return true;
        }else{
          cursor(ARROW);
          return false;
        }
      }
      
      public boolean mouseLeave()
      {
        if(BOOL_MouseOver == true){
          BOOL_MouseOver= false;
        }
        setActiveIconButton(floor(BrokenIndex= (BrokenIndex-= BrokenRate) < 0 ? 0 : BrokenIndex ));
        if((TintColor[0] >= HighTone) & (TintColor[0] >= HighTone) & (TintColor[0] >= HighTone)){
          helper_tintButton(0, TintSpeed * 0.25);
          helper_tintButton(1, TintSpeed * 0.25);
          helper_tintButton(2, TintSpeed * 0.25);
          drawSelf();
        }else{
          noTint();
          this.drawSelf();
        }
        return true;
      }

      
      public boolean mouseOver()
      {
        float r= random(0, 100);
        if(BOOL_MouseOver == false){
          TintColor[0]= TintColor[1]= TintColor[2]= MiddleTone;
          BOOL_MouseOver= true;
        }
        setActiveIconButton(floor(BrokenIndex= (BrokenIndex+= BrokenRate) >= BrokenSum ? BrokenSum - 1 : BrokenIndex));
        if(r > 10 && r < 19){
          setActiveIconButton(floor(BrokenIndex= (BrokenIndex= random(0, BrokenSum)) >= BrokenSum ? BrokenSum - 1 : BrokenIndex));
        }
        if((TintColor[0] <= HighTone) || (TintColor[0] <= HighTone) || (TintColor[0] <= HighTone)){
          helper_tintButton(0, TintSpeed);
          helper_tintButton(1, TintSpeed * RedYellowRatio);
          drawSelf();
        }else{
          tint(TintColor[0], TintColor[1], TintColor[2]);
          drawSelf();
        }
        return true;
      }
      
      public void setActiveIconButton(int index)
      {
        if((index >= BrokenSum) || (index < 0))return;
        ActiveIcon= BrokenIcons[index];
      }
      
      public void dropdown()
      {
        if(BOOL_PostSelected == true) return;
        do{
          if(BrokenIndex == 0)break;
            mouseLeave();
            ActiveIcon= DropIcon;
            if(BrokenIndex >= 0)return;
        }while(BrokenIndex > 0);
        ResizeRatio= (ResizeRatio-= ResizeUnit) > 0? ResizeRatio : ResizeUnit;
        if(ResizeRatio >= ResizeLimit){
          image(ActiveIcon, 
                this.getPosX() + floor(((BrokenIcons[0].width - DropIcon.width) / 2)), 
                this.getPosY() + floor(((BrokenIcons[0].height - DropIcon.height) / 2)) + 9.8 * T * T / 2);
          if(T != 0){
            DropIcon.resize(ceil(BrokenIcons[0].width * ResizeRatio), ceil(BrokenIcons[0].height * ResizeRatio));
            ActiveIcon.filter(BLUR, 0.5);
          }
          T+= TimeUnit;
        }else{
          this.setPosX(this.getPosX() + floor(((BrokenIcons[0].width - DropIcon.width) / 2)));
          this.setPosY(this.getPosY() + floor(((BrokenIcons[0].height - DropIcon.height) / 2)) + 9.8 * T * T / 2);
          BOOL_PostSelected= true;
          ActiveIcon= BrokenIcons[0];
          resetIcon(this.DropIcon);
          ResizeRatio= 1.0;
        }
      }
 
      public void shrinkButton()
      {
        if(BOOL_PostSelected == true) return;
        do{
          if(BrokenIndex == 0)break;
            mouseLeave();
            ActiveIcon= DropIcon;
            if(BrokenIndex >= 0)return;
        }while(BrokenIndex > 0);
        ResizeRatio= (ResizeRatio-= ResizeUnit) > 0? ResizeRatio : ResizeUnit;
        if(ResizeRatio >= ResizeLimit){
          image(ActiveIcon, 
                this.getPosX() + floor(((BrokenIcons[0].width - DropIcon.width) / 2)), 
                this.getPosY() + floor(((BrokenIcons[0].height - DropIcon.height) / 2)));
          if(T != 0){
            DropIcon.resize(ceil(BrokenIcons[0].width * ResizeRatio), ceil(BrokenIcons[0].height * ResizeRatio));
            ActiveIcon.filter(BLUR, 0.5);
          }
          T+= TimeUnit;
        }else{
          this.setPosX(this.getPosX() + floor(((BrokenIcons[0].width - DropIcon.width) / 2)));
          this.setPosY(this.getPosY() + floor(((BrokenIcons[0].height - DropIcon.height) / 2)));
          BOOL_PostSelected= true;
          ActiveIcon= BrokenIcons[0];
          resetIcon(this.DropIcon);
          ResizeRatio= 1.0;
        }
      }      
      
      public BrokenButton(int UID, String ButtonName, String ButtonTexture, String Help, float PosX, float PosY)
      {
        super(UID, ButtonName, ButtonTexture, Help, PosX, PosY);
        BrokenWidth= this.ButtonTexture.width * 2;
        BrokenHeight= this.ButtonTexture.height * 2;
        for(int i= 0; i < BrokenSum; i++){
          BrokenIcons[i]= createImage(BrokenWidth, BrokenHeight, ARGB);
        }
        resetIcon(BrokenIcons[0]);
      this.DropIcon= createImage(BrokenWidth, BrokenHeight, ARGB);
      resetIcon(this.DropIcon);
      brakeButton();
      ActiveIcon= BrokenIcons[0];
      }
}

     
     
     
     
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