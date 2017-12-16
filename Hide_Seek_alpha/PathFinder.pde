/*********************************************************
*
*           PathFinder v0.21a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//Path finder in the cubespace for the girl, her friends and all the villains
import java.util.*;

final int WAY_SUM= 6;
  ConcurrentLinkedQueue PathResult= null, PathResultS= new ConcurrentLinkedQueue();  
Path PathList[]= new Path[CUBES_SUM];

final int UnitDistance= 1;

final int TYPE_WALK= 0;

final int UNCONNECTED= -1;

PathFinder CubePathFinder= new PathFinder();

class WayPoint{
  float PosX;
  float PosY;
  //float Angle;
  int Type;
  boolean isUp= false;
  public WayPoint(
    float PosX, 
    float PosY, 
    
    //float Angle, 
    int Type)
  {
    this.PosX= PosX;
    this.PosY= PosY;
    //this.Angle= Angle;
    this.Type= Type;
  }
}


class Path{
  float PosX, PosY;
  float UnitLength= 1; 
  String DetectOrder[]= {"N", "S", "W", "E", "U", "D"};
  private boolean BOOL_Connected= false;  
  public Path N= null, S= null, E= null, W= null, B= null, T= null;
  public Path PN= null, PS= null, PE= null, PW= null, PB= null, PT= null;
  public int Way[]= new int[WAY_SUM];
  public Path PWay[]= new Path[WAY_SUM];
  private boolean BOOL_Accessable= true;
  private boolean BOOL_Checked= false;
  private int CheckTimes= 0;
  //private ConcurrentLinkedQueue PathQueue[]= new ConcurrentLinkedQueue[WAY_SUM];
  private ConcurrentLinkedQueue SwapQueue= new ConcurrentLinkedQueue();
  int PathIndex;
  private int DistanceSum= 0;
  private int CostSofar= 0;

  public int setDistance(int Distance)
  {
    return this.DistanceSum= Distance;
  }
  
  public int getDistance()
  {
    return this.DistanceSum;
  }
  
  public void markDeadend()
  {
    this.BOOL_Accessable= false;
  }
  
  public void markPath()
  {
    this.BOOL_Accessable= true;
  }
  
  public void setPathIdx(int PathIndex)
  {
    this.PathIndex= PathIndex;
  }
  
  public int getPathIdx()
  {
    return this.PathIndex;
  }
  
  public boolean isConnected()
  {
    return BOOL_Connected;
  }
  
/*  public boolean isDeadEnd(int InIndex)
  {
    boolean BOOL_DeadEnding= true;
    for(int i= 0; i < WAY_SUM; i++){
      if(InIndex == i)continue;
      BOOL_DeadEnding= BOOL_DeadEnding && (((Way[i] == null)? true : false));
    }
    return BOOL_DeadEnding;
  }*/
  
  private int findString(String dir)
  {
    for(int i= 0; i < DetectOrder.length; i++){
      if(DetectOrder[i] == dir) return i;
    }
    return UNCONNECTED;
  }
  
  private void resetPath()
  {    
    for(int i= 0; i < WAY_SUM; i++){
      Way[i]=  UNCONNECTED;
    }
  }
  
  public void setPosition(float PosX, float PosY)
  {
    this.PosX= PosX;
    this.PosY= PosY;
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
  
  public int countBranch(int PathIndex)
  {
    int BranchCount= 0;
    Path Q= PathList[PathIndex];
    for(int i= 0; i < Q.Way.length; i++){
      if(Q.Way[i] != UNCONNECTED)BranchCount++;
    }
    return BranchCount;
  }
  
  public void attachPath(Path path, int dir)
  {
    PathList[this.PathIndex].Way[dir]= path.PathIndex;
    //if(PathList[path.PathIndex].Way[helper_computeAttachedPoint(dir)] == UNCONNECTED){
    PathList[path.PathIndex].Way[helper_computeAttachedPoint(dir)]= this.PathIndex;
    //}
    PathList[path.PathIndex].BOOL_Connected= true;
    PathList[this.PathIndex].BOOL_Connected= true;
  }
  
  public void cleanUp()
  {
    
  }
  
  public void detachPath()
  {
    for(int i= 0; i < WAY_SUM; i++){
      if(this.Way[i] != UNCONNECTED){
        PathList[this.Way[i]].Way[helper_computeAttachedPoint(i)]= UNCONNECTED;
        if(PathList[this.Way[i]].isIsolated()){
          PathList[this.Way[i]].BOOL_Connected= false;
          PathList[this.Way[i]].resetPath();
        }
      }
      this.Way[i]= UNCONNECTED;
    }
    resetPath();
    BOOL_Connected= false;
  } 
  
  public boolean isIsolated()
  {
     for(int i= 0; i < WAY_SUM; i++){
      if(this.Way[i] != UNCONNECTED){
        return false;
      }
     }
     return true;
  }
  
  private void copyQueue(ConcurrentLinkedQueue source, ConcurrentLinkedQueue target)
  {
    if((source == null) || (target == null)){
      return;
    }
    Object Q= new Object();
    for(;!source.isEmpty();){
      SwapQueue.add(source.poll());
    }
    for(;!SwapQueue.isEmpty();){
      Q= SwapQueue.poll();
      if(Q != null){
        source.add(Q);
        target.add(Q);
      }
    }
  }
  
 
  public void setUnitLength(float UnitLength)
  {
    this.UnitLength= UnitLength;
  }
  
  public void unmarkAll()
  {
    for(int i= 0; i < PathList.length; i++){
       PathList[i].BOOL_Checked= false;
       PathList[i].CheckTimes= 0;
    }
  }
  
 
 
  /*
  public void printAll()
  {
    for(int idx= 0; idx < PathList.length; idx++){
     for(int i= 0; i < this.Way.length; i++){
       if(PathList[idx].Way[i] != UNCONNECTED)
         println(PathList[PathList[idx].PathIndex].PathIndex, "Way this" , i, PathList[PathList[idx].PathIndex].Way[i]);
       if(SortedCubesList[PathList[idx].PathIndex].UnitPath.Way[i] != UNCONNECTED)
         println(PathList[SortedCubesList[PathList[idx].PathIndex].getUID()].PathIndex, "Way Point: " , i, PathList[SortedCubesList[PathList[idx].PathIndex].getUID()].Way[i]);
     }
    }
  }
  */
  
  Path()
  {
    resetPath();
      
  }
}

