/*********************************************************
*
*           Bacterila v0.01a
*
*  Copyright (C) 2017,  Chang Liu, All Right Reserved
**********************************************************/
//
//Main
     boolean DEBUG_MODE= true;
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
     int ManX= 0, ManY= 0, WomanX= 0, WomanY= 0;
     
     Lattice Lat;
     void setup()
     {
       //fullScreen();
       size(1024, 1024);
       ScreenSizeX= 1024;
       ScreenSizeY= 1024; 
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
    }
 
     
     
     
     
     