/*********************************************************
*                Animation script
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
int rescounter= 0;
int InitAbstracterSize= 25;
class Plot{
  Dictionary Acts;
  AnimationSequencer Animator= new AnimationSequencer();
  final int TestIconSum= 1290;
  private int TimeKeeper01= 0;
  private int TimeKeeper02= 0;
  final int CUBE_SPACE_LAYER= 0;
  final int GUI_LAYER= 128;
  final int GRIL_LAYER= 1;
  
  public Plot()
  {
    //Cube Space
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        SceneMgr.AlphaAmount= 90;
        //if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        //int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        refreshCubes();
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return CUBE_SPACE_LAYER;
      }
    });
   
   //Girl
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        //if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        //int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        //Girl.getInBetween(24);

        Girl.walkGirl();
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return CUBE_SPACE_LAYER;
      }
    });
    
   //Goos
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        //if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        //int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        //Girl.getInBetween(24);

        Goo01.walkGoo();
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return CUBE_SPACE_LAYER;
      }
    });
    
      SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        //if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        //int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        //Girl.getInBetween(24);

        Goo00.walkGoo();
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return CUBE_SPACE_LAYER;
      }
    });

    //GUI
     SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        SceneMgr.evalHexButtons(); 
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return GUI_LAYER;
      }
    });
  }  
}