/*********************************************************
*
*           Matrix v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
import java.util.*;

class Lattice{
  float PosX= 0;
  float PosY= 0;
  float LWidth= ScreenSizeX - PosX;
  float LHeight= ScreenSizeY;
  
  int LatticeXSum= 128;
  int LatticeYSum= 128;
  
  float UnitWidth= LWidth / LatticeXSum;
  float UnitHeight= LHeight / LatticeYSum;
  LinkedList CellsList;
  
  public Cells CellsMatrix[][]= new Cells[LatticeXSum][LatticeYSum];
  
  public float getStartX()
  {
    return PosX;
  }
  
  public float getStartY()
  {
    return PosY;
  }

  public float getUnitWidth()
  {
    return UnitWidth;
  }
  
  public float getUnitHeight()
  {
    return UnitHeight;
  }
  
  void drawSelf()
  {
    for(int LatX= 0; LatX < LatticeXSum; LatX++){
      for(int LatY= 0; LatY < LatticeYSum; LatY++){
        if(CellsMatrix[LatX][LatY] != null){
          CellsMatrix[LatX][LatY].drawSelf();
        }
      }
    }
    noFill();
    strokeWeight(1);
    stroke(50);
    for(int LatX= 0; LatX < LatticeXSum; LatX++){
        line(PosX + UnitWidth * LatX, PosY, PosX + UnitWidth * LatX, PosY + LHeight);
    }
    for(int LatY= 0; LatY < LatticeYSum; LatY++){
        line(PosX, PosY + UnitWidth * LatY, LWidth + PosX, PosY + UnitWidth * LatY);
    }
  }
  
  
  public boolean insertCells(int LatX, int LatY, Cells Cell)
  {
    int Pos= 0;
    Pos= floor(random(0, 4));
       if(CellsMatrix[LatX][LatY] != null){
        switch(Pos){
          case 0:
           for(int i= LatX; i < LatticeXSum; i++){
             if(CellsMatrix[i][LatY] == null){
               for(; i > LatX; i--){
                 CellsMatrix[i][LatY]= CellsMatrix[i - 1][LatY];
                 CellsMatrix[i - 1][LatY]= null;
               }
               CellsMatrix[LatX][LatY]= Cell;
               return true;
             }
           }
         case 1:
           for(int i= LatX; i >= 0; i--){
             if(CellsMatrix[i][LatY] == null){
               for(int idx= i; idx < LatX - 1; idx++){
                 CellsMatrix[idx][LatY]= CellsMatrix[idx + 1][LatY];
                 CellsMatrix[idx + 1][LatY]= null;
               }
               CellsMatrix[LatX][LatY]= Cell;
               return true;
             }
           }
        case 2: 
         for(int i= LatY; i < LatticeYSum; i++){
           if(CellsMatrix[LatX][i] == null){
             for(; i > LatY; i--){
               CellsMatrix[LatX][i]= CellsMatrix[LatX][i - 1];
               CellsMatrix[LatX][i - 1]= null;
             }
             CellsMatrix[LatX][LatY]= Cell;
             return true;
           }
         }
        case 3: 
         for(int i= LatY; i >= 0; i--){
           if(CellsMatrix[LatX][i] == null){
             for(; i < LatY; i++){
               CellsMatrix[LatX][i]= CellsMatrix[LatX][i + 1];
               CellsMatrix[LatX][i + 1]= null;
             }
             CellsMatrix[LatX][LatY]= Cell;
             return true;
           }
         }
       }
     }else{
       CellsMatrix[LatX][LatY]= Cell;
       return true;
     }
     return false;
  }
  
  
  public boolean evalCells(int LatX, int LatY)
  {
    Cells TargettingCel= CellsMatrix[LatX][LatY];
    if(TargettingCel == null){
      return false;
    }
    TargettingCel.setLatX(LatX);
    TargettingCel.setLatY(LatY);
    int Pos[][]= {
      {(LatX - 1), (LatY - 1)},
      {(LatX - 1), (LatY + 1)},
      {(LatX + 1), (LatY -1)},
      {(LatX + 1), (LatY + 1)},
      {(LatX), (LatY - 1)},
      {(LatX), (LatY + 1)},
      {(LatX - 1), (LatY)},
      {(LatX + 1), (LatY)}
    };
    for(int i= 0; i < Pos.length; i++){
      int X= (Pos[i][0] % LatticeXSum >= 0)? Pos[i][0] % LatticeYSum : Pos[i][0] % LatticeYSum + LatticeXSum;
      int Y= (Pos[i][1] % LatticeYSum >= 0)? Pos[i][1] % LatticeYSum : Pos[i][1] % LatticeYSum + LatticeYSum;
      //println(X, Y);
      Cells Cel= CellsMatrix[X][Y];
      if(Cel == null) continue;
      TargettingCel.reciveSignal(Cel.outputSignal());
      if(TargettingCel.getState() == TargettingCel.DEAD){
        CellsMatrix[LatX][LatY]= null;
      }
    }
    TargettingCel.react();
    return true;
  }
  
  public void evalAll()
  {
    for(int LatX= 0; LatX < LatticeXSum; LatX++){
      for(int LatY= 0; LatY < LatticeYSum; LatY++){
        evalCells(LatX, LatY);
      }
    }
    return; 
  }
  
  Lattice()
  {
    for(int i= 0; i < LatticeXSum; i++){
      for(int idx= 0; idx < LatticeYSum; idx++){
         //CellsMatrix[i][idx]= new Cells();
         CellsMatrix[i][idx]= null;
      }
    }
  }
  
}