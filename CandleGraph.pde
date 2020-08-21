// [Enda]
// This class stores all of the candles and draws the candle graph including the dates on the x-axis and values on the y-axis
class CandleGraph extends Widget{

  private ArrayList<Candle> candles;
  private ArrayList<Text> yAxisText = new ArrayList<Text>();
  private Text xAxisText;
  
  private float cornerX;
  private float cornerY;
  private float graphWidth;
  private float graphHeight;
  private float graphHorizontalSize;
  private float graphVerticalSize;
  
  CandleGraph(ArrayList<DataPoint> stockData, int id) {
    super(SCREEN_WIDTH-CANDLE_GRAPH_WIDTH, 0, CANDLE_GRAPH_WIDTH, CANDLE_GRAPH_HEIGHT, "", WHITE, stdFont, EVENT_CANDLE_GRAPH, id);
    graphWidth = CANDLE_GRAPH_WIDTH;
    graphHeight = CANDLE_GRAPH_HEIGHT;
    cornerX = x + graphWidth*((1-CANDLE_WIDTH_RATIO)/2);
    cornerY = y + graphHeight*(1-5*(1-CANDLE_HEIGHT_RATIO)/8);
    graphHorizontalSize = graphWidth*CANDLE_WIDTH_RATIO;
    graphVerticalSize = graphHeight*CANDLE_HEIGHT_RATIO;
    candles = generateContents(stockData);
  }
  
  CandleGraph(ArrayList<DataPoint> stockData, float x, float y, float graphWidth, float graphHeight, String label, int id) {
    super(int(x),int(y),int(graphWidth),int(graphHeight),label,WHITE,stdFont,EVENT_CANDLE_GRAPH, id);
    this.graphWidth = graphWidth;
    this.graphHeight = graphHeight;
    cornerX = x + graphWidth*((1-CANDLE_WIDTH_RATIO)/2);
    cornerY = y + graphHeight*(1-5*(1-CANDLE_HEIGHT_RATIO)/8);
    graphHorizontalSize = graphWidth*CANDLE_WIDTH_RATIO;
    graphVerticalSize = graphHeight*CANDLE_HEIGHT_RATIO;
    candles = generateContents(stockData);
  }
  
  @Override
  void draw() {
    stroke(BLACK);
    fill(LIGHT_GRAY_1);
    rect(x, y, graphWidth, graphHeight);
    
    fill(WHITE);
    noStroke();
    rect(cornerX, cornerY, graphHorizontalSize, -graphVerticalSize);
    
    // graph grey horizontal lines
    stroke(GRAY);
    for (int i = 1; i <= CANDLE_YAXIS_SECTIONS; i++){
      float gap = (float(i) / CANDLE_YAXIS_SECTIONS) * graphVerticalSize;
      line(cornerX, cornerY - gap, cornerX+graphHorizontalSize, cornerY - gap);
    }
    
    // graph black outline
    stroke(BLACK);
    line(cornerX, cornerY, cornerX+graphHorizontalSize, cornerY);
    line(cornerX, cornerY, cornerX, cornerY-graphVerticalSize);
    
    // candles
    for (Candle candle : candles) {
      candle.draw();
    }
    
    fill(BLACK);
    
    textAlign(LEFT, CENTER);
    
    xAxisText.draw();
    
    textAlign(CENTER, CENTER);
    
    for (Text text : yAxisText) {
      text.draw();
    }
    textAlign(BASELINE);
  }

  ArrayList<Candle> generateContents(ArrayList<DataPoint> stockData) {
    ArrayList<Candle> candleArray = new ArrayList<Candle>();
    if (stockData.size() > 0){
      float maxHighValue = DataPointSort.byHighAbs(stockData).get(0).high;
      float minLowValue = DataPointSort.byLowAbs(stockData).get(stockData.size()-1).low;
      
      ArrayList<DataPoint> sortedStockArray = StockInfoManipulator.sortByDate(stockData);
      
      float gap = 0;
      float offset = 0;
      if ((sortedStockArray.size()-1) > 0) {
        gap = graphHorizontalSize / (sortedStockArray.size()-1);
        offset  = float(CANDLE_WIDTH) / (sortedStockArray.size()-1);
      }
      else{
        gap = graphHorizontalSize / sortedStockArray.size();
        offset = float(CANDLE_WIDTH) / sortedStockArray.size();
      }
      
      // generate candles
      for (int i = 0; i < sortedStockArray.size(); i++) {
        float candleY1Pos = map(sortedStockArray.get(i).high(), minLowValue, maxHighValue, 0, graphVerticalSize);
        float candleY2Pos = map(sortedStockArray.get(i).low(), minLowValue, maxHighValue, 0, graphVerticalSize);
        float openCloseDiff = sortedStockArray.get(i).openPrice - sortedStockArray.get(i).closePrice;
        float candleHeight = map(openCloseDiff, 0, maxHighValue, 0, graphVerticalSize);
        float blockY = map(sortedStockArray.get(i).openPrice(), minLowValue, maxHighValue, 0, graphVerticalSize);
        float blockX = gap*i;
        
        candleArray.add(new Candle(openCloseDiff, cornerY-candleY1Pos, cornerY-candleY2Pos, cornerX+blockX-(offset*i), cornerY-blockY, candleHeight));
       
      }
      
      //generate x axis text for candle graph
      
      xAxisText = new Text("Time range: " + stockData.get(0).date.toString() +" - " + stockData.get(stockData.size()-1).date.toString()+"\nTicker: "+
       stockData.get(0).ticker+companyInfoListHashed.get(stockData.get(0).ticker).textRepresentation(),
         cornerX  ,y+ graphHeight - 2.5f*(graphHeight - graphVerticalSize)/8,TEXT_NO_ROTATE);
   
      
      // generate y axis text for candle graph
      for (int i = 0; i <= CANDLE_YAXIS_SECTIONS; i++) {
        String outputString = String.format("%.2f", ((float(i) / CANDLE_YAXIS_SECTIONS) * maxHighValue));
        yAxisText.add(
        new Text(
          ("$" + outputString),
          cornerX-(cornerX-x)/2,
          cornerY - (float(i) / CANDLE_YAXIS_SECTIONS) * graphVerticalSize,
          TEXT_NO_ROTATE
          )
        );
      }
    }
    return candleArray;
  } 
}
