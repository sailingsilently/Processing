/*********************************************************
*
*               Collide Button v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved  
**********************************************************/
//When buttons are collided, they'll attach to each other.
//Although they can move, they should maintain their contacts.
//They can also change size, as long as they maintain contacts,
//and the other buttons which surrounded it should shrinking
// alongside with the shape shifted one.
//Although a log(n) time cost implemention is desired,
//Considering the limited implementing time, this problem
//should be solved in the simplest way. So the expected 
//performance probably within the time cost of n^2

//Should reimplemented this class with vector math

final int REMOVEITEM_MARK= -1;
final int NOT_REMOVEITEM_MARK= 0;
class CollideCircle{
  private int Index;
  
  public float ConstrainRadius= 330;
  public float ConstrainCenterX= width / 2;
  public float ConstrainCenterY= height / 2;
  public float vX= 0;
  public float vY= 0;
  public float PosX, PosY, Size= 30;
  public int Mark= 0;
  public int Removeable= 0;
  public int RL=10 , RH= 55;
  
  public float getVX()
  {
    return this.vX;
  }
  
  public float getVY()
  {
    return this.vY;
  }
  
  public float setVX(float vX)
  {
    return this.vX= vX;
  }
  
  public float setVY(float vY)
  {
    return this.vY= vY;
  }
  
  public void collide(CollideCircle CB)
  {
    float X, Y, cX, cY, R, cR;
    X= this.PosX;
    Y= this.PosY;
    cX= CB.PosX;
    cY= CB.PosY;
    R= this.Size / 2;
    cR= CB.Size / 2;
    //this.vX= CB.getVX();
    //this.vY= CB.getVY();
    //Collided, set to attach position
    if( pow(((cX + CB.getVX())- (X + this.vX)), 2) + pow(((cY + CB.getVY()) - (Y + this.vY)), 2) < pow((R + cR), 2)){
      //this.Mark= 1;
        CB.Mark= 1;
        if(this.Size > floor(RL + (RH - RL) / 2) - 4) this.Size-= 1;
        this.vX= CB.getVX();
        this.vY= CB.getVY();
        if(X >= cX){
          this.PosX= (cX + abs(sqrt((pow((R + cR), 2) - pow((cY - Y), 2)))));
        }else{
          this.PosX= (cX - abs(sqrt((pow((R + cR), 2) - pow((cY - Y), 2)))));
        }
        if(Y >= cY){
          this.PosY= (cY + abs(sqrt((pow((R + cR), 2) - pow((cX - X), 2)))));
        }else{
          this.PosY= (cY - abs(sqrt((pow((R + cR), 2) - pow((cX - X), 2)))));
        }
    }else{
      //this.Mark= 0;
      this.PosX+= this.vX;
      this.PosY+= this.vY;
    }
    //Constrain
    if(this.Size / 2 + sqrt(pow((this.PosY - this.ConstrainCenterY), 2) + pow(this.PosX - this.ConstrainCenterX, 2)) >= this.ConstrainRadius){
      float s=  (R + cR) - sqrt(pow(((cX + CB.getVX())- (X + this.vX)), 2) + pow(((cY + CB.getVY()) - (Y + this.vY)), 2));
       //if(this.Size - s > RL) this.Size-= s;else this.Size= RL;
      //this.Size= (this.Size - 1) > 0? this.Size - 1 : this.Size;
      this.vX= this.vY= 0;
      float AT= atan( this.PosY / this.PosX);
      float LN= (this.ConstrainRadius - this.Size / 2);
      if(PosX >= this.ConstrainCenterX)
        this.PosX= random((sin(AT) * LN)) + this.ConstrainCenterX;
      else
        this.PosX= -(random(sin(AT) * LN)) + this.ConstrainCenterX;
      if(PosY >= this.ConstrainCenterY)
        this.PosY= random((cos(AT) * LN)) + this.ConstrainCenterY;
      else
        this.PosY= -random((cos(AT) * LN)) + this.ConstrainCenterY;
      collideManyWithGrowth(random(RL, RH), CircleSet);
    }
  }
  
  public void collideMany(CollideCircle T, List<CollideCircle> CircleList)
  {
    int ListSize= CircleList.size();
    for(int i= 0; i < ListSize; i++){
      //if(CircleList.get(i).Mark != 0) continue;
      if(this.Index == i)continue;
      this.collide(CircleList.get(i));
    }
  }
  
