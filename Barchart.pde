/*
Brian:
Created and maintained the barchart class
*/


//class that implements a barchart graph for the data demostration
class Barchart extends Widget {
  /*
  notes{

  }
   tickerList = The list of tickers to be displayed on barChart
   barChartData = The datapoint arraylist to be displayed
   x = the top right x-coordinant of the graph, actual graph displayed is offset a little to make room for text
   y = the top right y-coordinant of the graph, actual graph displayed is offset a little to make room for text
   graphWidth = the max width of the graph but there is an empty margin on both sides for aesthetic
   graphHeight = the max width of the graph but there is an empty margin on both sides for aesthetic
   dataType = the type of data from the datapoints to be displayed
   
   */

  int dataType, barMaxLength, barX, barY, textOffset, graphWidth, graphHeight, lineOffset;
  float barLength, highestValue, barWidth;
  ArrayList<DataPoint> barChartDataPoints;
  PFont font;
  color colour;
  ArrayList<Text> graphText;
  ArrayList<String> tickers;
  Boolean openCloseGraph;

  Barchart(ArrayList<String> tickerList,ArrayList<DataPoint> barChartData, int x, int y, int graphWidth, int graphHeight, int id, int dataType) {
    super(int(x), int(y), int(graphWidth), int(graphHeight), "", WHITE, stdFont, EVENT_BARCHART, id);
    this.dataType = dataType;
    this.graphWidth = graphWidth;
    this.graphHeight = graphHeight;
    textOffset = 30;
    tickers = new ArrayList<String>(tickerList);
    graphText = new ArrayList<Text>();
    barChartDataPoints = StockInfoManipulator.sortByDate(barChartData);
    lineOffset = 60;
    barMaxLength = graphHeight - (lineOffset*2);
    highestValue = getHighestAverage(tickerList, barChartDataPoints, dataType);
    if(dataType!=OPEN_CLOSE_DIFF)
    {
      openCloseGraph = false;   
    }
    else
    {
      openCloseGraph = true;
    }
    labels(barChartDataPoints);
  }

  @Override
    void draw() {
    fill(LIGHT_GRAY_2);
    rect(x, y, graphWidth, graphHeight);
    
    fill(WHITE);
    rect(x + lineOffset, y + lineOffset, graphWidth - (lineOffset*2), graphHeight - (lineOffset*2));

    fill(BLACK);
    line((x + lineOffset), (y + graphHeight - lineOffset), (x + graphWidth - lineOffset), (y + graphHeight - lineOffset)); // X-axis
    line((x + lineOffset), (y + graphHeight - lineOffset), (x + lineOffset), (y + lineOffset));    // Y-axis
    drawLabels();
    drawBarsByTickers(tickers, barChartDataPoints, dataType);
  }

