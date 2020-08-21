//A simple class for the Scroll bar UI control
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I created that class
//---------------------------------------------------------------------------------------------------------------------------------------------------
class ScrollBar extends Widget
{
  Widget barPointer;
  
  ScrollBar(int x, int y, int width, int height, int scrollerSize, color widgetColor, PFont widgetFont, int event, color barColor, int id)
  {
    super(x,y,width,height,"",widgetColor,widgetFont,event,id);
    barPointer = new Widget(x,y,width, scrollerSize,"",barColor, widgetFont, event, id);
  }
  
  int getValue()
  {
    return (int)(this.barPointer.y - this.y);
  }
  
  float getNormalizedValue()
  {
    return getValue()*1.0/(this.height-this.barPointer.height);
  }
    
  @Override
  void draw() {
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    this.barPointer.draw();
  }
 
}
