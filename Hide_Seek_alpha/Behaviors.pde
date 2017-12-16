/*********************************************************
*
*               Characters v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
/*class Behaviors{  
  PImage Walk= new PImage();
  int StandIndex= 0;
  int PathIndex;
  int StepCount= 0;
  int SleepInterval= 300;
  float PosX, PosY;
  float StepLength= 0.02;
  float DX, DY;
  float TargetX;
  float TargetY;
  float DisplacementX, DisplacementY;
  boolean BOOL_AnimationSwitch= false;
   Object PathArray[];
   int PathArrayIndex= 0;
  
  float BarrierHeight= CubesList[0].getHeight() / 2 - CubesList[0].getHeight() / 2 * 0.1;
  
  PImage Anim_Walk_Left_Buttom[]= new PImage[4];
  int FrameCounter= 0;
  
  int StandingTime= 0;
  int StandingChange= 10;
  int AnimTimes= 0;
  int AnimIndex= 0;
  int AnimCounter= 0;
  int Interval= 0;
  int RenderingAnimIndex;
  
  ConcurrentLinkedQueue PathResult= null, PathResultS= new ConcurrentLinkedQueue();
  
  int getAnimIndex()
  {
    return 0;
  }
  
  void switchAnim(boolean on)
  {
    BOOL_AnimationSwitch= on;
  }  
  
  void setTargetPath(int PathIndex)
  {
    this.PathIndex= PathIndex;
  }
  
  void setStandingPoint(float PosX, float PosY)
  {
    this.PosX= PosX;
    this.PosY= PosY;
  }
  
  public float getStandingPosX()
  {
    return this.PosX;
  }
  
  public float getStandingPosY()
  {
    return this.PosY;
  }
  
  void setTargettingPoint(float TargetX, float TargetY)
  {
    this.TargetX= TargetX;
    this.TargetY= TargetY;
  }
  
  public int getStandingCubeIndex()
  {
    return StandIndex;
  }
  
  public void setStandingCubeIndex(int StandIndex)
  {
    this.StandIndex= StandIndex;
  }
  
  void loadAnimation(String AnimFilePrefix, PImage ImageArray[])
  {
    for(int i= 0; i < ImageArray.length; i++){
      String FineName;
      if(i < 10){
        FineName= ANIMATION_FRAM_PATH + AnimFilePrefix + "_000" + i;
      }else if((i >= 10) && (i < 100)){
        FineName= ANIMATION_FRAM_PATH + AnimFilePrefix + "_00" + i;
      }else if((i >= 100) && (i < 1000)){
        FineName= ANIMATION_FRAM_PATH + AnimFilePrefix + "_0" + i;
      }else{
        FineName= ANIMATION_FRAM_PATH + AnimFilePrefix + "_" + i;
      }
      ImageArray[i]= loadImage(FineName + ".png");
    }
  }
  
    void findPathByMousePosition()
    {
        if(PointedCubeIndex != -1){
          PathResult= findPath(Girl.getStandingCubeIndex(), PointedCubeIndex);
          if(PathResult != null){
          PathArray= PathResult.toArray();
            PathArrayIndex= 0;
            println("Girl at: ", Girl.getStandingCubeIndex());
            println(PathResult);
          }
        }
    }
 /* 
  boolean getWayPoint()
  {
    int Clif= 0;
    if(PathResult != null)
    if(!PathResult.isEmpty()){
      if(StandIndex == PathIndex){
        PathIndex= (int)(PathResult.poll());        
        if(!PathResult.isEmpty()){
            if(isClif(StandIndex, PathIndex)){
              if(Clif == 0){
                Clif= CubesList[0].Width / 4;
              }else{
                Clif= 0;
              }
            }
          }
        if(PathIndex != StandIndex){
          DX= (CubesList[PathIndex].PosX - CubesList[StandIndex].PosX) / StepCount;
          DY= (CubesList[PathIndex].PosY - CubesList[StandIndex].PosY) / StepCount;
          PosX= CubesList[StandIndex].PosX - Clif;
          PosY= CubesList[StandIndex].PosY;
          TargetX= CubesList[PathIndex].PosX - Clif;
          TargetY= CubesList[PathIndex].PosY;
          return true;
        }else{
          return false;
        }
      }
    }
    return false;
  }
  int ClifX= 0, ClifY= 0;
  boolean getWayPoint()
  {
    if(PathResult != null)
    if(PathArrayIndex < PathArray.length){
      if(StandIndex == PathIndex){
        PathIndex= (int)(PathArray[PathArrayIndex++]);
        if(PathIndex != StandIndex){
          DX= (CubesList[PathIndex].PosX - CubesList[StandIndex].PosX) / StepCount;
          DY= (CubesList[PathIndex].PosY - CubesList[StandIndex].PosY) / StepCount;
          PosX= CubesList[StandIndex].PosX - CubesList[0].Width / 4;
          PosY= CubesList[StandIndex].PosY;
          TargetX= CubesList[PathIndex].PosX - CubesList[0].Width / 4;
          TargetY= CubesList[PathIndex].PosY;
          return true;
        }else{
          return false;
        }
      }
    }
    return false;
  }
  
  
  int InBetweenCounter= 0;
  float InBetweenX= 0;
  float InBetweenY= 0;
  void getInBetween(int FrameTotal)
  {
    PosX+= (CubesList[PathIndex].PosX - CubesList[StandIndex].PosX) / FrameTotal;
    PosY+= (CubesList[PathIndex].PosY - CubesList[StandIndex].PosY) / FrameTotal;
    PosX= (PosX > TargetX)? TargetX : PosX;
    PosY= (PosY > TargetY)? TargetY : PosY;
    if(InBetweenCounter++ == FrameTotal){
      InBetweenCounter= 0;
      PosX= TargetX;
      PosY= TargetY;
    }
  }
  
 int getIdleAnimIndex()
 {
   return 0;
 }
 
 void walk()
 {
      int InBetween= 20;
        if(FrameCounter++ > InBetween){
            if(getWayPoint() == false){
                StandingTime++; 
                if(RenderingAnimIndex != getIdleAnimIndex()){
                  AnimIndex= 0;
                  this.switchAnim(false);
                }
              }else{
                if(this.StandIndex == this.PathIndex ){
                  StandingTime++;
                  this.switchAnim(false);
                  AnimIndex= 0;
                }else{
                  this.switchAnim(true);
                  RenderingAnimIndex= getAnimIndex();
                }
            }
            StandIndex= PathIndex;
            FrameCounter= 0;
            InBetweenX= (TargetX- PosX) / (InBetween + 2);
            InBetweenY= (TargetY- PosY) / (InBetween + 2);
        }
        PosX+= InBetweenX;
        PosY+= InBetweenY;
 }
  
  
  boolean isClif(int Index, int Next)
  {
    int Targetting;
    
        if(abs(CubesList[Index].getPosY() - CubesList[Next].getPosY()) < BarrierHeight){
          return false;
        }else{
          return true;
        }
    }
  
  Behaviors(String Name, int UID){
    StepCount= floor(1.0 / StepLength);
    DisplacementX= + CubesList[0].getSizeX() / 10.5;
    DisplacementY= - CubesList[0].getSizeY() / 2.5;
  }
}*/