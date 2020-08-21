//simple class which implements a textbox (for entering text data)
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I created and maintained that class
//---------------------------------------------------------------------------------------------------------------------------------------------------
class TextBox extends Widget
{
  int maxLength;
  int remainder = 0;
  boolean focus = false;
  TextBox(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int maxLength, int id)
  {
    super(x,y,width,height,label,widgetColor, widgetFont,event, id);
    this.maxLength = maxLength;
  }   
  
  void append(char s)
  {
    if(s==BACKSPACE)
    {
        if(!label.equals(""))
          label=label.substring(0,label.length()-1);
    }
    else if (label.length() <maxLength)
    { 
      label=label+str(s);      
    }    
  }
  
  @Override
  void draw()
  {
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    
    textAlign(LEFT, CENTER);
    fill(BLACK);
    textFont(widgetFont);
    if(remainder<=DEFAULT_TEXTBOX_TICK_RATE/2&&focus)
    {
      this.label = this.label + "|";
    }
    text(label, x, y , width, height);
    if(remainder<=DEFAULT_TEXTBOX_TICK_RATE/2&&focus)
    {
      label=label.substring(0,label.length()-1);
    }
    remainder = (remainder +1)%DEFAULT_TEXTBOX_TICK_RATE;
    
  
  }
  
}
