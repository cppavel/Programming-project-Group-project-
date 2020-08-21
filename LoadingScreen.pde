//Loading screen, which is shown in the main window, while the data is being parsed into files and preprocessed
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I wrote a draw method here 
//---------------------------------------------------------------------------------------------------------------------------------------------------

class LoadingScreen {
  private int x1=0;
  private int x2 = SCREEN_WIDTH-SCREEN_HEIGHT/3;
  private int size = SCREEN_HEIGHT/3;
  private int start = 0;
  private PFont font;
  
  public LoadingScreen()
  {
    font = loadFont("YuGothicUI-Semibold-50.vlw");
  }
  void resetTimer() {
    start = 0;
  }

  void draw() {
    
    background(255);
    fill(LIGHT_GRAY_2);

    if (x2>=0&&x2<=SCREEN_WIDTH-size)
    {
      rect(x2, 0, size, size);
    } else
    {
      rect(x2, 0, SCREEN_WIDTH - x2, size);
      rect(0, 0, x2-(SCREEN_WIDTH-size), size);
    }

    x2 = x2 - 3;
    if (x2<0)
    {
      x2 = SCREEN_WIDTH;
    }

    if (x1>=0&&x1+size<=SCREEN_WIDTH-1)
    {
      rect(x1, SCREEN_HEIGHT-size, size, size);
    } else
    {
      rect(x1, SCREEN_HEIGHT-size, SCREEN_WIDTH-x1, size);
      rect(0, SCREEN_HEIGHT-size, x1-(SCREEN_WIDTH-size), size);
    }

    x1 = x1 + 3;
    if (x1>SCREEN_WIDTH - 1)
    {
      x1=0;
    }
    fill(BLACK);
    textFont(font);
    textAlign(CENTER,CENTER);
    int timePassed = (millis()-start) / 1000;
    if(timePassed<=10)
    {      
      text("Loading...  Time: " + timePassed  + " seconds", SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }
    else
    {
      text("Loading...  Time: " + timePassed  + " seconds\nSeems like you are loading a 2 GB dataset\nThis will require around 1-3 minutes. Percentage loaded: " + round(percentageLoaded) +"\n", SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }
  }
}
