/* this class take in a set of paramaters which would be where the graph starts on the x and y axis
  the width and height of the graph, the type of information to be shown, the ticker to be shown the arraylist of datapoints and the start date and end date
  the class uses this information and them when draw is called creates a linegraph between the start and end date and between the max and min value of the 
  type of information passed */
// [Filip]
//
// [Enda]
// I adjusted the class to bring the design close match the final design. I updated the calculatePoints() method to include more values along the y-axis

class LineGraph extends Widget{
  int x, y, width, height, typeOfInformation;
  ArrayList<Float> yValues = new ArrayList<Float>();
  ArrayList<Float> xDates = new ArrayList<Float>();
  private Text xAxisText;
  private ArrayList<Text> yAxisText = new ArrayList<Text>();
  float minYValue;
  float maxYValue;
  private float cornerX;
  private float cornerY;
  private float graphHorizontalSize;
  private float graphVerticalSize;
  
  LineGraph(int x, int y, int width, int height, int typeOfInformation, ArrayList<DataPoint> stockData){
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.typeOfInformation = typeOfInformation;
    
    cornerX = x + width*((1-LINE_GRAPH_WIDTH_RATIO)/2);
    cornerY = y + height*(1-5*(1-LINE_GRAPH_HEIGHT_RATIO)/8);
    graphHorizontalSize = width*LINE_GRAPH_WIDTH_RATIO;
    graphVerticalSize = height*LINE_GRAPH_HEIGHT_RATIO;
    
    calculatePoints(typeOfInformation, stockData);
  }
  
  void calculatePoints(int typeOfInformation, ArrayList<DataPoint> stockData){
    if (stockData != null && stockData.size() > 0) {
      ArrayList<DataPoint> sortedStockArrayByDate = StockInfoManipulator.sortByDate(stockData); //<>//
      ArrayList<DataPoint> sortedStockArray = DataPointSort.by(typeOfInformation, stockData);
      
      maxYValue = (float)sortedStockArray.get(0).get(typeOfInformation);
      float gap = 0;
      if ((sortedStockArray.size()-1) > 0) {
        gap = graphHorizontalSize / (sortedStockArray.size()-1);
      }
      else gap = graphHorizontalSize / sortedStockArray.size();
      
      for (int i = 0; i < stockData.size(); i++) {
        float yValue = map(sortedStockArrayByDate.get(i).get(typeOfInformation), 0, maxYValue, 0, graphVerticalSize);
        this.yValues.add(cornerY - yValue);
        this.xDates.add(cornerX+(gap*i));       
      }
      
      xAxisText = new Text("Time range: " + stockData.get(0).date.toString() +" - " + stockData.get(stockData.size()-1).date.toString()+"\nTicker: "+
       stockData.get(0).ticker+companyInfoListHashed.get(stockData.get(0).ticker).textRepresentation(),
         cornerX  ,y+ height - 2.5f*(height - graphVerticalSize)/8,TEXT_NO_ROTATE);
      
      for (int i = 0; i <= CANDLE_YAXIS_SECTIONS; i++) {
        String outputString = "";
        if (!(typeOfInformation == VOLUME)){
          outputString = "$";
        }
        outputString += String.format("%.2f", ((float(i) / CANDLE_YAXIS_SECTIONS) * maxYValue));
        
        yAxisText.add(
        new Text(
          outputString,
          cornerX-(cornerX-x)/2,
          cornerY - (float(i) / CANDLE_YAXIS_SECTIONS) * graphVerticalSize,
          TEXT_NO_ROTATE
          )
        );
      }
    }
  }
  
  @Override
  void draw(){
    fill(LIGHT_GRAY_1);
    rect(x, y, width, height);

    fill(WHITE);
    noStroke();
    rect(cornerX, cornerY, graphHorizontalSize, -graphVerticalSize);
    stroke(BLACK);
    fill(BLACK);
    
    // black x and y axis
    line(cornerX, cornerY, cornerX+graphHorizontalSize, cornerY);
    line(cornerX, cornerY, cornerX, cornerY-graphVerticalSize);
    
    // gray horizontal lines
    stroke(GRAY);
    for (int i = 1; i <= CANDLE_YAXIS_SECTIONS; i++){
      float gap = (float(i) / CANDLE_YAXIS_SECTIONS) * graphVerticalSize;
      line(cornerX, cornerY - gap, cornerX+graphHorizontalSize, cornerY - gap);
    }
    
    // draw points and lines
    stroke(BLACK);
    for(int i = 0; i < xDates.size()-1; i++){
      circle(xDates.get(i), yValues.get(i), 4);
      line(xDates.get(i), yValues.get(i), xDates.get(i+1), yValues.get(i+1));
    }
    if (xDates.size() > 0 && yValues.size() > 0) {
      circle(xDates.get(xDates.size()-1), yValues.get(yValues.size()-1), 4);
    }
    
    
    textAlign(CENTER, CENTER);
    // draw y axis text
    for (Text text : yAxisText) {
      text.draw();
    }
    
    textAlign(LEFT, CENTER);
    // draw x axis text
    xAxisText.draw();
    
  }
}
