// This is a class to represent some text and a position on screen. It was made to make creating and printing a large amount of text to the screen easier
// [Enda]
// I created this class
//[Brian]
//Added get methods
class Text{
  private String text;
  private float x, y;
  private boolean rotate;
  private boolean isOffScreen;
  
  Text(){
    text = "";
    x = 0;
    y = 0;
    rotate = TEXT_NO_ROTATE;
    isOffScreen = true;
  }
  
  Text(String text, float x, float y, boolean rotate){
    this.text = text;
    this.x = x;
    this.y = y;
    this.rotate = rotate;
    isOffScreen = ((y+height < 0 || y > SCREEN_HEIGHT) || (x+width < 0 || x > SCREEN_WIDTH));
  }
  
  void draw(){
    if (!isOffScreen){
      pushMatrix();
      translate(x, y);
      if (rotate){
        rotate(HALF_PI);
      }
      text(text, 0, 0);
      popMatrix();
    }
  }
  
  void setX(float x){
    this.x = x;
    isOffScreen = (x+width < 0 || x > SCREEN_WIDTH);
  }
  
  void setY(float y){
    this.y = y;
    isOffScreen = (y+height < 0 || y > SCREEN_HEIGHT);
  }
  
  void setText(String newText){
    text = newText;
  }
  float getX(){
   return x; 
  }
  float getY(){
   return y; 
  }
  String getText(){
   return text; 
  }
}