  //draws the bars when multiple tickers are chosen of the graph
  void drawBarsByTickers(ArrayList<String> tickers, ArrayList<DataPoint> graphDataPoints, int dataType) {
    
    if(tickers.size()*35 > graphWidth - (lineOffset*2))
    {
      barWidth = (graphWidth - (lineOffset*2)) / (tickers.size() - 1);
    }
    else{
      barWidth = 35;
    }
    
    float leftSpace = (graphWidth - (lineOffset*2)) - barWidth*tickers.size();
    
    float barOffset = leftSpace/(tickers.size() - 1);
        
    if (!openCloseGraph)
    {
      for (int b = 0; b < tickers.size(); b++) {    
        String ticker = tickers.get(b);       
        barLength = (StockInfoManipulator.getAverage(graphDataPoints, ticker, dataType)/ highestValue) * barMaxLength;
        float barX = (x + lineOffset) + (barWidth+barOffset)*b;
        float barY = (y + graphHeight - lineOffset) - barLength;
        Text tickerText = new Text(ticker, (barX + (barWidth/2)), y + graphHeight - lineOffset + textOffset, TEXT_NO_ROTATE);
        fill(CYAN);
        stroke(BLACK);
        rect(barX, barY, BAR_WIDTH, barLength);
        fill(BLACK);
        textAlign(CENTER,CENTER);
        tickerText.draw();
      }
    } else {
      for (int b = 0; b < tickers.size(); b++) {     
        String ticker = tickers.get(b);
        float diff  = (StockInfoManipulator.getAverage(graphDataPoints, ticker, dataType)/ highestValue) * barMaxLength;
        barLength = abs(diff);
        float barX = (x + lineOffset) + (barWidth+barOffset)*b;
        float barY = (y + graphHeight - lineOffset) - barLength;
        Text tickerText = new Text(ticker, (barX + (barWidth/2)), y + graphHeight - lineOffset + textOffset, TEXT_NO_ROTATE);
        if (diff >= 0)
        {
          fill(GREEN);
        } else
        {
          fill(RED);
        }
        stroke(BLACK);
        rect(barX, barY, BAR_WIDTH, barLength);
        fill(BLACK);
        textAlign(CENTER,CENTER);
        tickerText.draw();
      }
    }
  }
  void labels(ArrayList<DataPoint> barChartDataPoints) {
    //y-axis labels
    for (int i = 0; i <= 10; i++) {
      
      String Ytext = "";
      if(dataType!=VOLUME&&dataType!=OPEN_CLOSE_DIFF)
      {
        Ytext = String.format("%.2f", (highestValue/10)*i);
        Ytext+="$";
      }
      else if(dataType == VOLUME)
      {
        Ytext = String.format("%.1e", (highestValue/10)*i);
      }
      else
      {
        Ytext = String.format("%.4f", (highestValue/10)*i);
      }
      int xpos = x + lineOffset - textOffset;
      int ypos = (y + graphHeight - lineOffset) - ((barMaxLength/10)*i);
      graphText.add(new Text(Ytext, xpos, ypos, TEXT_NO_ROTATE));
    }
    
    String dataTypeText = "";
    switch(dataType){
     case OPEN_PRICE:
     dataTypeText = "Open price";
     break;      
     case CLOSE_PRICE:
     dataTypeText = "Close price";
     break; 
     case ADJUSTED_CLOSE:
     dataTypeText = "Adjusted close";
     break; 
     case LOW:
     dataTypeText = "Lowest price";
     break;     
     case HIGH:
     dataTypeText = "Highest price";
     break;      
     case VOLUME:
     dataTypeText = "Volume";
     break;      
     case OPEN_CLOSE_DIFF:
     dataTypeText = "Relative open close difference";
     break;      
    
    }
    
    String description = "Time range: " + barChartDataPoints.get(0).date.toString() +" - " + barChartDataPoints.get(barChartDataPoints.size()-1).date.toString()+" Averages graph of " + dataTypeText; 
      
    graphText.add(new Text(description, (x + (graphWidth/2)), y + lineOffset-textOffset, TEXT_NO_ROTATE));
  }
  
    void drawLabels(){
    for (int i = 0; i < graphText.size(); i++) {
      Text label = graphText.get(i);
      label.draw();
    }
    fill(GRAY);
    for(int i = 0; i <= 9; i++)
    {
      Text label = graphText.get(i);
      float xpos = label.getX() + textOffset;
      float ypos = label.getY();
      line(xpos, ypos, x + graphWidth - lineOffset, ypos);
    }
  }

  //Gets the highest average of a ticker from a DataPoints ArrayList
  float getHighestAverage(ArrayList<String> tickerList, ArrayList<DataPoint> barChartDataPoints, int dataType) {
    float highestAverage = 0;
    for (int i = 0; i < tickerList.size(); i++) {
      float average = StockInfoManipulator.getAverage(barChartDataPoints, tickerList.get(i), dataType);
      if(dataType==OPEN_CLOSE_DIFF)
      {
        average = abs(average);
      }
      if (highestAverage < average) {
        highestAverage = average;
      }
    }
    return highestAverage;
  }
  
  
}
