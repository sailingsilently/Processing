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
int dl= 250;
int change= 0;

int IconIndex= 0;
int rd= 10;


 
 void setColor()
 {
   if(IconIndex == 0) return;
        long l= 0, r= 0, g= 0, b= 0, sr= 0, sg= 0, sb= 0, ll= 0;        
         for(int i= 0; i < MMImages[IconIndex].height; i++){
          for(int a= 0; a < MMImages[IconIndex].width; a++){
           l= MMImages[IconIndex].get(a, i);
           ll= MMImages[IconIndex - 1].get(a, i);
           r= ((0xff0000 & l) >> 16);
           g= ((0x00ff00 & l) >> 8);
           b= ((0x0000ff & l));
           sr= ((0xff0000 & ll) >> 16);
           sg= ((0x00ff00 & ll) >> 8);
           sb= ((0x0000ff & ll));
              if(IconIndex != 0)MMImages[IconIndex].set(a, i, color((r + sr) / 2, (g + sg) / 2, (b + sb) / 2));
              //println(r / oa , g / oa, b / oa);
          }           
        }
 }

int Step= 5;
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
   //for(int i= 0; i < TestIconSum; i++){     
     final int aa= i;
     CircleSet.add(i,  new CollideCircle(aa, InitAbstracterSize));
     
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 0, 1}, End[]= {0, 0, 5, 0};
      int animate(LinkedList EventQuene)
      {
       // if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       //Sp= floor(SpMax / Div);
       change++;
        for(int idx= 0, i= 0; idx < Sum ; idx++, i++){
          GU[idx].Div= 2;
          GU[idx].drawFrame((change + idx) % Sum, idx);
        }      
         ;
        delay(dl);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 1;
      }
    });
   //}
    
    
    
    
    
     SceneMgr.addAnimationTask(new AnimationTask(){
      boolean Mark= false;
      int Start[]= {0, 0, 5, 0}, End[]= {0, 0, 12, 0};
      int animate(LinkedList EventQuene)
      {   
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
        change++;
       int w= 30, h= 30;
       i++;
       //Sp= floor(SpMax / Div);
        for(int idx= 0; idx < 9 ; idx++){
          GU[idx].Div= 3;
          GU[idx].drawFrame((change + idx) % Sum, idx);
        } 
         ;
        delay(dl);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 1;
      }
    }); 
    
    
    
    
    SceneMgr.addAnimationTask(new AnimationTask(){
      boolean Mark= false;
      int Start[]= {0, 0, 12, 0}, End[]= {0, 0, 19, 0};
      int animate(LinkedList EventQuene)
      {        
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       change++;
       i++;
       //Sp= floor(SpMax / Div);
        for(int idx= 0; idx < Sum ; idx++){
          GU[idx].Div= 4;
          GU[idx].drawFrame((change + idx) % Sum, idx);
        } 
         ;
        delay(dl);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
    
    
    
    
    
      SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 19, 0}, End[]= {0, 0, 28, 0};
      int animate(LinkedList EventQuene)
      {        
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       change++;
       i++;
       //Sp= floor(SpMax / Div);
        for(int idx= 0; idx < Sum ; idx++){
          GU[idx].Div= 6;
          GU[idx].drawFrame((change + idx) % Sum, idx);
        }
         ;   
        delay(dl);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });  
          
      SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 28, 0
    }, End[]= {0, 0, 39, 0};
      int animate(LinkedList EventQuene)
      {        
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       i++;
       //Sp= floor(SpMax / Div);
        for(int idx= 0; idx < Sum ; idx++){
          GU[idx].Div= 6;
           GU[idx].drawFrame(idx, idx);
        }
         ;
       // delay(dl);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });  
    
    int rm= 10;
    SceneMgr.addAnimationTask(new AnimationTask(){
      int Start[]= {0, 0, 39, 1}, End[]= {0, 0, 48, 1};
      int animate(LinkedList EventQuene)
      {        
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       i++;
       
       if(rd > 1) rd-= 1;
       for(int index= 0; index < 36; index++){
         GU[index].ReduceLog= true;
          GU[index].reduce(rd);
       }
       //Sp= floor(SpMax / Div);
        for(int idx= 0, r= 10; idx < 36 ; idx++, r-= 1){
          GU[idx].Div= 6;
          println(rd);
          GU[idx].drawFrame(idx, idx);
        }
        
          //GU[idx].goCenter(8);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });    
    
     SceneMgr.addAnimationTask(new AnimationTask(){  
      int Start[]= {0,   0, 48, 1}, End[]= {1, 9, 50, 1};
      int ia= 0;
      int animate(LinkedList EventQuene)
      {         
        if(SceneMgr.AnimationSequence.caseTimeEvent(Start, End) == ANIMATION_NOT_START) return ANIMATION_NOT_START;
       background(0);
       //genThumb();
       int w= 30, h= 30;
       i++; 
       //Sp= floor(SpMax / Div);
           GU[IconIndex].goCenter(Step);
        for(int idx= 0; idx < 36 ; idx++){
          GU[idx].Div= 6;
           //GU[IconIndex].firsttime= true;
           image(
             MMImages[idx], 
             GU[idx].PosX, 
             GU[idx].PosY, 
             ScreenWidth / 6 - 2 * Sp,
             ScreenHeight / 6 - 2 * Sp);
        }
         ;
       if(GU[IconIndex].StepCount >= Step){
         setColor();
           if(IconIndex < 36){
             IconIndex++;
           }else{
             setColor();
         }
       }

          //GU[idx].goCenter(8);
        return SceneMgr.AnimationSequence.caseTimeEvent(Start, End);
      }
      
      int atLayer()
      {
        return 0;
      }
    });
  }
}