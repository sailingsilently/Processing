/*********************************************************
*
*           Cells v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
class Info{
  int InfoChain[];
}

class Cells{
  final int DEAD= -1;
  public int IncomingInfo;
  private Info OutgoingInfo;
  private Info ReactionInfo;    
  private float StartX;
  private float StartY;
  private float UnitWidth;
  private float UnitHeight;
  int Color[]= {255, 255, 255};
  int MatrixPosX;
  int MatrixPosY;
  int SignalCount= 0;
  int State= 0;
  int IterationCount= 0;
   
  void resetSignal()
  {
   SignalCount= 0; 
  }
  
  void drawSelf()
  {
    fill(Color[0], Color[1], Color[2]);
    rect(
    StartX + MatrixPosX * UnitWidth, 
    StartY + MatrixPosY * UnitHeight, 
    UnitWidth, 
    UnitHeight);
    noFill();
  }
  
  int setPosX(int PosX)
  {
    return this.MatrixPosX= PosX;
  }
  
  void setLatX(int LatX)
  {
    MatrixPosX= LatX;
  }
    
  void setLatY(int LatY)
  {
    MatrixPosY= LatY;
  }
  
  int setPosY(int PosY)
  {
    return this.MatrixPosY= PosY;
  }
  
  int outputSignal()
  {
    if(IterationCount > 200)
      return -1;
    else if(IterationCount > 400){
      return 1;
    }else{
      return 0;
    }
  }
  
  boolean reciveSignal(int Signal)
  {
    if(++SignalCount >= 6)State= DEAD;
    if(Signal == 0){
      return false;
    }else{
      if(Signal == -1)this.dead();
      IncomingInfo= Signal;
      return true;
    }
  }
  
  void morphState(Info Signal)
  {
    SignalCount++;
    if(SignalCount >= 8)this.dead();
  }
  
  void react()
  {
    switch(SignalCount){
      case 0:
        reproduce(this);
        break;
      case 1:
      case 2:
        if(Lat.CellsMatrix[(MatrixPosX + 1) % Lat.LatticeXSum][(MatrixPosY + 1) % Lat.LatticeYSum] == null){
          Lat.CellsMatrix[(MatrixPosX + 1) % Lat.LatticeXSum][(MatrixPosY + 1) % Lat.LatticeYSum]= this;
          Lat.CellsMatrix[MatrixPosX ][MatrixPosY]= null;
          this.setLatX((MatrixPosX + 1) % Lat.LatticeXSum);
          this.setLatY((MatrixPosY + 1) % Lat.LatticeYSum);
        }
        //reproduce(this);
        break;
      case 3:
        dead();
        break;
      case 4:
        reproduce(this);
        break;
      case 5:
        dead();
        break;
      case 6:
        reproduce(this);
        break;
      case 7:
      case 8:
        dead();
        break;
    }
    resetSignal();
    IterationCount++;
  }
  
  Cells reproduce(Cells Matte)
  {
    Cells Child= new Cells(StartX, StartY, UnitWidth, UnitHeight);
    if(IterationCount > 10){
      Child.Color[0]= floor(255);
      Child.Color[1]= floor(128);
      Child.Color[2]= floor(128);
    }
    Child.setLatX(Matte.MatrixPosX);
    Child.setLatY(Matte.MatrixPosY);
    Lat.insertCells(Matte.MatrixPosX, Matte.MatrixPosY, Child);
    return Child;
  }
  
  void dead()
  {
    State= DEAD;
  }
  
  int getState()
  {
    return State;
  }
  

  
  Cells(float StartX, float StartY, float UnitWidth, float UnitHeight)
  {
    this.StartX= StartX;
    this.StartY= StartY;
    this.UnitWidth= UnitWidth;
    this.UnitHeight = UnitHeight;
  }
}