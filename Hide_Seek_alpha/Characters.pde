/*********************************************************
*
*               Characters v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
/*********************************************************
Action animation postfix is in 4 digits start with 0000
***********************************************************/

import java.util.*;

class Characters{  
  String Name;
  PImage Walk= new PImage();
  int StandIndex= 0;
  int PathIndex;
  int StepCount= 0;
  int SleepInterval= 300;
  float PosX= -1000, PosY= -1000;
  float StepLength= 0.02;
  float DX, DY;
  float TargetX;
  float TargetY;
  float DisplacementX, DisplacementY;
  boolean BOOL_AnimationSwitch= false;
   Object PathArray[];
   int PathArrayIndex= 0;
  
  float BarrierHeight= CubesList[0].getHeight() / 2 - CubesList[0].getHeight() / 2 * 0.3;
  
  PImage Anim_Walk_Left_Buttom[]= new PImage[4];
  int FrameCounter= 0;
  
  int StandingTime= 0;
  int StandingChange= 10;
  int AnimTimes= 0;
  int AnimIndex= 0;
  int AnimCounter= 0;
  int Interval= 0;
  int RenderingAnimIndex;
  int TargetIndexSav;
  
  LinkedList PathResult= null, PathResultS= new LinkedList();
  
  void setTargetIndexSav(int TargetIndex)
  {
    this.TargetIndexSav= TargetIndex;
  }
  
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
  
  public int setPathIndex(int PathIndex)
  {
    return this.PathIndex= PathIndex;
  }
  
  public int getPathIndex()
  {
    return this.PathIndex;
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
          TargetIndexSav= PointedCubeIndex;
          PathResult= CubePathFinder.findPathDijkstra(this.getStandingCubeIndex(), PointedCubeIndex);
          if(PathResult != null){
          PathArray= PathResult.toArray();
            PathArrayIndex= 0;
            if(DEBUG_MODE){
              println(this.Name, " at: ", this.getStandingCubeIndex());
              println(PathResult);
            }
          }
        }
    }    
    

    void findPathByCubeIndex(int TargetIndex)
    {
      PathResult= CubePathFinder.findPathDijkstra(this.getStandingCubeIndex(), TargetIndex);
      if(PathResult != null){
        PathArray= PathResult.toArray();
        PathArrayIndex= 0;
        if(DEBUG_MODE){
          println(this.Name, " at: ", this.getStandingCubeIndex());
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
  }*/
  
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
          //return false;
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
   findPathByCubeIndex(this.TargetIndexSav);
   
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
    if(CubesList[Index] == null || CubesList[Next] == null)return true;
        if(abs(CubesList[Index].getPosY() - CubesList[Next].getPosY()) < BarrierHeight){
          return false;
        }else{
          return true;
        }
    }


  int getLayer()
  {
    return CubesList[this.getStandingCubeIndex()].getLayerIndex();
  }
  
  
  Characters(String Name, int UID){
    this.Name= Name;
    StepCount= floor(1.0 / StepLength);
    DisplacementX= + CubesList[0].getSizeX() / 3.8;
    DisplacementY= - CubesList[0].getSizeY() / 2;
  }
}




class Girls extends Characters{
  final int WalkingAnimationFrameSum= 16;
  final int WavingHand= 36;
  
  String GirlPrefix= "girl/";
  
