import ddf.minim.*;

  Minim Min= new Minim(this);

class SoundMan{
  String FileList[]= {
    "goo_level0002.wav",
    "clam_level0001.wav"
  };
  
  AudioPlayer Player;
  LinkedList SoundArray= new LinkedList();
  LinkedList PlayerArray= new LinkedList();
  Hashtable SoundBook= new Hashtable();
  
  void addAudioPlayer(String FileName)
  {
    SoundBook.put(FileName, Min.loadFile(Audio_Path + FileName));
  }
  
  void LoopPlay()
  {
    
  }
  
  SoundMan()
  {
    for(int i= 0; i < FileList.length; i++){
      addAudioPlayer(FileList[i]);
    }
    //((AudioPlayer)SoundBook.get(FileList[1])).play();
  }
}