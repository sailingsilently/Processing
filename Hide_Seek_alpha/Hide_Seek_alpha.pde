/*********************************************************
*
*           HideAndSeek v0.02a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//Main
     boolean DEBUG_MODE= true;
     String DATA_PATH= "data/";
     String IMAGE_PATH= DATA_PATH + "game_map/";
     String GAME_MAP_PATH= DATA_PATH + "savegame/";
     String ANIMATION_FRAM_PATH= DATA_PATH + "anim/";
     String Audio_Path= DATA_PATH + "audio/";
     String FONT_PATH= DATA_PATH + "font/";
     final int CUBES_SUM= 140;
     Girls Girl;
     Goos Goo00, Goo01;
     Rock PurRock01, PurRock02, PurRock03, PurRock04;
     SceneManager SceneMgr;
     Plot APlot;
     PFont APHFont;
     int ScreenSizeX;
     int ScreenSizeY;
     int StartPositionX;
     int StartPositionY;
     int LayerSum= 6;
     float SkyRatioLand= 0.3;
     int press= 0;
     int release= 1;
     
     PImage Room, RoomRoute, Man, Woman;
     int ManX= 0, ManY= 0, WomanX= 0, WomanY= 0;
     
     int TempTargetCube= 77;
      
     boolean BOOL_GirlCaptured= false;
     boolean BOOL_Checkmate= false;
           
     void setup()
     {
       fullScreen();
       //size(1920, 1080);
       ScreenSizeX= 1080;
       ScreenSizeY= 813; 
       StartPositionX= ScreenSizeX / 2;
       StartPositionY= ScreenSizeY / 2;
       println(width);
       background(0);
       APHFont= loadFont(FONT_PATH + "APHont-48.vlw");
       textFont(APHFont, 32);
       SceneMgr= new SceneManager(ScreenSizeX, ScreenSizeY, LayerSum);
       SceneMgr.init();
     }
     
     void draw()
     {
       SceneMgr.update();
       return;
     }
     
     void mouseClicked(){
       return;
     }
     
     void mouseReleased()
     {
       if(mouseButton == LEFT)
        Girl.findPathByMousePosition();
     }
     
     void mouseMoved()
     {
     }
     
     void mouseDragged()
     {
     }
     
    void keyReleased()
    {
    }
    
    void keyPressed()
    {
      if(key == '+'){
        saveGameMap();
        //loadCubes();
        println("The cubes saved.");
      }
      if(key == 'l'){
        //saveCubes();
        loadGameMap();
        println("The cubes loaded.");
      }      
    }
 
     
     
     
     
     