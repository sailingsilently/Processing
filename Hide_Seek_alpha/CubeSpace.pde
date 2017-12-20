/**********************************************************
*           Cube Land v0.11a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
import java.io.*;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;
final String SaveCubeFileName= GAME_MAP_PATH + "1.map";
InputStream FIn;
OutputStream FOut;
ObjectInputStream OIS;
ObjectOutputStream OOS;
Cubes CubesList[]= new Cubes[CUBES_SUM];
int SelectedCubeindex= -1;
int PointedCubeIndex= -1;
Cubes SortedCubesList[]= new Cubes[CUBES_SUM];
LinkedList OpenList= new LinkedList();
LinkedList CloseList= new LinkedList();

  PImage CubeUnattachedMap= new PImage();
  PImage CubeAttachedmapOther= new PImage();
  PImage CubeAttachedMap= new PImage();
  PImage CubeAttachedTargetMap= new PImage();

/*
class CubePoint{
  p
PathList[]= new Path[CUBES_SUM];ublic int X;
  public int Y;
  int Angle;
  int dx;
  int dy;
  int CubeWidth;
  
  void computeLocation(int CenterX, int CenterY)
  {
    X= CenterX + dx;
    Y= CenterY + dy;
  }
  
  CubePoint(int Angle, int CenterX, int CenterY, int CubeWidth)
  {
    this.Angle= Angle;
    dx= floor(tan(radians(this.Angle)) * (CubeWidth / 2));
    dy= floor(tan(radians(this.Angle)) * (CubeWidth / 2));
  }
}
*/   

class Cubes extends Button{
  final int NONE= -1;
  Cubes N= null, S= null, W= null, E= null, U= null, D= null;  
  final int PathSum= 6;
  String DetectOrder[]= {"N", "S", "W", "E", "U", "D"};
  float TargetCubePoint[][]= new float[6][2];
  int Width;
  int Height;
  int TriggerRadius= CubeUnattachedMap.width / 5;
  int MagneticRadius= CubeUnattachedMap.width / 8;
  boolean BOOL_Selected= false;
  int LayerSum= 400;
  int LayerIndexMiddle= LayerSum / 2;
  int LayerIndex= LayerIndexMiddle;
  int TileType= 0;
  boolean TileMark= false;
  boolean BOOL_Dragable= true;
  
  Path UnitPath= new Path();
  
/*  
  CubePoint F30;
  CubePoint F150;
  CubePoint F270;  
  CubePoint B90;  
  CubePoint B210;
  CubePoint B330;
*/  
  float F30[]= {0, 0};
  float F150[]= {0, 0};
  float F270[]= {0, 0};  
  float B90[]= {0, 0};  
  float B210[]= {0, 0};
  float B330[]= {0, 0};

  int TestRadius= CubeUnattachedMap.width * 2;
  int FoundCubes[]= new int[6];
  int Target= NONE;
 /* 
  int getSizeX()
  {
    return CubeUnattachedMap.width;
  }  
  
  int getSizeY()
  {
    return CubeUnattachedMap.height;
  }
  */
  
  float getPosX()
  {
    return PosX;
  }
  
  float getPosY()
  {
    return PosY;
  }
  float setPosX(int PosX)
  {
    this.PosX= PosX;
    return this.PosX;
  }
  
  float setPosY(int PosY)
  {
    this.PosY= PosY;
    return this.PosY;
  }
  
  public void setLayerIndex(int LayerIndex)
  {
    this.LayerIndex= LayerIndex;
  }
  
  public int getLayerIndex()
  {
    return LayerIndex;
  }
  
  public int getHeight()
  {
    return this.Height;
  }
  
  private void helper_clearDetectedList()
  {
    for(int i= 0; i < FoundCubes.length; i++)
      FoundCubes[i]= NONE;
  }
  
