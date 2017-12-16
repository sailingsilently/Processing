/*********************************************************
*
*               AvalonGuiButton v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
/*********************************************************
*  The Avalon Painter is a simple interactive Processing
*  image generator. Please take it easy and have fun ;)
**********************************************************/
//Press right mouse button to show the Hex Menu
//When cursor on those buttons, press left mouse button to select items;
//Then on the canvas, click left button to draw the texture
//Constant definations

//Error information object, 
//As if eunm is blocked by the processing preprocessor
//Why enum doesn't work in processing




//Main
     SceneManager SceneMgr;
     int ScreenSizeX= 1280;
     int ScreenSizeY= 1280;
     int LayerSum= 6;
     float SkyRatioLand= 0.3;
     int press= 0;
     int release= 1;
     PFont APHFont;
     void setup()
     {
       size(1280, 1280);
       background(23, 57, 120);
       APHFont= loadFont("APHont-48.vlw");
       textFont(APHFont, 32);
       SceneMgr= new SceneManager(ScreenSizeX, ScreenSizeY, LayerSum);
       SceneMgr.update();
     }
     
     void draw()
     {
       SceneMgr.update();
       return;
     }
     
     void mouseClicked(){
       SceneMgr.update();
       return;
     }
     
     void mouseReleased()
     {
       SceneMgr.update();
     }
     
     void mouseMoved()
     {
       //SceneMgr.update();
     }
     
 
     
     
     
     
     
     
     
     
     
/************************************************************************
                  Revision History
V0.01a                  
  Button widget implemented;
  Layer system partially implemented;
  Demo program(Avalon Painter) partially implemented;
  
  Java's GUI system turn to be old fashioned, so the GUI system's design
  goal is to give processing a native feeling user interface. The GUI should be:
  1) K.I.S.S.
  2) Ergonomics
  3) User Friendly
  4) Visually stunt
  Hopefully it is not a practice of reinventing the wheels ;)
  By the way, Avalon is just a code name for the project. It actually came from
  the movie Avalon.
  
  Mouse button has a pattern of inresponsiveness problem;
  PImage's copy(...) function may not be suitable to implement layer function; 
  
v0.02a  
  mouse button function improved; layer function improved;
  
  Fixed the mouse responsiveness problem. The problem turn out result from 
  that the processing's mouseButton variable is not reset immediately 
  to 0 after the mouse button has been released;
  Alpha blend problem was fixed by Using PImage's blend(...) instead 
  of copy(...) function to implement the layer functions;
  
  GUI(Widget system) need to be implemented as a standalone library. Its name
  could be Avalon GUI;
  Other widgets need to be added to the library, depended on their necessarity.
  Some redundant functions need to be eliminated
*************************************************************************/