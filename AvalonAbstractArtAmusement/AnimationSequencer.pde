/*********************************************************
*
*               Animation Sequencer v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/

import java.util.Timer;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.TimerTask;

final int ANIMATION_FINISHED= -1;
final int ANIMATION_NOT_START= 0;
final int ANIMATION_RUNNING= 1;

interface Animation {
  public int doAnimation(int Time[]);
}

//Partially implemented
interface AnimationTask{
  String ObjNames= "";
  float StartPosX= 0;
  float StartPosY= 0;
  float DestPosX= 0;
  float DestPosY= 0;
  float Speed= 0;
  float CurrentScale= 1;
  float TransformedScale= 1;
  float DeltaScale= 1;
  int FrameCounter= 0;
  boolean BOOL_Finished= false;
  int TimeStart[]= {0, 0, 0, 0};
  public int animate(LinkedList EventQuene);
  public int atLayer();
}

class EventElement{
  public String Type;
  public Object Event;
}

class AnimationSequencer{
  private int FrameRate= 50;
  private boolean BOOL_DaemonSwitch= false;
  private String RateNames= "AnimationTimer";
  private TimerTask TimerTasks;
  private Timer AnimTimer= new Timer(RateNames, BOOL_DaemonSwitch);
  private long Delay= 0;
  private int Period= ceil(1000 / FrameRate);
  private ConcurrentLinkedQueue AnimQueue= new ConcurrentLinkedQueue();
  private ConcurrentLinkedQueue SwapAnimQueue= new ConcurrentLinkedQueue();
  private ConcurrentLinkedQueue UpdateQueue= new ConcurrentLinkedQueue(); 
  private AnimationTask Jobs;
  private AnimationTask RendTask;
  private boolean BOOL_Pause= true;
  private int Time[]={0, 0, 0, 0};
  private final int HOUR= 0, 
                    MINUTE= 1, 
                    SECOND= 2, 
                    FRAME= 3, 
                    SECOND_MAX= 60, 
                    MINUTE_MAX= 60, 
                    HOUR_MAX= 24,
                    FRAME_MAX= FrameRate,
                    EQUAL= 0,
                    GREATER= 1,
                    LESS= -1;
  long FrameCount= 0;
  long PreFrameCount= 0;
  protected LinkedList EventList= new LinkedList();
  public EventElement TimeEvent;
  public final String TIME_EVENT_NAME= "time";
  
  public void pauseAnimation()
  {
      BOOL_Pause= true;
  }
  
  public void startSequencer()
  {
    //else BOOL_Pause= false;
     AnimTimer.scheduleAtFixedRate(new TimerTask(){
       public void run(){
           if(BOOL_Pause == false)keepTime();
         //if(BOOL_Pause == true)return;
           FrameCount+= 1;
      }
     }, Delay, Period);
  }
  
  public void startAnimation()
  {
    this.BOOL_Pause= false;
  }
  
  public void stopAnimation()
  {
    AnimTimer.cancel();
  }
  
  public void addTask(AnimationTask Tasks)
  {
    AnimQueue.add(Tasks);
  }
  
  public void startTasks()
  {
    this.BOOL_Pause= false;
  }
  
  public void endTasks()
  {
  }
  
  public void pauseTasks()
  {
    this.BOOL_Pause= true;
  }
    
    
    
  private void keepTime()
  {
    int T[]= {FRAME, SECOND, MINUTE, HOUR}, idx= 0;
    int M[]= {FRAME_MAX, SECOND_MAX, MINUTE_MAX, HOUR_MAX};
    for(int i= 0; i < T.length; i++){
      idx= T[i];
      if((++(Time[idx])) >= M[idx]){
        Time[idx]= 0;
      }else{
        break;
      }
    }
    updateTimeEvent();
  }
  
  public int compareTime(int TimeA[], int TimeB[])
  {
    int T[]= {HOUR, MINUTE, SECOND, FRAME}, idx= 0;
    for(int i= 0; i < T.length; i++){
      idx= T[i];
      if(TimeA[idx] > TimeB[idx]){
        return this.GREATER;
      }else if(TimeA[idx] < TimeB[idx]){
        return this.LESS;
      }else{
        continue;
      }
    }
    return EQUAL;
  }
  
  public void evalAnimateQueue()
  {  
    if(BOOL_Pause)return;
    int MaxLayer= 0;
    //Find the max layer
    for(;;){
         try{Jobs= (AnimationTask)AnimQueue.poll();}catch(NullPointerException e){
         }
         if(Jobs == null)break;
         if(MaxLayer < Jobs.atLayer()) MaxLayer= Jobs.atLayer();
         UpdateQueue.add(Jobs);
    }
    //Sort layers into renderqueue
    for(int index= 0; index <= MaxLayer; index++){
      if(UpdateQueue.size() == 0)break;
      for(int i= 0, s= UpdateQueue.size();;i++){
         try{Jobs= (AnimationTask)UpdateQueue.poll();}catch(NullPointerException e){
         }
         if(Jobs == null)break;
         if(Jobs.atLayer() == index)AnimQueue.add(Jobs);
         else UpdateQueue.add(Jobs);
         if(i >= s - 1)break;
      }
    }
    
    for(;;){
         try{Jobs= (AnimationTask)AnimQueue.poll();}catch(NullPointerException e){
         }
         if(Jobs == null){
           for(;;){
             try{Jobs= (AnimationTask)SwapAnimQueue.poll();}catch(NullPointerException e){
             }
             if(Jobs == null)return;
             AnimQueue.add(Jobs);
             //run();
           }
         }else{
             switch(Jobs.animate((EventList))){
               case ANIMATION_NOT_START:
                  SwapAnimQueue.add(Jobs);
                  break;
               case ANIMATION_RUNNING:
                  SwapAnimQueue.add(Jobs);
               break;
               case ANIMATION_FINISHED:
                   Jobs= null;
               break;
             }
         }
       }
  }
  
  public int getFrameRate()
  {
    return this.FrameRate;
  }
  
  public boolean isFrameReady()
  {
    if(FrameCount != PreFrameCount){
      PreFrameCount= FrameCount;
      return true;
    }else{
      return false;
    }
  }
  
  public void updateEvent(String EventName, Object EventObject)
  {
    for(int i= 0;i < EventList.size(); i++){
      if(((EventElement)(EventList.get(i))).Type.equals(EventName)){
        EventList.set(i, EventObject);
      }
    }
  }
  
  public EventElement getEvent(String EventName)
  {
    for(int i= 0;i < EventList.size(); i++){
        Object a= ((EventList.get(i)));
        println(a);
        if(((EventElement)a).Type.equals(EventName)){
          return (EventElement)(EventList.get(i));
      }
    }
    return null;
  }
  
  private void updateTimeEvent()
  {
    //updateEvent(TIME_EVENT_NAME, getEvent(TIME_EVENT_NAME).Event= Time);
  }
  
  public int caseTimeEvent(int StartTime[], int EndTime[])
  {
     if(compareTime(Time, StartTime) == this.LESS){
        return ANIMATION_NOT_START;
     }else if(compareTime(Time, EndTime) == this.GREATER){
        return ANIMATION_FINISHED;
     }else{
       return ANIMATION_RUNNING;
     }
  }
  
  
  public AnimationSequencer()
  {
     TimeEvent= new EventElement();
     TimeEvent.Type= TIME_EVENT_NAME;
     TimeEvent.Event= this.Time;
     EventList.add((EventElement)TimeEvent);
  }
 }