  private void helper_updatePointLoaction()
  {
    float Degree= 30.0;
    float u= Height / 2,
          v= (tan(radians(Degree)) * Width / 2),  
          w= (tan(radians(Degree)) * Width / 2);  
    float PosX= this.getPosX() + CubeUnattachedMap.width / 2;
    float PosY= this.getPosY() + CubeUnattachedMap.height / 2;
    TargetCubePoint[0][0]= F30[0]= PosX + Width / 2;
    TargetCubePoint[0][1]= F30[1]= PosY - v;
    TargetCubePoint[1][0]= F270[0]= PosX;
    TargetCubePoint[1][1]= F270[1]= PosY + u; 
    TargetCubePoint[2][0]= F150[0]= PosX - Width / 2;
    TargetCubePoint[2][1]= F150[1]= PosY - v; 
    TargetCubePoint[3][0]= B210[0]= PosX - Width / 2;
    TargetCubePoint[3][1]= B210[1]= PosY + v;
    TargetCubePoint[4][0]= B90[0]= PosX;
    TargetCubePoint[4][1]= B90[1]= PosY - u;   
    TargetCubePoint[5][0]= B330[0]= PosX + Width / 2;
    TargetCubePoint[5][1]= B330[1]= PosY + v;
  }

  /*
  void RayDetect()
  {
    float ImgX, ImgY, sx, sy;
    for(int w= 0; w < TargetCubePoint.length; w++){
      for(int i= 0; i < CubesList.length; i++){
          ImgX= TargetCubePoint[w][0] - (CubesList[i].getPosX());
          ImgY= TargetCubePoint[w][1] - (CubesList[i].getPosY());
          sx= CubesList[i].getSizeX();
          sy= CubesList[i].getSizeY();
          if((ImgX < 0.0) || (ImgY < 0.0) || (ImgX >= sx) || (ImgY >= sy)){
            FoundCubes[w]= NONE;
            continue;
          }
          if(alpha(this.CubeUnattachedMap.pixels[int(sx * ImgY + ImgX)]) != 0){
            FoundCubes[w]= i;
          }else{
            FoundCubes[w]= NONE;
            continue;
          }
      }
    }
  }
*/

  private void hightlightTriggeredCubes()
  {
    for(int i= 0; i < FoundCubes.length; i++){
            
    }
  }
  
  private void attachPath(int CubeIndex, int AttachPoint)  
  {
   this.UnitPath.attachPath(PathList[SortedCubesList[CubeIndex].getUID()], AttachPoint);
   //SortedCubesList[CubeIndex].UnitPath.attachPath(PathList[this.getUID()], this.UnitPath.helper_computeAttachedPoint(AttachPoint));
  }
  
  
  private void attachCubes(int CubeIndex, int AttachPoint)  
  {
   //if(this.UnitPath.isConnected()== true)return;
    float PX, PY;
    BOOL_Pressed= false;
   PX= (SortedCubesList[CubeIndex].PosX + CubeUnattachedMap.width / 2 - TargetCubePoint[AttachPoint][0]);
   PY= (SortedCubesList[CubeIndex].PosY + CubeUnattachedMap.height / 2 - TargetCubePoint[AttachPoint][1]);
   this.PosX+= PX;
   this.PosY+= PY;
   this.UnitPath.setPosition(this.PosX, this.PosY);
  }  
  
  public void draggCube(int PosX, int PosY)
  {
    if((Girl.getStandingCubeIndex() == this.getUID())
        || (PurRock01.getStandingCubeIndex() == this.getUID())
        || (PurRock02.getStandingCubeIndex() == this.getUID())
        || (PurRock03.getStandingCubeIndex() == this.getUID())
        || (PurRock04.getStandingCubeIndex() == this.getUID())
        ||(Girl.getStandingCubeIndex() == this.getUID())
        || (PurRock01.getPathIndex() == this.getUID())
        || (PurRock02.getPathIndex() == this.getUID())
        || (PurRock03.getPathIndex() == this.getUID())
        || (PurRock04.getPathIndex() == this.getUID())){
          return;
        }
    isMouseOver();
    if(SelectedCubeindex == -1)SelectedCubeindex= getUID();
    if(SelectedCubeindex != getUID())return;
    if(BOOL_Dragable == false)return;
    if(this.UnitPath.isConnected() == true){
        this.PosX= PosX - CubeUnattachedMap.width / 2;
        this.PosY= PosY - CubeUnattachedMap.height / 2;
    }else{
      this.PosX= PosX - CubeUnattachedMap.width / 2;
      this.PosY= PosY - CubeUnattachedMap.height / 2;
    }
      this.UnitPath.setPosition(this.PosX, this.PosY);
      helper_updatePointLoaction();
      magOthers();
  }
  
