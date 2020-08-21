// A class that contains ways of updating the contents of the graphs on any screen
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I implemented the changeCandleGraph(), changeLineGraph(), changeBarchart(), moveSliderPointer(), generateGraph(), changeTickerList(),
// chooseDataType(), chooseBarChart(), chooseCandleGraph(), chooseLineGraph() and the initGraphScreen() methods
//
//[PAVEL]
//Minor change related to the data loading process. Initially all the data was loaded at the start of the program, 
//now it is loaded when it is required to compute a query, so the class was changed accordingly
//
//[Brian]
//added to the methods relating to barchart and fixed some bugs
//---------------------------------------------------------------------------------------------------------------------------------------------------
class ScreenManipulator{
  private boolean chosenCandleGraph = false;
  private boolean chosenBarChart = false;
  private boolean chosenLineGraph = false;
  
  void changeCandleGraph(Screen screen, ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> filteredStockData = new ArrayList<DataPoint>(StockInfoManipulator.filterByDates(stockData, screen.slider.fromDate, screen.slider.toDate));
    screen.candleGraph = new CandleGraph
    (
      filteredStockData,
      TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE,
      TICKER_LIST_HEIGHT,
      SCREEN_WIDTH-(2*TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE),
      int(SCREEN_HEIGHT-3.5*TICKER_LIST_HEIGHT),
      "",ID_NULL
    );
    screen.lineGraph = null;
    screen.barChart = null;
  }
  
  void changeLineGraph(Screen screen, ArrayList<DataPoint> stockData) {
     ArrayList<DataPoint> filteredStockData = new ArrayList<DataPoint>(StockInfoManipulator.filterByDates(stockData, screen.slider.fromDate, screen.slider.toDate));
    screen.lineGraph = new LineGraph
    (
      TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE,
      TICKER_LIST_HEIGHT,
      SCREEN_WIDTH-(2*TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE),
      int(SCREEN_HEIGHT-3.5*TICKER_LIST_HEIGHT),
      screen.dataType,
      filteredStockData
    );
    screen.candleGraph = null;
    screen.barChart = null;
  }
  
  void changeBarchart (Screen screen, ArrayList<DataPoint> stockData){
   ArrayList<DataPoint> filteredStockData = new ArrayList<DataPoint>(StockInfoManipulator.filterByDates(stockData, screen.slider.fromDate, screen.slider.toDate));
   screen.barChart = new Barchart
   (
     screen.tickerList.getSelectedTickers(),
     filteredStockData,
     TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE,
     TICKER_LIST_HEIGHT,
     SCREEN_WIDTH-(2*TICKER_LIST_WIDTH+DEFAULT_SCROLL_BAR_SIZE),
     int(SCREEN_HEIGHT-3.5*TICKER_LIST_HEIGHT),
     ID_NULL, screen.dataType);
     screen.candleGraph = null;
     screen.lineGraph = null;
  }
  
  
  void moveSliderPointer(Screen screen, int id, int mX){
    switch(id){
      case SLIDER_LEFT:{
        if (screen.slider != null){
          screen.slider.moveLeftSlider(mX);
        }
        break;
      }
      case SLIDER_RIGHT:{
        if (screen.slider != null) {
          screen.slider.moveRightSlider(mX);
        }
        break;
      }
    }
  }
  
  void generateGraph(Screen screen, ArrayList<DataPoint> stockData){
    //data comes already filtered by ticker
    
    if (chosenLineGraph) {
      changeLineGraph(screen, stockData);
      screen.candleGraph = null;
      screen.barChart = null;
      
    }
    else if (chosenCandleGraph) {
      changeCandleGraph(screen, stockData);
      screen.lineGraph = null;
      screen.barChart = null;
      screen.chooseLineGraph.widgetColor = GRAY;
      screen.chooseCandleGraph.widgetColor = LIGHT_GRAY_1;
      screen.chooseBarChart.widgetColor = GRAY;
    }
    else if (chosenBarChart) {
      changeBarchart(screen, stockData);
      screen.lineGraph = null;
      screen.candleGraph = null;
      screen.chooseLineGraph.widgetColor = GRAY;
      screen.chooseCandleGraph.widgetColor = GRAY;
      screen.chooseBarChart.widgetColor = LIGHT_GRAY_1;
    }
  }
  
  void changeTickerList(Screen screen, int id){
    screen.tickerList = null;
    switch(id){
      case TICKER: {
        screen.tickerList = new TickerList(tickers); break;
      }
      case OPEN_CLOSE_DIFF: {
        screen.tickerList = new TickerList(sortedTickers.get(id-2)); break;
      }
      default:{
        screen.tickerList = new TickerList(sortedTickers.get(id-1));
      }
    }
  }
  