class NodeRecord{
  int Node;
  int Connection[]= {0, 0};
  int CostSofar;
}

class PathFinder{
  LinkedList OpenList= new LinkedList();
  LinkedList CloseList= new LinkedList();
  
  private int[] getConnections(int NodeIndex)
  {
    int BranchCount= PathList[NodeIndex].countBranch(NodeIndex);
    int[] Connections= new int[BranchCount];
    for(int i= 0, idx= 0; i < PathList[NodeIndex].Way.length; i++){
      if(PathList[NodeIndex].Way[i] != UNCONNECTED)Connections[idx++]= PathList[NodeIndex].Way[i];
    }
    return Connections;
  }
  
  public LinkedList findPathDijkstra(int StartIndex, int TargetIndex)
  {
    NodeRecord Current= new NodeRecord();
    NodeRecord StartRecord= new NodeRecord();
    LinkedList Path= new LinkedList();
    OpenList.clear();
    CloseList.clear();
    PathList[StartIndex].setDistance(UnitDistance);
    StartRecord.Node= StartIndex;
    StartRecord.CostSofar= 0; 
    StartRecord.Connection[0]= StartRecord.Connection[1]= StartIndex;
    OpenList.add(StartRecord);
    NodeRecord EndNodeRecord= new NodeRecord();
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
      if(Current.Node == TargetIndex)break;
      int[] Connections= getConnections(Current.Node);
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
          EndNodeRecord= null;
          continue;
        }else if(BOOL_Open){
          if(EndNodeRecord.CostSofar <= EndNodeCost){
            continue;
          }
        }else{
          EndNodeRecord= new NodeRecord();
          EndNodeRecord.Node= EndNode;
          EndNodeRecord.CostSofar= EndNodeCost;
          //Is Connection represented in the right way
          EndNodeRecord.Connection[0]= Current.Node;
          EndNodeRecord.Connection[1]= EndNode;
          OpenList.add(EndNodeRecord);
        }
      }
      OpenList.remove(Current);
      CloseList.add(Current);
    }
    if(Current.Node != TargetIndex){
      return null;
    }
    
    while(Current.Node != StartIndex){
      Path.push(Current.Connection[1]);
      for(int i= 0; i < CloseList.size(); i++){
        if(((NodeRecord)CloseList.get(i)).Node == Current.Connection[0]){
          Current= (NodeRecord)(CloseList.get(i));
          break;
        }
      }
    }
    return Path;
  }
     
}