  public void magOthers()
  {
    float RX, RY, sx, sy;
        for(int index= 0; index < FoundCubes.length; index++){
          FoundCubes[index]= -1;
        }
    boolean BOOL_Attaching= false;
    int AttachList[]= new int[PathSum];
    int AttachIndex= 0;
    int LayerUnit= 1;
     for(int w= PathSum - 1; w >= 0 ; w--){
      for(int i= SortedCubesList.length - 1; i >= 0; i--){  
        if(SortedCubesList[i].getUID() == this.getUID()) continue;
          RX= abs(TargetCubePoint[w][0] - (SortedCubesList[i].getPosX() + CubeUnattachedMap.width / 2));
          RY= abs(TargetCubePoint[w][1] - (SortedCubesList[i].getPosY() + CubeUnattachedMap.height / 2));
          
          if((RX <= TriggerRadius) && (RY <= TriggerRadius)){
             if(w >= 3){
                 if(this.LayerIndex < LayerSum)this.LayerIndex= SortedCubesList[i].LayerIndex - LayerUnit;
             }else{
               if(this.LayerIndex > 0)this.LayerIndex=  SortedCubesList[i].LayerIndex + LayerUnit;
             }
            if((RX <= MagneticRadius) && (RY <= MagneticRadius)){
              int W, Q= SortedCubesList[i].UnitPath.Way[SortedCubesList[i].UnitPath.helper_computeAttachedPoint(w)];
              if(Q != UNCONNECTED){
                if(Q == this.UnitPath.PathIndex){
                  if(BOOL_Attaching == false){
                    attachCubes(i, w);
                  }
                  BOOL_Attaching= true;
                } 
                continue;
              }
              if(BOOL_Attaching == false){
                attachCubes(i, w);
              }
              if(this.UnitPath.Way[w] == UNCONNECTED){
                attachPath(i, w);
              }
              BOOL_Attaching= true;
              FoundCubes[w]= i;
              continue;
            }
          }
          if(BOOL_Attaching)continue;
      }
    }
    if(BOOL_Attaching == false){
      //println("Path Node Detached at NO.", UnitPath.PathIndex);
      UnitPath.detachPath();
      this.LayerIndex= LayerIndexMiddle;
    }else{
      UnitPath.BOOL_Connected= true;
    }
    differeingCubesMap(Girl.getStandingCubeIndex());
  }
 
  public boolean isMouseOver()
  {
    //if(SelectedCubeindex == -1)SelectedCubeindex= getUID(); 
    //if((SelectedCubeindex != getUID()) && (SelectedCubeindex != -1))return false;
    float ImgX, ImgY, sx, sy;
    ImgX= SceneMgr.getMouseX() - (this.getPosX());
    ImgY= SceneMgr.getMouseY() - (this.getPosY());
    sx= this.getSizeX();
    sy= this.getSizeY();
    if((ImgX < 0.0) || (ImgY < 0.0) || (ImgX >= sx) || (ImgY >= sy)){
      return false;
    }
    if(alpha(this.ButtonTexture.pixels[int(sx * ImgY + ImgX) % this.ButtonTexture.pixels.length]) != 0){
      if(isVisiable())cursor(HAND);
      PointedCubeIndex= this.getUID();
      //println("Selected Cube: ", getUID());
      //differeingCubesMap();
      return true;
    }else{
      cursor(ARROW);
      return false;
    }
  }
  
  public boolean isConnected()
  {
    for(int i= 0; i < PathSum; i++){
      if(this.UnitPath.Way[i] != UNCONNECTED) return true;
    }
    return false;
  }
  
