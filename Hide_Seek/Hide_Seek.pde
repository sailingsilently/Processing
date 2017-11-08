  /*********************************************************  S
*
*           HideAndSeek v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//Main
     boolean DEBUG_MODE= true;
     String DATA_PATH= "data/";
     String IMAGE_PATH= DATA_PATH + "game_map/";
     String GAME_MAP_PATH= DATA_PATH + "savegame/";
     String ANIMATION_FRAM_PATH= DATA_PATH + "anim/";
     final int CUBES_SUM= 55;
     Girls Girl;
     Goos Goo00, Goo01;
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
     
     PImage Room, RoomRoute, Man, Woman;
     int ManX= 0, ManY= 0, WomanX= 0, WomanY= 0;
     
     void setup()
     {
       //fullScreen();
       size(1920, 1080);
       ScreenSizeX= 1080;
       ScreenSizeY= 813; 
       StartPositionX= ScreenSizeX / 2;
       StartPositionY= ScreenSizeY / 2;
       println(width);
       background(0);
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
 
     
     
     
     
     