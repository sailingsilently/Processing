/*********************************************************
*
*           AvalonAbstractArtAmusement v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
/*********************************************************
*  The Avalon-Abstract-Art-Amusementis a small game which
*  let you test your skills of identify abstract art 
*  masterpieces. 
*  It's just a joke, so, please take it easy and have fun ;)
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
     Plot APlot;
     int ScreenSizeX;
     int ScreenSizeY;
     int StartPositionX;
     int StartPositionY;
     int LayerSum= 6;
     float SkyRatioLand= 0.3;
     int press= 0;
     int release= 1;
     void setup()
     {
       //fullScreen();
       size(1080, 813);
       ScreenSizeX= 1080;
       ScreenSizeY= 813; 
       StartPositionX= ScreenSizeX / 2;
       StartPositionY= ScreenSizeY / 2;
       println(width);
       background(0);
       SceneMgr= new SceneManager(ScreenSizeX, ScreenSizeY, LayerSum);
       APlot= new Plot();
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
     
 
     
     
     
     
     