  protected void drawSelf()
  {
    if(isConnected()){
      if(TempTargetCube == this.getUID()){
        image(CubeAttachedTargetMap, 
              this.getPosX() + SceneMgr.ScreenStartX, 
              this.getPosY() + SceneMgr.ScreenStartY);
      }else if(this.TileType == 0){
        image(CubeAttachedMap, 
              this.getPosX() + SceneMgr.ScreenStartX, 
              this.getPosY() + SceneMgr.ScreenStartY);
      }else{
        image(CubeAttachedmapOther, 
              this.getPosX() + SceneMgr.ScreenStartX, 
              this.getPosY() + SceneMgr.ScreenStartY);
      }
    }else{
      image(ButtonTexture, 
            this.getPosX() + SceneMgr.ScreenStartX, 
            this.getPosY() + SceneMgr.ScreenStartY);
    }
  }
   
  
  public int onActive()
   {
     //this.Handlerins.callback(this.getUID());
     return 0;
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
  
  public boolean mouseOver()
  {
    if(DEBUG_MODE){
      println("Mouse Over Cube: ", this.getUID());
    }
    if(BOOL_MouseOver == false){
      TintColor[0]= TintColor[1]= TintColor[2]= 150;
      BOOL_MouseOver= true;
    }
    if((TintColor[0] <= HighTone) || (TintColor[0] <= HighTone) || (TintColor[0] <= HighTone)){
      helper_tintButton(0, TintSpeed);
      helper_tintButton(1, TintSpeed * RedYellowRatio);
      drawSelf();
      noTint();
    }else{
      tint(TintColor[0], TintColor[1], TintColor[2]);
      drawSelf();
      noTint();
    }
    return true;
  }
  
  public void update()
  {
      if(((PointedCubeIndex != -1) && (this.getUID() == PointedCubeIndex))
        || ((SelectedCubeindex != -1) && isMouseOver())){
          this.mouseOver();
        if(isPressed()){
          onActive();
          if(mouseButton == RIGHT){
            draggCube((int)SceneMgr.getMouseX(), (int)SceneMgr.getMouseY());
          }
        }else{
          releaseCube();
        }
      }else{
        this.mouseLeave();
      }
  } 
  
  Cubes(int UID, String CubeName, String DefaultTexture, String AttachedTexture, String AtachedTextureOther, String Help, int InitX, int InitY)
  {
    super(UID, CubeName, DefaultTexture, Help, InitX, InitY);
    helper_updatePointLoaction();
    Width= CubeUnattachedMap.width;
    Height= CubeUnattachedMap.height;
    CubesList[UID]= this;
    UnitPath.setUnitLength(Width / 2);
    UnitPath.setPathIdx(UID);
    this.UnitPath.setPosition(this.PosX, this.PosY);
  }
  
}


void sortCubesList()
{  
  int MINL= CubesList[0].LayerIndex; 
  int MAXL= CubesList[CubesList.length - 1].LayerIndex;
  
  for(int i= 1; i < CubesList.length; i++){
    if(CubesList[i].LayerIndex < MINL)MINL= CubesList[i].LayerIndex;
    if(CubesList[i].LayerIndex > MAXL)MAXL= CubesList[i].LayerIndex;
  }
   for(int i= MINL, index= 0; i <= MAXL; i++){
     for(int idx= CubesList.length - 1; idx >= 0; idx--){
       if(CubesList[idx].LayerIndex == i)SortedCubesList[index++]= CubesList[idx];
     }
   }
}

void buildCubeSpace()
{
    CubeUnattachedMap= loadImage(IMAGE_PATH + "cube_bear.png");
    CubeAttachedMap= loadImage(IMAGE_PATH + "cube_attached.png");
    CubeAttachedmapOther= loadImage(IMAGE_PATH + "cube_attached_other.png");
    CubeAttachedTargetMap= loadImage(IMAGE_PATH + "cube_attached_target.png");
  for(int i= 0; i < CUBES_SUM; i++){
    Cubes cube= new Cubes(
                      i, 
                      "", 
                      IMAGE_PATH + "cube_bear.png", 
                      IMAGE_PATH + "cube_attached.png", 
                      IMAGE_PATH + "cube_attached_other.png", 
                      "", 
                      i * 30, 
                      -1000);
    CubesList[i]= cube;
    PathList[i]= cube.UnitPath;
  }
}


void refreshCubes()
 {
    PointedCubeIndex= -1;
    sortCubesList();
     for(int idx= SortedCubesList.length - 1; idx >= 0; idx--){ 
        if(SortedCubesList[idx].isMouseOver()){
          break;
        }
     }
     for(int idx= 0; idx < SortedCubesList.length; idx++){ 
        SortedCubesList[idx].update();
        SortedCubesList[idx].show();
    }
 if(DEBUG_MODE == true){   
  for(int i= 0; i < PathList.length; i++){
    Path Q= PathList[i];
      for(int idx= 0; idx < Q.Way.length; idx++){
      stroke(255, 128, 30);
      if(Q.Way[idx] != UNCONNECTED){
        Cubes W= CubesList[Q.Way[idx]];
        float R= CubesList[Q.PathIndex].Width / 2;
        float T= CubesList[Q.PathIndex].Height / 2;
        line(CubesList[Q.PathIndex].getPosX() + SceneMgr.ScreenStartX + R, CubesList[Q.PathIndex].getPosY() + SceneMgr.ScreenStartY + T, W.getPosX() + SceneMgr.ScreenStartX + R, W.getPosY() + SceneMgr.ScreenStartY + T);
      }
    }
  }
 }
}

void releaseCube()
{
  SelectedCubeindex= -1;
}
  
public int helper_computeAttachedPoint(int SelfPoint)
{
  switch(SelfPoint){
    case 0:
    case 1:
    case 2:
      return abs(SelfPoint + 3) % 6;
    default:
      return abs(SelfPoint - 3) % 6;
  }
}

void removeRedundantEdge(int CubeIndex)
  {
    int LowerEdge[]= {0, 1, 2};
    int UpperEdge[]= {3, 4, 5};
    int LowerCube;
    int UpperCube;
    Cubes Cube= CubesList[CubeIndex];
    for(int i= 0; i < LowerEdge.length; i++){
      if(Cube.UnitPath.Way[LowerEdge[i]] != UNCONNECTED){
        LowerCube= Cube.UnitPath.Way[LowerEdge[i]];
        if(Cube.LayerIndex < CubesList[LowerCube].LayerIndex){
          CubesList[LowerCube].UnitPath.Way[helper_computeAttachedPoint(i)]= UNCONNECTED;
          Cube.UnitPath.Way[LowerEdge[i]]= UNCONNECTED;
        }
      }
    }
    for(int i= 0; i < UpperEdge.length; i++){
      if(Cube.UnitPath.Way[UpperEdge[i]] != UNCONNECTED){
        UpperCube= Cube.UnitPath.Way[UpperEdge[i]];      
        if(Cube.LayerIndex > CubesList[UpperCube].LayerIndex){
          CubesList[UpperCube].UnitPath.Way[helper_computeAttachedPoint(i)]= UNCONNECTED;
          Cube.UnitPath.Way[UpperEdge[i]]= UNCONNECTED;
        }
      }
    }
  }

void saveGameMap()
{
  try{
    FOut= createOutput(SaveCubeFileName);
    OOS= new ObjectOutputStream(FOut);
    for(int i= 0; i < CubesList.length; i++){
      OOS.writeObject((CubesList[i].getPosX()));
      OOS.writeObject((CubesList[i].getPosY()));
      OOS.writeObject((CubesList[i].getLayerIndex()));
      OOS.writeObject(Girl.getStandingPosX());
      OOS.writeObject(Girl.getStandingPosY());
      OOS.writeObject(Girl.getStandingCubeIndex());
      //OOS.writeObject((CubesList[i].UnitPath.Way));
    }
    OOS.close();
    FOut.close();
  }catch(FileNotFoundException e){
    println("The output file:\"", SaveCubeFileName, "\" can not be opened");
  }catch(IOException e){
    println("The cubes can not be outputed.");
  }
}


void differeingCubesMap(int StartPosition) 
{
  int TileType= 0;
  for(int i= 0; i < CubesList.length; i++){
    CubesList[i].TileType= 0;
  }
  Cubes FirstCube= CubesList[0];

    NodeRecord Current= new NodeRecord();
    NodeRecord StartRecord= new NodeRecord();
    OpenList.clear();
    CloseList.clear();
    StartRecord.Node= StartPosition;
    StartRecord.CostSofar= 0; 
    StartRecord.Connection[0]= StartRecord.Connection[1]= StartPosition;
    OpenList.add(StartRecord);
    while(!OpenList.isEmpty()){
      NodeRecord Record= (NodeRecord)OpenList.peek();
      int MinCostSoFar= (Record).CostSofar;
      int MinIndex= 0;
      for(int i= 0; i < OpenList.size(); i++){
       if(((NodeRecord)OpenList.get(i)).CostSofar < MinCostSoFar){
         MinIndex= i;
         MinCostSoFar= ((NodeRecord)OpenList.get(i)).CostSofar;
       }
      }
      Current= (NodeRecord)(OpenList.get(MinIndex));
      if(CubesList[Current.Node].TileType == 0){
        TileType= 1;
      }else{
        TileType= 0;
      }
    int BranchCount= PathList[Current.Node].countBranch(Current.Node);
    int[] Connections= new int[BranchCount];
    for(int i= 0, idx= 0; i < PathList[Current.Node].Way.length; i++){
      if(PathList[Current.Node].Way[i] != UNCONNECTED)Connections[idx++]= PathList[Current.Node].Way[i];
    }
      NodeRecord EndNodeRecord= new NodeRecord();
      for(int i= 0; i < Connections.length; i++){
        int EndNode= (Connections[i]);
        int EndNodeCost=  Current.CostSofar + UnitDistance;
        Boolean BOOL_Close= false, BOOL_Open= false;
        for(int idx= 0; idx < OpenList.size(); idx++){
            if(((NodeRecord)(OpenList.get(idx))).Node == EndNode){
              EndNodeRecord= ((NodeRecord)(OpenList.get(idx)));
              BOOL_Open= true;
            }
        }
        for(int idx= 0; idx < CloseList.size(); idx++){
            if(((NodeRecord)(CloseList.get(idx))).Node == EndNode){
              EndNodeRecord= ((NodeRecord)(CloseList.get(idx)));
              BOOL_Close= true;
            }
        }        
        if(BOOL_Close){
          continue;
        }else if(BOOL_Open){
          //if(EndNodeRecord.CostSofar <= EndNodeCost){
            continue;
          //}
        }else{
          EndNodeRecord= new NodeRecord();
          EndNodeRecord.Node= EndNode;
          EndNodeRecord.CostSofar= EndNodeCost;
          //Is Connection represented in the right way
          EndNodeRecord.Connection[0]= Current.Node;
          EndNodeRecord.Connection[1]= EndNode;
          removeRedundantEdge(EndNode);
          OpenList.add(EndNodeRecord);
          switch(i){
            case 11:
              break;
            default:
              CubesList[EndNodeRecord.Node].TileType= TileType;
              break;
          }
        }
      }
      OpenList.remove(Current);
      CloseList.add(Current);
    }
}


void loadGameMap()
{
  refreshCubes();
  try{
    float PosX, PosY;
    FIn= createInput(SaveCubeFileName);
    OIS= new ObjectInputStream(FIn);
    for(int i= 0; i < CubesList.length; i++){
      CubesList[i].setPosX((float)(OIS.readObject()));
      CubesList[i].setPosY((float)(OIS.readObject()));
      CubesList[i].helper_updatePointLoaction();
      CubesList[i].magOthers();
      CubesList[i].setLayerIndex((int)(OIS.readObject()));
      Girl.setStandingPoint(PosX= (float)OIS.readObject(), PosY= (float)OIS.readObject());
      Girl.setTargettingPoint(PosX, PosY);
      Girl.setStandingCubeIndex((int)OIS.readObject());
      Girl.setPathIndex(Girl.getStandingCubeIndex());
      Girl.setTargetIndexSav(Girl.getStandingCubeIndex());
      for(int foo= 0; foo < CubesList.length; foo++){
        removeRedundantEdge(foo);
      }
      differeingCubesMap(Girl.getStandingCubeIndex());
      //CubesList[i].UnitPath.Way= ((int[])(OIS.readObject()));
    }
    OIS.close();
  }catch(FileNotFoundException e){
  }catch(ClassNotFoundException e){
    println("The output file:\"", SaveCubeFileName, "\" can not be opened");
  }catch(IOException e){
    println("The cubes can not be inputed.");
  }
}