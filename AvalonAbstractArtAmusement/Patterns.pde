/*********************************************************
*
*           Patterns v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/



class Wave{
  float StartX= 0.0, EndX= width;
  int WaveElementSum= 1000;
  float WaveElementSize= 10;
  float RelationRatio= 0.1;
  float MoveLimit= 20;
  float HorizonY;
  float Unit= TWO_PI / ((EndX - StartX) / 16);
  float Track= 0.0;
  float Amp= 45.0;
  
  public void popWave(int WaveElementIndex, float Speed)
  {
    
  }
  
  public void pushWave(int WaveElementIndex, float PushDistance, float Speed)
  {

  }
  
  public void drawWave(float PosX, float PosY, int OscCount, int Length, float DampAmount, float Amp)
  {
    noStroke();
    int i;
    float Track=  0.0;
    int HalfLength= Length / 2;
    float Damp= 1.0;
    float Unit= (TWO_PI * OscCount ) / Length;
    for(i= HalfLength, Track= (HalfLength) * Unit, Damp= 1.0 - DampAmount; i >= 0 ; i-= 1){
      noStroke();
      ellipse(PosX + i, PosY + cos(Track) * Amp * Damp, WaveElementSize, WaveElementSize);
      stroke(255);
      strokeWeight(1);
      line(PosX + i, PosY + cos(Track) * Amp * Damp, PosX + i, height);
      Track-= Unit;
      Damp= (Damp-= DampAmount) >= 0? Damp : 0;
    } 
    for(i= HalfLength + 1, Track= (HalfLength + 1) * Unit, Damp= 1.0 - DampAmount; i < Length ; i+= 1){      
      noStroke();
      ellipse(PosX + i, PosY + cos(Track) * Amp * Damp, WaveElementSize, WaveElementSize);      
      stroke(255);
      strokeWeight(1);
      line(PosX + i, PosY + cos(Track) * Amp * Damp, PosX + i, height);
      Track+= Unit;
      Damp= (Damp-= DampAmount) >= 0? Damp : 0;
    }  
  }
  
   public Wave(float Y){
    this.HorizonY= Y;
   }
}


/***********************************************************************************************************************
class WaveElement{
  float PosX;
  float PosY;
}

class Wave{
  float StartX, StartY, EndX, EndY;
  int WaveElementSum= 1000;
  float WaveElementSize= 2;
  float RelationRatio= 0.1;
  float MoveLimit= 20;
  float MidY;
  WaveElement WaveList[]= new WaveElement[WaveElementSum];
  
  public void popWave(int WaveElementIndex, float Speed)
  {
    float PopDistance= (MidY - WaveList[WaveElementIndex].PosY) * (1 - RelationRatio) 
    + (MidY - (MidY - WaveList[WaveElementIndex].PosY));
    
   pushWave(WaveElementIndex, -PopDistance, Speed);
  }
  
  public void pushWave(int WaveElementIndex, float PushDistance, float Speed)
  {
    if((WaveElementIndex >= WaveElementSum) || (WaveElementIndex < 0)) return;
    for(float a= 0; a < PushDistance; a+= Speed){
      if (a > PushDistance) a= PushDistance;
      WaveList[WaveElementIndex].PosY= WaveList[WaveElementIndex].PosY - a;
      for(int i= WaveElementIndex; i > 1; i--){
        WaveList[i - 1].PosY= WaveList[i - 1].PosY - (WaveList[i - 1].PosY - WaveList[i].PosY) * (1 - RelationRatio);
      } 
      for(int i= WaveElementIndex; i < WaveElementSum - 1; i++){
        WaveList[i + 1].PosY= WaveList[i + 1].PosY - (WaveList[i + 1].PosY - WaveList[i].PosY) * (1 - RelationRatio);
      }
      drawWave();
    }
  }
  
  public void drawWave()
  {
    fill(255);
    stroke(255);
    for(int i= 1; i < WaveElementSum; i++){
      println(WaveList[i].PosX, WaveList[i].PosY, WaveList[i - 1].PosX, WaveList[i - 1].PosX);
      line(WaveList[i].PosX, WaveList[i].PosY, WaveList[i - 1].PosX, WaveList[i - 1].PosY);
    }
  }
  
   public Wave(float HorizenY){
     for(int i= 0; i < WaveElementSum; i++){
       WaveList[i]= new WaveElement();
       WaveList[i].PosX= i * WaveElementSize;
       WaveList[i].PosY= HorizenY;
       MidY= HorizenY;
     }
   }
}
************************************************************************************************************************/