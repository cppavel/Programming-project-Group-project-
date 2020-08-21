//class which implements an option for a seachbar
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I created and maintained that class
//---------------------------------------------------------------------------------------------------------------------------------------------------
class SearchBarOption extends Widget
{
  
  int value; 
  
  SearchBarOption(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int value, int id) 
  {
    super(x,y,width,height,label,widgetColor, widgetFont,event, id);
    super.isOffScreen = false;
    this.value = value;
  }
  
  int[] getEvent(int mX, int mY)
  {
      if (mX >=x && mX <= x+width && mY >=y && mY <=y+height)
      {
          return new int[] {event, id};
      }
      
    return new int[] {EVENT_NULL, ID_NULL};
  }
  
  void draw()
  {
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(labelColor);
    textAlign(LEFT,CENTER);
    text(" "+label, x, y,width,height);
  }
}