  void chooseDataType(int dataType, Screen screen){
    screen.chooseOpen.widgetColor = GRAY;
    screen.chooseClose.widgetColor = GRAY;
    screen.chooseAdjClose.widgetColor = GRAY;
    screen.chooseHigh.widgetColor = GRAY;
    screen.chooseLow.widgetColor = GRAY;
    screen.chooseVolume.widgetColor = GRAY;
    screen.chooseDiff.widgetColor = GRAY;
    
    switch(dataType){
      case OPEN_PRICE:{
        screen.chooseOpen.widgetColor = LIGHT_GRAY_1;
        break;
      }
      case CLOSE_PRICE:{
        screen.chooseClose.widgetColor = LIGHT_GRAY_1;
        break;
      }
      case ADJUSTED_CLOSE:{
        screen.chooseAdjClose.widgetColor = LIGHT_GRAY_1;
        break;
      }
      case HIGH:{
        screen.chooseHigh.widgetColor = LIGHT_GRAY_1;
        break;
      }
      case LOW:{
        screen.chooseLow.widgetColor = LIGHT_GRAY_1;
        break;
      }
      case VOLUME:{
        screen.chooseVolume.widgetColor = LIGHT_GRAY_1;
        break;
      } 
      case OPEN_CLOSE_DIFF:{
        screen.chooseDiff.widgetColor = LIGHT_GRAY_1;
        break;
      }
    }
    
    screen.dataType = dataType;
    
  }
  
  void chooseCandleGraph(Screen screen){
    if(screen.dataType == OPEN_CLOSE_DIFF)
    {
      screen.dataType = 0;
    }
    screen.tickerList.reset();
    chosenCandleGraph = true;
    chosenBarChart = false;
    chosenLineGraph = false;
    screen.chooseLineGraph.widgetColor = GRAY;
    screen.chooseCandleGraph.widgetColor = LIGHT_GRAY_1;
    screen.chooseBarChart.widgetColor = GRAY;
  }
  
  void chooseLineGraph(Screen screen){
    if(screen.dataType == OPEN_CLOSE_DIFF)
    {
      screen.dataType = 0;
    }
    screen.tickerList.reset();
    chosenCandleGraph = false;
    chosenBarChart = false;
    chosenLineGraph = true;
    screen.chooseLineGraph.widgetColor = LIGHT_GRAY_1;
    screen.chooseCandleGraph.widgetColor = GRAY;
    screen.chooseBarChart.widgetColor = GRAY;
  }
  
  void chooseBarChart(Screen screen){
    chosenCandleGraph = false;
    chosenBarChart = true;
    chosenLineGraph = false;
    screen.chooseLineGraph.widgetColor = GRAY;
    screen.chooseCandleGraph.widgetColor = GRAY;
    screen.chooseBarChart.widgetColor = LIGHT_GRAY_1;
  }
  
  void updateSlider(Screen screen, ArrayList<DataPoint> stockData)
  {
    if(stockData.size()>0)
      screen.slider = new Slider(2*TICKER_LIST_WIDTH, int(SCREEN_HEIGHT-1.75*TICKER_LIST_HEIGHT), TICKER_LIST_WIDTH*8, SLIDER_POINTER_SIZE, GRAY, GRAY, LIGHT_GRAY_1, stockData);
  }
  
