// This class provides a slider that has two pointers which can select dates from a given range.
// [Enda]
// I developed this class
class Slider extends Widget{
  private Widget leftPointer;
  private Widget rightPointer;
  private Widget sliderBackground;
  private Text fromText;
  private Text toText;
  Date fromDate;
  Date toDate;
  ArrayList<Date> dates = new ArrayList<Date>();
  
  Slider(int x, int y, int width, int height, color leftColor, color rightColor, color backgroundColor, ArrayList<DataPoint> stockData){
    super();
    sliderBackground = new Widget(x, y, width, height, "", backgroundColor, stdFont, EVENT_NULL, ID_NULL);
    leftPointer = new Widget(x, y, height, height, "", leftColor, stdFont, EVENT_SLIDER_POINTER, SLIDER_LEFT);
    rightPointer = new Widget(x + width-height, y, height, height, "", rightColor, stdFont, EVENT_SLIDER_POINTER, SLIDER_RIGHT);
    isOffScreen = ((y+height < 0 || y > SCREEN_HEIGHT) || (x+width < 0 || x > SCREEN_WIDTH));
    dates = StockInfoManipulator.parseDates(stockData);
    fromText = new Text(("From: " + dates.get(0).toString()), x + TICKER_LIST_WIDTH, y + TICKER_LIST_HEIGHT, TEXT_NO_ROTATE);
    toText = new Text(("To: " + dates.get(dates.size()-1).toString()), x + width - TICKER_LIST_WIDTH, y + TICKER_LIST_HEIGHT, TEXT_NO_ROTATE);
    fromDate = dates.get(0);
    toDate = dates.get(dates.size()-1);
  }
  
  @Override
  void draw(){
    sliderBackground.draw();
    leftPointer.draw();
    rightPointer.draw();
    fromText.draw();
    toText.draw();
  }
  
  @Override
  int[] getEvent(int mX, int mY){
    if ((mX >= leftPointer.x && mX <= leftPointer.x + leftPointer.width && mY >= leftPointer.y && mY <= leftPointer.y + leftPointer.height)){
      return new int[] {leftPointer.event, SLIDER_LEFT};
    }
    if ((mX >= rightPointer.x && mX <= rightPointer.x + rightPointer.width && mY >= rightPointer.y && mY <= rightPointer.y + rightPointer.height)){
      return new int[] {rightPointer.event, SLIDER_RIGHT};
    }
    return new int[] {EVENT_NULL, ID_NULL};
  }
  
  void moveLeftSlider(int mX){
    if ((mX >= sliderBackground.x + leftPointer.width/2) && (leftPointer.width/2 + leftPointer.x <= rightPointer.x)) {
      leftPointer.setX(mX - leftPointer.width/2);
      updateFromText();
    }
    else if (!(leftPointer.width/2 + leftPointer.x <= rightPointer.x)){
      leftPointer.x -= leftPointer.width/2;
    }
    if (rightPointer.x > sliderBackground.x+sliderBackground.width){
      rightPointer.x = sliderBackground.x+sliderBackground.width-(rightPointer.width/2);
    }
  }
  
  void moveRightSlider(int mX){
    if ((mX + rightPointer.width/2 <= sliderBackground.x + sliderBackground.width) && (rightPointer.width/2 + rightPointer.x >= leftPointer.x)) {
      rightPointer.setX(mX - rightPointer.width/2);
      updateToText();
    }
    else if (!(rightPointer.width/2 + rightPointer.x >= leftPointer.x)){
      rightPointer.x += rightPointer.width/2;
    }
    if (leftPointer.x < sliderBackground.x){
      leftPointer.x = sliderBackground.x;
    }
  }
  
  int getLeftPointerIndex(){
    return int(map(leftPointer.x, sliderBackground.x, sliderBackground.x+sliderBackground.width, 0, (dates.size()-1)));
  }
  
  int getRightPointerIndex(){
    return int(map(rightPointer.x+rightPointer.width, sliderBackground.x, sliderBackground.x+sliderBackground.width, 0, (dates.size()-1)));
  }
  
  void updateFromText(){
    int index = getLeftPointerIndex();
    if (index >= 0 && index < dates.size()) {
      fromText.setText("From: " + dates.get(index).toString());
    }
    fromDate = dates.get(index);
  }
  
  void updateToText(){
    int index = getRightPointerIndex();
    if (index >= 0 && index < dates.size()) {
      toText.setText("To: " + dates.get(index).toString());
    }
    toDate = dates.get(index);
  }
  
  /*
  ArrayList<DataPoint> getDatesInRange(){
    
  }
  */
  
}
