// A class that contains ways of sorting the DataPoints by ticker, openPrice, closePrice, adjustedClose, low, high, volume, and open/close difference
// [Enda]
// I created this class after learning from Pavel that we could use a comparitor to make use of the Collections merge sort methods
// Before I would have to have made a merge sort method for every piece of data of the DataPoint(open price, close price etc.) 
import java.util.Comparator;
static class DataPointSort implements Comparator<DataPoint>{
  
  @Override
  public int compare(DataPoint d1, DataPoint d2){
    return 0;
  }
  
  private static Comparator<DataPoint> compareByOpen = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.openPrice(), d1.openPrice());
    }
  };  
  
  private static Comparator<DataPoint> compareByClose = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.closePrice(), d1.closePrice());
    }
  }; 
  
  private static Comparator<DataPoint> compareByAdjustedClose = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.adjustedClose(), d1.adjustedClose());
    }
  }; 
  
  private static Comparator<DataPoint> compareByLow = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.low(), d1.low());
    }
  }; 
  
  private static Comparator<DataPoint> compareByHigh = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.high(), d1.high());
    }
  }; 
  
  private static Comparator<DataPoint> compareByVolume = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare(d2.volume(), d1.volume());
    }
  };
  
  private static Comparator<DataPoint> compareByOpenCloseDiff = new Comparator<DataPoint>() {
    @Override
    public int compare(DataPoint d1, DataPoint d2) {
      return Float.compare((d2.closePrice()-d2.openPrice), (d1.closePrice()-d1.openPrice));
    }
  };
  
  public static ArrayList<DataPoint> byOpenPriceAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByOpen);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byOpenPrice(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byOpenPriceAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byClosePriceAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByClose);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byClosePrice(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byClosePriceAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byAdjustedClosePriceAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByAdjustedClose);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byAdjustedClosePrice(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byAdjustedClosePriceAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byLowAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByLow);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byLow(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byLowAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byHighAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByHigh);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byHigh(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byHighAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byVolumeAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByVolume);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byVolume(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byVolumeAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byOpenCloseDiffAbs(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    Collections.sort(sortedStockData, compareByOpenCloseDiff);
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> byOpenCloseDiff(ArrayList<DataPoint> stockData){
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byOpenCloseDiffAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  public static ArrayList<DataPoint> by(int DATA_TYPE, ArrayList<DataPoint> stockData){
    switch(DATA_TYPE){
      case TICKER:{
        return StockInfoManipulator.sortByTickers(stockData);
      }
      case OPEN_PRICE:{
        return byOpenPriceAbs(stockData);
      }
      case CLOSE_PRICE:{
        return byClosePriceAbs(stockData);
      }
      case ADJUSTED_CLOSE:{
        return byAdjustedClosePriceAbs(stockData);
      }
      case HIGH:{
        return byHighAbs(stockData);
      }
      case LOW:{
        return byLowAbs(stockData);
      }
      case VOLUME:{
        return byVolumeAbs(stockData);
      }
    }
    ArrayList<DataPoint> unsortedStockData = new ArrayList<DataPoint>(stockData);
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = StockInfoManipulator.parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++){
      ArrayList<DataPoint> temp = byOpenCloseDiffAbs(StockInfoManipulator.filterByTickers(unsortedStockData, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
}