  // generate the contents of the graph screen
  void initGraphScreen(Screen graphScreen, ArrayList<String> tickers){
    // Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int id)
    Widget backButton = new Widget(0, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "<", LIGHT_GRAY_1, stdFont, EVENT_CHANGE_SCREEN, ID_NULL);
    graphScreen.chooseOpen = new Widget(3*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "OPEN", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, OPEN_PRICE);
    graphScreen.chooseClose = new Widget(4*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "CLOSE", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, CLOSE_PRICE);
    graphScreen.chooseAdjClose = new Widget(5*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "ADJ. CLOSE", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, ADJUSTED_CLOSE);
    graphScreen.chooseHigh = new Widget(6*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "HIGH", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, HIGH);
    graphScreen.chooseLow = new Widget(7*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "LOW", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, LOW);
    graphScreen.chooseVolume = new Widget(8*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "VOLUME", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, VOLUME);
    graphScreen.chooseDiff =  new Widget(9*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "OPEN/CLOSE DIFF", GRAY, stdFont, EVENT_CHOSE_DATA_TYPE, OPEN_CLOSE_DIFF);
    
    Widget selectDateBackground = new Widget(0, int(SCREEN_HEIGHT-2.5*TICKER_LIST_HEIGHT), SCREEN_WIDTH, int(2.5*TICKER_LIST_HEIGHT), "", WHITE, stdFont, EVENT_NULL, ID_NULL);
    Widget selectDateRange = new Widget(11*TICKER_LIST_WIDTH, int(SCREEN_HEIGHT-1.75*TICKER_LIST_HEIGHT), int(1.2*TICKER_LIST_WIDTH), TICKER_LIST_HEIGHT, "GENERATE GRAPH", GREEN, stdFont, EVENT_GENERATE_GRAPH, ID_NULL);
    Widget chooseText = new Widget(TICKER_LIST_WIDTH, 0, 2*TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "Choose Data Type To Display: ", WHITE, stdFont, EVENT_NULL, ID_NULL);
    
    Widget sortText = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "Sort Tickers By: ", WHITE, stdFont, EVENT_NULL, ID_NULL);
    Widget sortOpen = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 2*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "OPEN", WHITE, stdFont, EVENT_TICKER_LIST_SORT, OPEN_PRICE);
    Widget sortClose = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 3*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "CLOSE", WHITE, stdFont, EVENT_TICKER_LIST_SORT, CLOSE_PRICE);
    Widget sortAdjClose = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 4*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "ADJ. CLOSE", WHITE, stdFont, EVENT_TICKER_LIST_SORT, ADJUSTED_CLOSE);
    Widget sortHigh = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 5*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "HIGH", WHITE, stdFont, EVENT_TICKER_LIST_SORT, HIGH);
    Widget sortLow = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 6*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "LOW", WHITE, stdFont, EVENT_TICKER_LIST_SORT, LOW);
    Widget sortVolume = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 7*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "VOLUME", WHITE, stdFont, EVENT_TICKER_LIST_SORT, VOLUME);
    Widget sortOpenCloseDiff = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 8*TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "OPEN/CLOSE DIFF", WHITE, stdFont, EVENT_TICKER_LIST_SORT, OPEN_CLOSE_DIFF);
    Widget selectGraph = new Widget(SCREEN_WIDTH-4*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "Choose graph: ", WHITE, stdFont, EVENT_NULL, ID_NULL);
    
    graphScreen.addWidget(backButton);
    graphScreen.addWidget(selectDateBackground);
    graphScreen.addWidget(selectDateRange);
    graphScreen.addWidget(chooseText);
    graphScreen.addWidget(sortText);
    graphScreen.addWidget(sortOpen);
    graphScreen.addWidget(sortClose);
    graphScreen.addWidget(sortAdjClose);
    graphScreen.addWidget(sortHigh);
    graphScreen.addWidget(sortLow);
    graphScreen.addWidget(sortVolume);
    graphScreen.addWidget(sortOpenCloseDiff);
    graphScreen.addWidget(selectGraph);
    
    graphScreen.chooseLineGraph = new Widget(SCREEN_WIDTH-3*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "LINE GRAPH", GRAY, stdFont, EVENT_LINE_GRAPH, ID_NULL);
    graphScreen.chooseCandleGraph = new Widget(SCREEN_WIDTH-TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "CANDLE GRAPH", GRAY, stdFont, EVENT_CANDLE_GRAPH, ID_NULL);
    graphScreen.chooseBarChart = new Widget(SCREEN_WIDTH-2*TICKER_LIST_WIDTH, 0, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "BAR CHART", GRAY, stdFont, EVENT_BAR_CHART, ID_NULL);
    
    graphScreen.tickerList = new TickerList(tickers);
    
    Text graphDescription = new Text("Welcome to the graph generator." + "\n" + "\nLineGraph:" + "\nDisplays the volume of the dataType that is selected on the y-axis and the date range specified on the x axis."
    + "\n" + "\nBarChart:" + "\nDisplays the average between the date range specified of the dataType selected of each tickers selected." + "\n" + "\nCandleGraph:" +
    "\nDisplays the opening and close price of a ticker in the specified date range." + "\nThe candle is green when the close price is higher than the opening price and is red when the close price is"
    + "\nlower than the opening price." + "\nThe vertical lines of the candle indicate the peak and lowest point of that day.", SCREEN_WIDTH/2, SCREEN_HEIGHT/2, TEXT_NO_ROTATE);
    
    graphScreen.addText(graphDescription);
  }
  
}
