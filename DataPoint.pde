// This is the way we chose to store our data for a given data entry
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class but it is based on the DataPoint class shown in the lecture slides
//[PAVEL]
//Here I created one method convertToString()
//---------------------------------------------------------------------------------------------------------------------------------------------------

class DataPoint{
  private String ticker;
  private float openPrice;
  private float closePrice;
  private float adjustedClose;
  private float low;
  private float high;
  private float volume;
  private Date date;
  
  
  DataPoint(){
    this.ticker = "";
    this.openPrice = 0.0f;
    this.closePrice = 0.0f;
    this.adjustedClose = 0.0f;
    this.low = 0.0f;
    this.high = 0.0f;
    this.volume = 0;
    this.date = new Date("","","");
  }
  
   DataPoint(String ticker, float openPrice, float closePrice, float adjustedClose, float low, float high, float volume, Date date){
    this.ticker = ticker;
    this.openPrice = openPrice;
    this.closePrice = closePrice;
    this.adjustedClose = adjustedClose;
    this.low = low;
    this.high = high;
    this.volume = volume;
    this.date = date;
  }
  
 void printInfoOnScreen(int yOffset){
    textFont(stdFont);
    text(ticker + " " + openPrice + "" + closePrice + "" + adjustedClose + " " + low + " " + high + " " + volume + " " + date.year() + "/" + date.month() + "/" + date.day(), 10, yOffset);
  }
  
  void printInfo(){
    println(ticker, openPrice, closePrice, adjustedClose, low, high, volume, date.year(), date.month(), date.day());
  }
  
  String[] convertToString()
  {
    return new String[] {"number",ticker,openPrice + "",closePrice+ "", adjustedClose+ "", low+ "", high+ "", volume+ "", date.toString()};
  }
  
  String ticker(){
    return ticker;
  }
  
  float openPrice(){
    return openPrice;
  }
  
  float closePrice(){
    return closePrice;
  }
  
  float adjustedClose(){
    return adjustedClose;
  }
  
  float low(){
    return low;
  }
  
  float high(){
    return high;
  }
  
  float volume(){
    return volume;
  }
  
  float openCloseDiff(){
    return closePrice - openPrice;
  }
  
  Date date(){
    return date;
  }
  
  float get(int typeOfData){
    switch(typeOfData){
      case OPEN_PRICE:
      return openPrice;
      
      case CLOSE_PRICE:
      return closePrice;
      
      case ADJUSTED_CLOSE:
      return adjustedClose;
      
      case LOW:
      return low;
      
      case HIGH:
      return high;
      
      case VOLUME:
      return volume;
      
      case OPEN_CLOSE_DIFF:
      return closePrice-openPrice;
      
      default:
      return 0;
    }
  }
}
