/*********************************************************
*
*           PathFinder v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//Path finder in the cubespace for the girl, her friends and all the villains
final int WAY_SUM= 6;
  ConcurrentLinkedQueue PathResult= null, PathResultS= new ConcurrentLinkedQueue();  
Path PathList[]= new Path[CUBES_SUM];

final int TYPE_WALK= 0;

final int UNCONNECTED= -1;

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
    Object Q= new Object();
    for(;!source.isEmpty();){
      SwapQueue.add(source.poll());
    }
    for(;!SwapQueue.isEmpty();){
      Q= SwapQueue.poll();
      source.add(Q);
      target.add(Q);
    }
  }
  
  
  //The path finder keeps all possible routes for the purpose of extensibility
  public void findWayPoint(int TargetIndex, ConcurrentLinkedQueue Mem)
  {
    if(Mem.contains(this.PathIndex)){
      if(this.PathIndex != TargetIndex)
              return;
    }
    if(this.PathIndex == TargetIndex){
        Mem.add(TargetIndex);
        PathResultS.add(Mem);
        return;
    }
    ConcurrentLinkedQueue PathQueue[]= new ConcurrentLinkedQueue[WAY_SUM];
    for(int i= 0; i < PathQueue.length; i++){
      if(this.Way[i] == UNCONNECTED)continue;
      PathQueue[i]= new ConcurrentLinkedQueue();
    }
    
    for(int i = 0; i < this.Way.length ; i++){
      if((this.Way[i] == UNCONNECTED)){
        continue;
      }else{
        copyQueue(Mem, PathQueue[i]);
        PathQueue[i].add(this.getPathIdx());
        PathList[Way[i]].findWayPoint(TargetIndex, PathQueue[i]);
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

 ConcurrentLinkedQueue findPath(int StartIndex, int TargetIndex)
  {
    //println("Standing At: ", StartIndex, ";    Targeting At: " ,TargetIndex);
    for(;!PathResultS.isEmpty();){
      PathResult.poll();
    }
    PathResult= null;
    PathList[StartIndex].unmarkAll();
    ConcurrentLinkedQueue Q= new ConcurrentLinkedQueue();
    PathList[StartIndex].findWayPoint(TargetIndex, Q);
    //println("Path result size: ", PathResultS.size()); 
    if(!PathResultS.isEmpty()){
      int Steps= PathList.length;
      ConcurrentLinkedQueue W;
      for(;!PathResultS.isEmpty();){
        W= (ConcurrentLinkedQueue)PathResultS.poll();
          //println("Stepsmount: ", W.size());
        if(W.size() <= Steps){
          PathResult= W;
          Steps= W.size();
        }
      }
      return PathResult;
    }else{
      PathResult= null;
      return PathResult;
    }
   }