  PImage Waving_Hand[]= new PImage[WavingHand];
  PImage Walking_TR[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_TL[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_BR[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_BL[]= new PImage[WalkingAnimationFrameSum];
  
  String Animation_Wavinghand= "girl_wavinghand";
  String Animation_Walking_Buttom_Left= "girl_walking_BL";
  String Animation_Walking_Top_Right= "girl_walking_TR";
  String Animation_Walking_Buttom_Right= "girl_walking_BR";
  String Animation_Walking_Top_Left= "girl_walking_TL";
  
  String AnimFile[]= {
    Animation_Wavinghand, 
    Animation_Walking_Top_Right,
    Animation_Walking_Top_Left,
    Animation_Walking_Buttom_Right,
    Animation_Walking_Buttom_Left  };
  
  PImage AnimArray[][]= {
    Waving_Hand,
    Walking_TR,
    Walking_TL,
    Walking_BR,
    Walking_BL
  };
  
  int WavingInbetween= 20  ;
  int WAVINGHAND= 0, WALK_TR= 1, WALK_TL= 2, WALK_BR= 3, WALK_BL= 4;
  
   int getIdleAnimIndex()
 {
   return WAVINGHAND;
 }
  
  int getAnimIndex()
  {
    int Animations[]= {WALK_TR, WALK_BL, WALK_TL, WALK_BL, WALK_TR, WALK_BR, WALK_TL, WALK_BL};
    if((StandIndex == UNCONNECTED) && (PathIndex == UNCONNECTED)) return WAVINGHAND;
    for(int i= 0; i < PathList[StandIndex].Way.length; i++){
      if(PathList[StandIndex].Way[i] == PathIndex){
        return Animations[i];
        }
      }
    return WAVINGHAND;
  }
  
  void walkGirl()
  {
    //differeingCubesMap(this.getStandingCubeIndex());
    this.checkArrival();
    walk();
    //Standing and waving
        if(StandingTime >= StandingChange){
            RenderingAnimIndex= WAVINGHAND;
            StandingChange= ceil(random(WavingInbetween * ( 0.382 ), WavingInbetween));
            this.switchAnim(true);
              StandingTime= 0;
              AnimTimes= 0;
          }
            if((AnimTimes >= 2) 
                && ((AnimIndex % (AnimArray[RenderingAnimIndex].length)) == 0)
                && (RenderingAnimIndex == WAVINGHAND)
            ){
              this.switchAnim(false);
              AnimTimes= 0;
            }
    differeingCubesMap(getStandingCubeIndex()); 
    drawSelf();
  }
  
  void drawSelf()
  {
    if(AnimCounter++ >= Interval){
      if(BOOL_AnimationSwitch)AnimIndex++;
    }
      //if(PosX != TargetX) PosX+= DX;
      //if(PosY != TargetY) PosY+= DY;
      image(AnimArray[RenderingAnimIndex][AnimIndex % (AnimArray[RenderingAnimIndex].length)], PosX + DisplacementX + SceneMgr.ScreenStartX, PosY + DisplacementY + SceneMgr.ScreenStartY, 120, 120);
      if((AnimIndex % (AnimArray[RenderingAnimIndex].length) == 0) && (RenderingAnimIndex == WAVINGHAND))AnimTimes+= 1;
  }
  
  void checkArrival()
  {
    if(TempTargetCube == this.getStandingCubeIndex()){
       BOOL_Checkmate= true;
    }
  }
  
  Girls(String Name, int UID)
  {
    super(Name, UID);
    for(int i= 0; i < AnimArray.length; i++){
      loadAnimation(GirlPrefix + AnimFile[i], AnimArray[i]);
    }
   //setStandingPoint(CubesList[0].getPosX(), CubesList[0].getPosY());
  }
}

class GoosAnim{
  boolean BOOL_isLoaded= false;
  String GooPrefix= "goo/";
  final int WalkingAnimationFrameSum= 16;
  
  PImage Walking_TR[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_TL[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_BR[]= new PImage[WalkingAnimationFrameSum];
  PImage Walking_BL[]= new PImage[WalkingAnimationFrameSum];
  
  //String Animation_Walking_Buttom_Left= "goo_walking_BL";  
  //String Animation_Walking_Buttom_Right= "goo_walking_BR";
  String Animation_Walking_Top_Right= "goo_walking_TR";
  String Animation_Walking_Top_Left= "goo_walking_TL";
  
  String AnimFile[]= {
    Animation_Walking_Top_Right,
    Animation_Walking_Top_Left,
    //Animation_Walking_Buttom_Right,
    //Animation_Walking_Buttom_Left  
  };
  
  PImage AnimArray[][]= {
    Walking_TR,
    Walking_TL,
    //Walking_BR,
    //Walking_BL
  };   
 
  /*Singleton doesn't working there
  private GoosAnim Instance= null;
  
  public GoosAnim getInstance()
  {
    if(Instance == null){
      Instance= new GoosAnim();
      if(!BOOL_isLoaded){
        loadAnimation();
        BOOL_isLoaded= true;
      }
    }
    return Instance;
  }
  */
  public PImage[][] getAnimArray()
  {
    return AnimArray;
  }
  
  public void loadAnimation()
  {
    if(!BOOL_isLoaded){
      for(int index= 0; index < AnimArray.length; index++){
        for(int i= 0; i < WalkingAnimationFrameSum; i++){
          String FileName;
          if(i < 10){
            FileName= ANIMATION_FRAM_PATH + GooPrefix + AnimFile[index] + "_000" + i;
          }else if((i >= 10) && (i < 100)){
            FileName= ANIMATION_FRAM_PATH + GooPrefix + AnimFile[index] + "_00" + i;
          }else if((i >= 100) && (i < 1000)){
            FileName= ANIMATION_FRAM_PATH + GooPrefix + AnimFile[index] + "_0" + i;
          }else{
            FileName= ANIMATION_FRAM_PATH + GooPrefix + AnimFile[index] + "_" + i;
          }
          this.AnimArray[index][i]= loadImage(FileName + ".png");
        }
      }
    }
    BOOL_isLoaded= true;
  }
  
  GoosAnim()
  {
    return;
  }
  
}




  GoosAnim GooAnim= new GoosAnim();



class Goos extends Characters{
  
  int WanderingTarget;
  
  void wandering()
  {
    int CubeIndex= StandIndex;
    int RandomDirection= (int)(random(0, CubesList[StandIndex].UnitPath.Way.length));
    int Targetting= StandIndex, PreTargetting;
      StandIndex= CubeIndex;
      for(;;){
        PreTargetting= Targetting;
        if((Targetting= CubesList[Targetting].UnitPath.Way[RandomDirection]) != UNCONNECTED){
          if(abs(CubesList[StandIndex].getPosY() - CubesList[Targetting].getPosY()) >= BarrierHeight){
            Targetting= PreTargetting;
            break;
          }
        }else{
          Targetting= PreTargetting;
          break;
        }
      }
            WanderingTarget= Targetting;
            //CubeIndex= Targetting;
            findPathByCubeIndex(Targetting);
  }
  
  
  void placeSelf(int CubeIndex)
  {
    this.PathIndex= this.StandIndex= CubeIndex;
  }
  
  void placeSelfRandomly()
  {
    
  }
  
  boolean seekingGirl()
  {
    return true;
  }  
  
  int getAnimIndex()
  {
    int Animations[]= {0, 1, 0, 1, 0, 1, 0, 1};
    for(int i= 0; i < PathList[StandIndex].Way.length; i++){
      if(PathList[StandIndex].Way[i] == PathIndex){
        return Animations[i];
        }
      }
    return 0;
  }
 
   void walk()
   {
        int InBetween= 20;
          if(FrameCounter++ > InBetween){
              if(getWayPoint() == false){
                    wandering();
                    getWayPoint();
                    //this.switchAnim(false);
                }else{
                  if(this.StandIndex == this.PathIndex ){
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
   
  void walkGoo()
  {
    walk();
    drawSelf();
  }
  
  void drawSelf()
  {
    if(AnimCounter++ >= Interval){
      if(BOOL_AnimationSwitch)AnimIndex++;
    }
      //if(PosX != TargetX) PosX+= DX;
      //if(PosY != TargetY) PosY+= DY;
      image(GooAnim.AnimArray[RenderingAnimIndex][AnimIndex % (GooAnim.AnimArray[RenderingAnimIndex].length)], PosX + DisplacementX + SceneMgr.ScreenStartX, PosY + DisplacementY + SceneMgr.ScreenStartY, 90, 180);
      //if((AnimIndex % (AnimArray[RenderingAnimIndex].length) == 0) && (RenderingAnimIndex == WAVINGHAND))AnimTimes+= 1;
  }
  
  Goos(String Name, int UID)
  {
    super(Name, UID);
    GooAnim.loadAnimation();
    StandIndex= PathIndex= UID;
  }
}



class Rock extends Characters{  
  int WanderingTarget;
  PImage Texture= new PImage();
  
  void wandering()
  {
    int CubeIndex= StandIndex;
    int Directions[]= {0, 2, 3, 5};
    int Targetting= StandIndex, PreTargetting;
    int RandomDirection= Directions[(int)(random(0, 4
    ))];
      StandIndex= CubeIndex;
      for(;;){
        PreTargetting= Targetting;
        if((Targetting= CubesList[Targetting].UnitPath.Way[RandomDirection]) != UNCONNECTED){
          if(abs(CubesList[PreTargetting].getPosY() - CubesList[Targetting].getPosY()) >= BarrierHeight){
            Targetting= PreTargetting;
            break;
          }
        }else{ 
          Targetting= PreTargetting;
          break;
        }
      }
            WanderingTarget= Targetting;
            //CubeIndex= Targetting;
            findPathByCubeIndex(Targetting);
  }
   void walk()
   {
    int InBetween= 20;
      if(FrameCounter++ > InBetween){
          if(getWayPoint() == false){
                getWayPoint();
                //this.switchAnim(false);
            }else{
              if(this.StandIndex == this.PathIndex ){
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
  
  void drawSelf()
  {
   image(Texture, PosX + DisplacementX + SceneMgr.ScreenStartX, PosY + DisplacementY + SceneMgr.ScreenStartY);
  }
  
  void findPathByCubeIndex(int TargetIndex)
  {
    PathResult= CubePathFinder.findPathDijkstra(this.getStandingCubeIndex(), TargetIndex);
    if(PathResult != null){
      PathArray= PathResult.toArray();
      PathArrayIndex= 0;
      if(DEBUG_MODE){
        println(this.Name, " at: ", this.getStandingCubeIndex());
        println(PathResult);
      }
    }
  }
  
  void targetingGirl()
  {
    if(this.getStandingCubeIndex() == Girl.getStandingCubeIndex()){
      BOOL_GirlCaptured= true;
    }
    int GirlStandingIndex= Girl.getStandingCubeIndex();
    findPathByCubeIndex(GirlStandingIndex);
    if(PathResult != null){
      boolean BOOL_HaveClif= false;
      for(int i= 0; i < PathResult.size() - 1; i++){
        if(isClif(getStandingCubeIndex(), (int)PathResult.get(0))){
          BOOL_HaveClif= true;
        }
        if(isClif((int)PathResult.get(i), (int)PathResult.get(i + 1))){
          BOOL_HaveClif= true;
        }
      }
      if(BOOL_HaveClif){
          findPathByCubeIndex(getStandingCubeIndex());
          wandering();
          return;
      }
    }
    if(PathResult != null)
      PathArray= PathResult.toArray();
  }
  
  void walkPawn()
  {
    targetingGirl();
    walk();
    drawSelf();
  }
  
  void placeSelf(int CubeIndex)
  {
    this.PathIndex= this.StandIndex= CubeIndex;
  }
  
  Rock(String Name, int UID)
  {
    super(Name, UID);
    Texture= loadImage(ANIMATION_FRAM_PATH + "/chesspiece/" + "Rock.png");
    placeSelf(UID);
    DisplacementX= + CubesList[0].getSizeX() / 2;
    DisplacementY= - CubesList[0].getSizeY() / 3;
   //setStandingPoint(CubesList[0].getPosX(), CubesList[0].getPosY());
  }
}