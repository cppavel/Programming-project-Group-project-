// a class used for storing different information or displaying the information that is to be displayed on screen
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class, but it is based on a class in the lecture slides. 
//[PAVEL]
//Fixed bugs there, which were mainly related to entering the user data on the graph screen.
//[Brian]
//Implemented the Barchart into the graphScreen
//---------------------------------------------------------------------------------------------------------------------------------------------------
class Screen{  
 ArrayList<Widget> widgetList = new ArrayList<Widget>();
  private Widget chooseLineGraph, chooseCandleGraph, chooseBarChart;
  private Widget chooseOpen, chooseClose, chooseAdjClose, chooseHigh, chooseLow, chooseVolume, chooseDiff;
  color backgroundColour;
  color strokeColour = BLACK;
  private CandleGraph candleGraph;
  private LineGraph lineGraph;
  private Barchart barChart;
  TickerList tickerList;
  private Slider slider;
  int dataType;
  String graphDescriptions;
  Text text;
  
  Screen(color backgroundColour){
    this.backgroundColour = backgroundColour;
  }
  
  void addText(Text text){
    this.text = text;
  }
  
  void addWidget(Widget widget){
    widgetList.add(widget);
  }
  
  int[] getEvent(int mX, int mY){
    int event = EVENT_NULL;
    for (int i = 0; i < widgetList.size(); i++){
      event = widgetList.get(i).getEvent(mX, mY)[EVENT];
      if (event != EVENT_NULL)
        return new int[]{event,widgetList.get(i).id};
    }
    if (tickerList != null && tickerList.getEvent(mX, mY)[EVENT] != EVENT_NULL){
      return tickerList.getEvent(mX, mY);
    }
    if (slider != null){
      if (slider.getEvent(mX, mY)[EVENT] != EVENT_NULL){
        return slider.getEvent(mX, mY);
      }
    }
    if (chooseLineGraph != null && chooseLineGraph.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseLineGraph.getEvent(mX, mY);
    }
    if (chooseCandleGraph != null && chooseCandleGraph.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseCandleGraph.getEvent(mX, mY);
    }
    if (chooseBarChart != null && chooseBarChart.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseBarChart.getEvent(mX, mY);
    }
    if (chooseOpen != null && chooseOpen.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseOpen.getEvent(mX, mY);
    }
    if (chooseClose != null && chooseClose.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseClose.getEvent(mX, mY);
    }
    if (chooseAdjClose != null && chooseAdjClose.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseAdjClose.getEvent(mX, mY);
    }
    if (chooseHigh != null && chooseHigh.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseHigh.getEvent(mX, mY);
    }
    if (chooseLow != null && chooseLow.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseLow.getEvent(mX, mY);
    }
    if (chooseVolume != null && chooseVolume.getEvent(mX, mY)[EVENT] != EVENT_NULL) {
      return chooseVolume.getEvent(mX, mY);
    }   
    if(chooseDiff != null&& chooseDiff.getEvent(mX, mY)[EVENT] != EVENT_NULL &&chooseBarChart.widgetColor == LIGHT_GRAY_1){
      return chooseDiff.getEvent(mX, mY);
    }
    return new int[]{ EVENT_NULL, ID_NULL};
  }
  
  Widget searchWidgetByEventAndId(int event, int id)
  {
    for(int i = 0 ;i <widgetList.size(); i++)
    {
      if(widgetList.get(i).event == event&&widgetList.get(i).id==id)
      {
        return widgetList.get(i);
      }
    }
    
    return null;
  }
  
  void setAllTextBoxFocusFalse()
  {
    for(int i = 0; i < this.widgetList.size();i++)
    {
      if(widgetList.get(i) instanceof TextBox)
       {
        ((TextBox) widgetList.get(i)).focus = false;
       }
    }
    
  }
  
  void draw(){
        background(backgroundColour);
    if (tickerList != null){
      tickerList.draw();
    }
    for (Widget widget : widgetList){
      if (strokeColour != BLACK){
        stroke(strokeColour);
      }
      widget.draw();
    }
    if (candleGraph != null){
      candleGraph.draw();
    }
    else if (lineGraph != null){
      lineGraph.draw();
    }
    else if (barChart != null){
      barChart.draw();
    }
    else if (text != null){
     text.draw();
    }
    
    if (slider != null){
      slider.draw();
    }
    if (chooseLineGraph != null) {
      chooseLineGraph.draw();
    }
    if (chooseCandleGraph != null) {
      chooseCandleGraph.draw();
    }
    if (chooseBarChart != null) {
      if(chooseBarChart.widgetColor == LIGHT_GRAY_1)
      {
        chooseDiff.draw();
      }
      chooseBarChart.draw();
    }
    if (chooseOpen != null) {
      chooseOpen.draw();
    }
    if (chooseClose != null) {
      chooseClose.draw();
    }
    if (chooseAdjClose != null) {
      chooseAdjClose.draw();
    }
    if (chooseHigh != null) {
      chooseHigh.draw();
    }
    if (chooseLow != null) {
      chooseLow.draw();
    }
    if (chooseVolume != null) {
      chooseVolume.draw();
    }
    
  }
  
}