  public void collideManyWithGrowth(float NewSize, List<CollideCircle> CircleList)
  {
    int ListSize= CircleList.size();
    for(int i= 0; i < ListSize; i++){
      if(this.Index == i)continue;
      CollideCircle CB= CircleList.get(i);
      float X, Y, cX, cY, R, cR, SizeChange;
      X= this.PosX;
      Y= this.PosY;
      cX= CB.PosX;
      cY= CB.PosY;
      SizeChange= (NewSize - this.Size) / 2;
      this.Size= NewSize;      
      CB.Size-= SizeChange;
      CB.Size= (CB.Size >= RL) ? CB.Size : RL;
      if(CB.Size <= 0) CB.Size= 10;
      if(CB.Size > 90) CB.Size= 90;
      R= this.Size / 2;
      cR= CB.Size / 2;
      //this.vX= this.getVX();
      //this.vY= this.getVY();

      //Collided, set to attach position
     if( pow(((cX + CB.getVX())- (X + this.vX)), 2) + pow(((cY + CB.getVY()) - (Y + this.vY)), 2) < pow((R + cR), 2)){
       float s=  (R + cR) - sqrt(pow(((cX + CB.getVX())- (X + this.vX)), 2) + pow(((cY + CB.getVY()) - (Y + this.vY)), 2));
       //if(CB.Size - s > RL) CB.Size-= s;else 
        //this.Mark= 1;
        CB.Mark= 1;
        this.vX= CB.getVX();
        this.vY= CB.getVY();
        if(X >= cX){
          this.PosX= (cX + abs(sqrt((pow((R + cR), 2) - pow((cY - Y), 2)))));
        }else{
          this.PosX= (cX - abs(sqrt((pow((R + cR), 2) - pow((cY - Y), 2)))));
        }
        if(Y >= cY){
          this.PosY= (cY + abs(sqrt((pow((R + cR), 2) - pow((cX - X), 2)))));
        }else{
          this.PosY= (cY - abs(sqrt((pow((R + cR), 2) - pow((cX - X), 2)))));
        }
        continue;
      }
      
      //this.Mark= 0;
      this.PosX+= this.vX;
      this.PosY+= this.vY;
    }
    
    if(this.Size / 2 + sqrt(pow((this.PosY - this.ConstrainCenterY), 2) + pow(this.PosX - this.ConstrainCenterX, 2)) >= this.ConstrainRadius){
      //this.Size= (this.Size - 1) > 0? this.Size - 1 : this.Size;
      this.vX= this.vY= 0;
      float AT= atan( this.PosY / this.PosX);
      float LN= (this.ConstrainRadius - this.Size / 2);
      if(PosX >= this.ConstrainCenterX)
        this.PosX= random((sin(AT) * LN)) + this.ConstrainCenterX;
      else
        this.PosX= -(random(sin(AT) * LN)) + this.ConstrainCenterX;
      if(PosY >= this.ConstrainCenterY)
        this.PosY= random((cos(AT) * LN)) + this.ConstrainCenterY;
      else
        this.PosY= -(random(cos(AT) * LN)) + this.ConstrainCenterY;
      collideManyWithGrowth(random(RL, RH), CircleSet);
    }
  }
  
  public void drawCollideCircle(int Alpha)
  {
    stroke(128, 128, 128, 90);
    strokeWeight(1);
    fill( SceneMgr.AbstractArtworks[0].pixels[(floor(SceneMgr.AbstractArtworks[0].width * (PosY % SceneMgr.AbstractArtworks[0].height - 1) + PosX % SceneMgr.AbstractArtworks[0].width)) % SceneMgr.AbstractArtworks[0].pixels.length], Alpha);
    ellipse(PosX, PosY, Size, Size);
  }

  
  public CollideCircle(int Index, float Size)//, float ConstrainCenterX, float ConstrainCenterY, float ConstrainRadius)
  {
    this.Index= Index;
    this.Size= Size;
    //this.ConstrainCenterX= ConstrainCenterX;
    //this.ConstrainCenterY= ConstrainCenterY;
    //this.ConstrainRadius= ConstrainRadius;
  }
}

boolean isAllMarked(List<CollideCircle> CircleList)
{
    int ListSize= CircleList.size();
    for(int i= 0; i < ListSize; i++){
      if(CircleList.get(i).Mark == 0) return false;
    }
    return true;
}

boolean isAllCleared(List<CollideCircle> CircleList)
{
    int ListSize= CircleList.size();
    for(int i= 0; i < ListSize; i++){
      if(CircleList.get(i).Mark != 0) return false;
    }
    return true;
}

void clearMark(List<CollideCircle> CircleList)
{
    int ListSize= CircleList.size();
    for(int i= 0; i < ListSize; i++){
      CircleList.get(i).Mark= 0;
      
    }
}

public List<CollideCircle> helper_getOverLappedItem(List<CollideCircle> CircleList)
{
   int i= 0, ii= 0;
    for (i= 0; i < CircleList.size(); i++){
      CircleList.get(i).Removeable= NOT_REMOVEITEM_MARK;
    }
    for (i= 0; i < CircleList.size(); i++){
          CollideCircle SF= CircleList.get(i);
          if(SF.Removeable == REMOVEITEM_MARK) continue;
      for(int idx= 0; (i < CircleList.size()) && (idx < CircleList.size()); idx++){
          CollideCircle CB= CircleList.get(idx);  
        if((i == idx)
            || (CB.Removeable == REMOVEITEM_MARK)) continue;
          if( abs(pow(((CB.PosX)- (SF.PosX)), 2) + pow(((CB.PosY) - (SF.PosY)), 2)) < abs(pow((SF.Size / 2 + CB.Size / 2), 2))){
              CB.Removeable= REMOVEITEM_MARK;
          }
      }
    }
    return CircleList;
}



public List<CollideCircle> removeOverlappedItem(List<CollideCircle> CircleList)
  {
    float sizemofis[]= {1.01, 1.02, 1.05, 1.09, 1.1, 1.2, 1.3, 1.5, 2.0, 2.2, 2.5};
    int i= 0, ii= 0;
    List<CollideCircle> Q= CircleList;
    CircleList= helper_getOverLappedItem(CircleList);
    for(int a= 0; a < sizemofis.length; a++){
      for (i= 0, ii= 0; ii < CircleList.size(); ii++){
        if(CircleList.get(ii).Removeable == REMOVEITEM_MARK){
          CircleList.get(ii).Size= (CircleList.get(ii).Size / 2 > CircleList.get(ii).RL) ? CircleList.get(ii).Size / sizemofis[a] : CircleList.get(ii).RL;
          CircleList.get(ii).collideMany(CircleList.get(ii), Q);
        }
      }
      CircleList= helper_getOverLappedItem(CircleList);
    }
    for (i= 0, ii= 0; ii < CircleList.size(); ii++){
      if(CircleList.get(ii).Removeable == NOT_REMOVEITEM_MARK){
        CircleList.set(i++, CircleList.get(ii));
      }
    }
    return CircleList.subList(0, i);
  }