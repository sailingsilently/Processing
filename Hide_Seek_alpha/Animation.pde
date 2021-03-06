/*********************************************************
*                Animation script
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
int rescounter= 0;
int InitAbstracterSize= 25;
int ChessCounter= 0;
int ChessCounterMax= 1;
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
    //Instructions
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 0, 1}, End[]= {0, 0, 30, 0};
      int animate(LinkedList EventQuene)
      {
        float X= 300, Y= 120;
        float IncY= 50;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        text("To move the girl, KLICK the LEFT Mouse Button when cursor on blocks", X, Y);
        text("To move a block, PRESS the RIGHT Mouse Button and Drag when cursor on blocks", X, Y + IncY);
        text("The target is to walk to the golden cube without being captured by the rocks", X, Y + IncY * 2);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return CUBE_SPACE_LAYER + 1;
      }
    });
    
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
        return Girl.getLayer();
      }
    });
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        if(BOOL_Checkmate)return ANIMATION_ALWAYS_RUNNING;
          PurRock01.drawSelf();
        PurRock01.walkPawn();
        if(BOOL_GirlCaptured){
          BOOL_GirlCaptured= false;
          SceneMgr.init();
        }
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return PurRock01.getLayer();
      }
    });
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        if(BOOL_Checkmate)return ANIMATION_ALWAYS_RUNNING;
          PurRock02.drawSelf();
        PurRock02.walkPawn();
        if(BOOL_GirlCaptured){
          BOOL_GirlCaptured= false;
          SceneMgr.init();
        }
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return PurRock02.getLayer();
      }
    });
    
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        if(BOOL_Checkmate)return ANIMATION_ALWAYS_RUNNING;
          PurRock03.drawSelf();
        PurRock03.walkPawn();
        if(BOOL_GirlCaptured){
          BOOL_GirlCaptured= false;
          SceneMgr.init();
        }
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return PurRock03.getLayer();
      }
    });
    
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        if(BOOL_Checkmate)return ANIMATION_ALWAYS_RUNNING;
          PurRock04.drawSelf();
        PurRock04.walkPawn();
        if(BOOL_GirlCaptured){
          BOOL_GirlCaptured= false;
          SceneMgr.init();
        }
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return PurRock04.getLayer();
      }
    });
    
      SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {}, End[]= {};
      int animate(LinkedList EventQuene)
      {
        //if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        //int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        //Girl.getInBetween(24);

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
        //SceneMgr.evalHexButtons(); 
        SceneMgr.ReplayButton.update();
        //SceneMgr.HelpButton.update();
        return ANIMATION_ALWAYS_RUNNING;
      }
      
      int atLayer()
      {
        return GUI_LAYER;
      }
    });
  }  
}