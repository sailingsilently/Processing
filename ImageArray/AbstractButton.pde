/*********************************************************
*
*                   Abstract Button v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//Enhanced button object, derived from the GUI system

class AbstractButton extends Button
{
  private PImage ButtonImages[]= new PImage[APlot.TestIconSum];
  private PImage AbstractArtworks[]= new PImage[SceneMgr.AbstractArtworksSum];
  private PImage Texture= new PImage();
  private int AbstractID;
  private boolean BOOL_Lock= false;
  private boolean BOOL_Right= false;
  
  public void genButtonTexture()
  {
    
  }
  
  public boolean mouseOver()
  {
    if(BOOL_Lock){
      return false;
    }
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
    strokeWeight(4);
    fill(200, 200, 200, 128);
    stroke(255);
    ellipse(this.getPosX() + this.getSizeX() / 2, this.getPosY() + this.getSizeY() / 2, this.getSizeX(), this.getSizeY());
    return true;
  }
  
  protected void drawSelf()
  {
    if(BOOL_Lock){
      stroke(255, 0, 0);
      strokeWeight(4);
      fill(255, 0, 0, 128);
      ellipse(this.getPosX() + this.getSizeX() / 2, this.getPosY() + this.getSizeY() / 2, this.getSizeX(), this.getSizeY());
      return;
    }
    if(BOOL_Right){
    image(ButtonTexture, 
          this.getPosX(), 
          this.getPosY());
      stroke(255, 255, 255);
      strokeWeight(4);
      noFill();
      ellipse(this.getPosX() + this.getSizeX() / 2, this.getPosY() + this.getSizeY() / 2, this.getSizeX(), this.getSizeY());
      return;
    }
    image(ButtonTexture, 
          this.getPosX(), 
          this.getPosY());
  }
  
  public int onActive()
   {
     if(BOOL_Lock) return 0;
     this.Handlerins.callback(this.getUID());
     return 0;
   }
   
  public void lockButton()
  {
    BOOL_Lock= true;
  }
  
  public void setRight()
  {
    this.BOOL_Right= true;
  }
  
  public int getAbstructID()
  {
      return AbstractID;
  }
  
  public AbstractButton(int UID, 
                        int AbstractArtworkID,
                        int PosX, 
                        int PosY, 
                        int TextureX, 
                        int TextureY,
                        int AClipSize)
  {
    super(UID, "", "mask.png", "", PosX - AClipSize / 2, PosY - AClipSize / 2);
    this.ButtonTexture.loadPixels();
    AbstractID= AbstractArtworkID;
    this.Texture= createImage(AClipSize, AClipSize, ARGB);
    this.Texture.copy(SceneMgr.AbstractArtworks[AbstractID], TextureX, TextureY, AClipSize, AClipSize, 0, 0, AClipSize, AClipSize);
    this.ButtonTexture.resize(AClipSize, AClipSize);
    this.Texture.mask(this.ButtonTexture);
    this.ButtonTexture= this.Texture;         
    this.setSizeX();
    this.setSizeY();
  }
}