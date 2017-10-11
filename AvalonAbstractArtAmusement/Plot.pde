/*********************************************************
*                Animation script
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//This is a dirty implemention of the animation script subsystem
//Needed to be reconstructed in a more elegant way when 
//time is permitted.
int rescounter= 0;
int InitAbstracterSize= 25;
List<CollideCircle> CircleSet= new ArrayList<CollideCircle>();
class Plot{
  Dictionary Acts;
  AnimationSequencer Animator= new AnimationSequencer();
  final int TestIconSum= 1290;
  private int TimeKeeper01= 0;
  private int TimeKeeper02= 0;
  
  public Plot()
  {
    TimeKeeper01= 1;
    TimeKeeper02= 50;
    
   strokeWeight(2);
   for(int i= 0; i < TestIconSum; i++){     
     final int aa= i;
     CircleSet.add(i,  new CollideCircle(aa, InitAbstracterSize));
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 0, 1}, End[]= {0, 0, 1, 9};
      int animate(LinkedList EventQuene)
      {
        SceneMgr.AlphaAmount= 90;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        int S= SceneMgr.AnimationSequence.caseTimeEvent(Start, End); 
        if(S != ANIMATION_RUNNING){
          return S;
        }
        float Pos[]= SceneMgr.getStartButtonPos();
        CollideCircle Atom= CircleSet.get(aa);
        fill(232, 28, 12);
        Atom.PosX= SceneMgr.getStartButtonPos()[0] + (aa / 4) * cos((4.94 * TWO_PI / TestIconSum) * (aa)); //random(- Atom.ConstrainRadius / 2, Atom.ConstrainRadius / 2);  
        Atom.PosY= SceneMgr.getStartButtonPos()[1] + InitAbstracterSize + (aa / 4) * sin((4.94 * TWO_PI / TestIconSum) * (aa)); //random(- Atom.ConstrainRadius / 2, Atom.ConstrainRadius / 2);

        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
   }
   
   
   
   
   
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      PImage Eye= loadImage("eye.png");
      int Start[]= {0, 0, 0, 1}, End[]= {0, 0, 15, 1};
      int animate(LinkedList EventQuene)
      { 
        SceneMgr.AlphaAmount= 90;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        fill(10);
        stroke(255);
        strokeWeight(2);
       ellipse(CircleSet.get(0).ConstrainCenterX, CircleSet.get(0).ConstrainCenterY, CircleSet.get(0).ConstrainRadius * 2, CircleSet.get(0).ConstrainRadius * 2);
        for(int aa= 0; aa < CircleSet.size(); aa++){
           stroke(255);  
           //line(CircleSet.get(aa).PosX, CircleSet.get(aa).PosY, SceneMgr.getStartButtonPos()[0], SceneMgr.getStartButtonPos()[1]);
           CircleSet.get(aa).drawCollideCircle(SceneMgr.AlphaAmount);
        }
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
    
    
    
    
      
      
      
      SceneMgr.addAnimationTask(new AnimationTask(){
      PImage Eye= loadImage("eye.png");
      int Start[]= {0, 0, 0, 1}, End[]= {1, 9, 90, 1};
      int animate(LinkedList EventQuene)
      { 
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        image(Eye, 0, 0);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 4;
      }
    });
    
    
    
    
    
     SceneMgr.addAnimationTask(new AnimationTask(){
      boolean Mark= false;
      int Start[]= {0, 0, 5, 1}, End[]= {0, 0, 10, 20};
      int animate(LinkedList EventQuene)
      { 
        SceneMgr.AlphaAmount= 90;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        for(int aa= 0; aa < CircleSet.size(); aa++){
            CollideCircle Atom= CircleSet.get(aa);
            Atom.vX= (Atom.PosX - SceneMgr.getStartButtonPos()[0]) * 0.000008;// + random(-0.004, 0.004);  
            Atom.vY= (Atom.PosY - SceneMgr.getStartButtonPos()[1]) * 0.000008;// + random(-0.004, 0.004);
            Atom.collideMany(Atom, CircleSet); 
            //clearMark(CircleSet);
        }  
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    }); 
    
    
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      boolean Mark= false;
      int Start[]= {0, 0, 11, 1}, End[]= {0, 0, 15, 1};
      int animate(LinkedList EventQuene)
      {
        SceneMgr.AlphaAmount= 100;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        if((rescounter++ < CircleSet.size())){
          for(int aa= 0; aa < CircleSet.size(); aa++){
              CollideCircle Atom= CircleSet.get(floor(random(0, CircleSet.size() - 1)));
            Atom.vX= 0;  
            Atom.vY= 0;
              //Atom.collideManyWithGrowth(floor(random(20, 55)), CircleSet);
              Atom.collideMany(Atom, CircleSet); 
          }
        } 
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
    
    
    
    
    
      SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 15, 1}, End[]= {0, 0, 17, 0};
      int animate(LinkedList EventQuene)
      {
        SceneMgr.AlphaAmount= 255;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        CircleSet= removeOverlappedItem(CircleSet);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });  
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      PImage Eye= loadImage("eye.png");
      int Start[]= {0, 0, 15, 1}, End[]= {0, 0, 17, 1};
      int animate(LinkedList EventQuene)
      { 
        SceneMgr.AlphaAmount= 90;
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        fill(10);
        stroke(255);
        strokeWeight(2);
       ellipse(CircleSet.get(0).ConstrainCenterX, CircleSet.get(0).ConstrainCenterY, CircleSet.get(0).ConstrainRadius * 2, CircleSet.get(0).ConstrainRadius * 2);
        for(int aa= 0; aa < CircleSet.size(); aa++){
           stroke(255);  
           //line(CircleSet.get(aa).PosX, CircleSet.get(aa).PosY, SceneMgr.getStartButtonPos()[0], SceneMgr.getStartButtonPos()[1]);
           CircleSet.get(aa).drawCollideCircle(220);
        }
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });    
    
    
    
                                                                                            
     SceneMgr.addAnimationTask(new AnimationTask(){  
      int Start[]= {0, 0, 17, 1}, End[]= {1, 9, 30, 1};
      int animate(LinkedList EventQuene)
      { 
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
        if(SceneMgr.BOOL_AbstractButtons == false)
        for(int aa= 0; aa < CircleSet.size(); aa++){
           //stroke(255);  
           //line(CircleSet.get(aa).PosX, CircleSet.get(aa).PosY, SceneMgr.getStartButtonPos()[0], SceneMgr.getStartButtonPos()[1]);
           CollideCircle A= CircleSet.get(aa);
           final AbstractButton AB= new AbstractButton(aa, 
                        aa % 2,
                        (int)A.PosX, 
                        (int)A.PosY, 
                        (int)A.PosX, 
                        (int)A.PosY,
                        (int)A.Size);
           //CircleSet.get(aa).drawCollideCircle();           
           AB.setActiveAction(new EventHandler(){
            @Override
            public void callback(int UID)
            {
              SceneMgr.setAbstractTarget(AB.getAbstructID());
              SceneMgr.savAbstractArtID(AB.getAbstructID());
              if(!SceneMgr.isTagetSame())AB.lockButton();
              else AB.setRight();
              println(UID);
              println(AB.AbstractID);
              return;
            }
          });
          SceneMgr.ButtonList.add(AB);
        }
        SceneMgr.BOOL_AbstractButtons= true;
        noFill();
        stroke(255);
        strokeWeight(2);
       ellipse(CircleSet.get(0).ConstrainCenterX, CircleSet.get(0).ConstrainCenterY, CircleSet.get(0).ConstrainRadius * 2, CircleSet.get(0).ConstrainRadius * 2);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
  }
}