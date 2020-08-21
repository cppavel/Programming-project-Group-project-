//a simple widget class

//was probably modified by everybody at some point of time

class Widget {
  int x, y, width, height;
  String label; 
  int event;
  int id;
  color widgetColor, labelColor;
  color strokeColour = BLACK;
  PFont widgetFont;
  boolean isOffScreen;
  
  Widget() {
    this.x = 0; 
    this.y = 0; 
    this.width = 0; 
    this.height = 0;
    this.label = ""; 
    this.event = EVENT_NULL;
    this.widgetColor = WHITE; 
    this.widgetFont = stdFont;
    labelColor= BLACK;
    this.id = ID_NULL;
    isOffScreen = true;
  }
  
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int id) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
    this.id = id;
    isOffScreen = ((y+height < 0 || y > SCREEN_HEIGHT) || (x+width < 0 || x > SCREEN_WIDTH));
  }
  
  void draw() {
    if (!isOffScreen){
      textAlign(CENTER, CENTER);
      stroke(strokeColour);
      fill(widgetColor);
      rect(x, y, width, height);
      fill(labelColor);
      textFont(widgetFont);
      text(label, x+width/2, y+height/2);
    }
  }
  
  int[] getEvent(int mX, int mY)
  {
    if (!isOffScreen){
      if (mX >=x && mX <= x+width && mY >=y && mY <=y+height) {
          return new int[] {event, id};
      }
    }
    return new int[] {EVENT_NULL, ID_NULL};
  }
  
  void setStrokeColour(color newStrokeColour){
    strokeColour = newStrokeColour;
  }
  
  void setX(int x){
    this.x = x;
    isOffScreen = (x+width < 0 || x > SCREEN_WIDTH);
  }
  
  void setY(int y){
    this.y = y;
    isOffScreen = (y+height < 0 || y > SCREEN_HEIGHT);
  }
  
  void setColor(color newColor){
    widgetColor = newColor;
  }
  
  void setLabel(String label){
    this.label = label;
  }
  
}
