// A class that contains variuous ways of manipulating and getting information from the stock data
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class and implemented most of the methods
//[PAVEL]
//Fixed bugs and optimized code (in sortings particularly). By that I mean suggesting an idea of using the in-built java sortings with custom comparators.
//[Brian]
//Implemented the methods that dealt with queries getAverge, getListofTickers and percentageDifference.
//---------------------------------------------------------------------------------------------------------------------------------------------------
static class StockInfoManipulator {
  
  static ArrayList<String> parseTickers(ArrayList<DataPoint> stockData) {
    ArrayList<String> stockNames = new ArrayList<String>();
    for (int i = 0; i < stockData.size(); i++) {
      stockNames.add(stockData.get(i).ticker());
    }
    return sortStockTickersAscending(removeDuplicateTickers(stockNames));
  }
  
  static ArrayList<String> parseExchanges(ArrayList<CompanyInfo> companyInfo){
    ArrayList<String> exchanges = new ArrayList<String>();
    
    for (int i = 0; i < companyInfo.size(); i++){
      boolean hasAppeared = false;
      for (int j = 0; j < exchanges.size(); j++){
        if (companyInfo.get(i).exchange.contentEquals(exchanges.get(j))){
          hasAppeared = true;
        }
      }
      if (!hasAppeared && !(companyInfo.get(i).exchange.contentEquals("exchange"))){
        exchanges.add(companyInfo.get(i).exchange);
      }
    }
    return exchanges;
  }
  
   static ArrayList<String> parseTickersAbs(ArrayList<DataPoint> stockData) {
    ArrayList<String> stockNames = new ArrayList<String>();
    for (int i = 0; i < stockData.size(); i++) {
      stockNames.add(stockData.get(i).ticker());
    }
    return removeDuplicateTickers(stockNames);
  }
  
    static ArrayList<Date> parseDates(ArrayList<DataPoint> stockData){
    ArrayList<Date> dates = new ArrayList<Date>();
    ArrayList<DataPoint> sortedStockInfo = sortByDate(stockData);
    dates.add(sortedStockInfo.get(0).date);
    for(int i = 1; i < sortedStockInfo.size(); i++){
      boolean hasAppeared = false;
      for (int j = 0; j < dates.size() && !hasAppeared; j++){
        if (sortedStockInfo.get(i).date.toString().contentEquals(dates.get(j).toString())){
          hasAppeared = true;
          break;
        }
      }
      if (!hasAppeared){
        dates.add(sortedStockInfo.get(i).date);
      }
    }
    return dates;
  }
  
  static ArrayList<String> removeDuplicateTickers(ArrayList<String> stockNames) {
    ArrayList<String> tickers = stockNames;
    for (int i = 0; i < tickers.size(); i++) {
      for (int j = i+1; j < tickers.size(); j++) {
        if (tickers.get(i).contentEquals(tickers.get(j))) {
          tickers.remove(j);
          j--;
        }
      }
    }
    
    return tickers;
  }
  
  static ArrayList<DataPoint> filterByExchange(ArrayList<DataPoint> stockData, ArrayList<CompanyInfo> companyInfo, String exchange){
    ArrayList<String> tickers = parseTickers(stockData);
    
    // filter out stocks that are not on the selected exchange
    for(int i = 0; i < tickers.size(); i++){
      for (int j = 0; j < companyInfo.size(); j++){
        if(tickers.get(i).contentEquals(companyInfo.get(j).ticker)){
          if (!(companyInfo.get(j).exchange.contentEquals(exchange))){
            tickers.remove(i);
            if (i > 0) {
              --i;
            }
          }
        }
      }
    }
    
    return filterByTickers(stockData, tickers);
  }
  
    static ArrayList<DataPoint> sortByTickers(ArrayList<DataPoint> stockData) {
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>();
    ArrayList<String> tickers = parseTickers(stockData);
    for (int i = 0; i < tickers.size(); i++) {
      ArrayList<DataPoint> temp = filterByTickers(stockData, tickers.get(i));
      for (int j = 0; j < temp.size(); j++) {
        sortedStockData.add(temp.get(j));
      }
    }
    return sortedStockData;
  }
  
  // the input requires for stockData to be sorted by tickerList
  static ArrayList<String> tickersHighestAvgVolume(ArrayList<DataPoint> stockData){
    ArrayList<String> tickers = parseTickers(stockData);
    ArrayList<Float> averages = new ArrayList<Float>(tickers.size());
    
    // get averages for each stock ticker group
    for (int i = tickers.size()-1; i >= 0; i--){
      ArrayList<DataPoint> temp = filterByTickers(stockData, tickers.get(i));
      int totalVolume = 0;
      for (int j = 0; j < temp.size(); j++){
        totalVolume += temp.get(j).volume();
      }
      averages.add(averages.size(), float(totalVolume) / temp.size());
    }
    
    // sort the stock tickers based on highest volume
    for (int i = 0; i < tickers.size(); i++) {
      for (int j = i; j < tickers.size(); j++) {
        if (averages.get(i) < averages.get(j)) {
          Collections.swap(averages, i, j);
          Collections.swap(tickers, i, j);
        }
      }
    }
    // [Enda]: remove these when the visualisation is implemented!
    //for (int i = 0; i < tickers.size(); i++){
     // println(tickers.get(i) + "'s average volume = " + averages.get(i));
    //}
    
    ArrayList<String> output = new ArrayList<String>();
    for(int i = 0 ; i<tickers.size();i++)
    {
      output.add("ticker: " + tickers.get(i)+ " average volume:" + averages.get(i));
    }
    
    return output;
  }
  
  // the input requires for stockData to be sorted by tickerList
  static ArrayList<String> tickersHighestVolume(ArrayList<DataPoint> stockData){
    ArrayList<String> tickers = parseTickers(stockData);
    ArrayList<Float> highestVolumes = new ArrayList<Float>(tickers.size());
    ArrayList<DataPoint> sortedStockData = sortByVolume(stockData);
    
    for (int i = tickers.size()-1; i >= 0; i--){
      ArrayList<DataPoint> temp = sortByVolumeAbs(filterByTickers(sortedStockData, tickers.get(i)));
      highestVolumes.add(temp.get(0).volume());
    }
    
    for (int i = 0; i < tickers.size(); i++) {
      for (int j = i; j < tickers.size(); j++) {
        if (highestVolumes.get(i) < highestVolumes.get(j)) {
          Collections.swap(highestVolumes, i, j);
          Collections.swap(tickers, i, j);
        }
      }
    }
    // [Enda]: remove these when the visualisation is implemented!
    //for (int i = 0; i < tickers.size(); i++){
      //println(tickers.get(i) + "'s highest ever volume = " + highestVolumes.get(i));
    //}
    
    return tickers;
  }
  
  // sorts by volume and keeps the tickers grouped
  static ArrayList<DataPoint> sortByVolume(ArrayList<DataPoint> stockList){
    ArrayList<String> tickers = parseTickers(stockList);
    ArrayList<DataPoint> sortedData = new ArrayList<DataPoint>();
    for (int i = tickers.size()-1; i >= 0; i--){
      ArrayList<DataPoint> temp = sortByVolumeAbs(filterByTickers(stockList, tickers.get(i)));
      for (int j = 0; j < temp.size(); j++){
        sortedData.add(temp.get(j));
      }
    }
    return sortedData;
  }

  // sorts by volume and does not retain the order of tickers
  static ArrayList<DataPoint> sortByVolumeAbs(ArrayList<DataPoint> stockList){
    return DataPointSort.byVolumeAbs(stockList);
  }
  
  static void printStockInfo(ArrayList<DataPoint> stockData) {
    for (int i = 0; i < stockData.size(); i++) {
      print((i+1) + ". ");
      stockData.get(i).printInfo();
    }
  }

  static void printStockInfoOnScreen(ArrayList<DataPoint> stockData) {
    for (int i = 0; i < stockData.size(); i++) {
      stockData.get(i).printInfoOnScreen(i*10);
    }
  }

  static void printStockTickers(ArrayList<String> tickers) {
    for (int i = 0; i < tickers.size(); i++) {
      println(tickers.get(i));
    }
  }

  static ArrayList<String> sortStockTickersAscending(ArrayList<String> tickers) {
    ArrayList<String> sortedTickers = new ArrayList<String>(tickers);
    Collections.sort(sortedTickers);         
    return sortedTickers;
  }

  static ArrayList<String> sortStockTickersDescending(ArrayList<String> tickers) {
    ArrayList<String> sortedTickers = tickers;
    Collections.sort(sortedTickers, Collections.reverseOrder());         
    return sortedTickers;
  }

// removes all DataPoints not within date range in argument list
  static ArrayList<DataPoint> filterByDates(ArrayList<DataPoint> stockData, Date startDate, Date endDate) {
    ArrayList<DataPoint> filteredStockData = sortByDate(stockData);
    
    int startDateInt = startDate.toInt();
    int endDateInt = endDate.toInt();
    
    for (int i = 0; filteredStockData.get(i).date.toInt() < startDateInt;) {
      filteredStockData.remove(i);
    }
    
    for (int i = filteredStockData.size()-1; filteredStockData.get(i).date.toInt() > endDateInt;) {
      filteredStockData.remove(i);
      if (i > 0){
         --i;
      }
    }
    
    return filteredStockData;
  }
  
    // removes all DataPoints that are not in the list of tickers provided
  static ArrayList<DataPoint> filterByTickers(ArrayList<DataPoint> stockInfo, ArrayList<String> tickers) {
    ArrayList<DataPoint> filteredStockData = new ArrayList<DataPoint>(stockInfo);
    Collections.copy(filteredStockData, stockInfo);
    for (int i = 0; i < filteredStockData.size(); i++) {
      boolean hasAppeared = false;
      for (int j = 0; j < tickers.size(); j++) {
        if (filteredStockData.get(i).ticker().contentEquals(tickers.get(j))) {
          hasAppeared = true;
        }
      }
      if (!hasAppeared) {
        filteredStockData.remove(i);
        i--;
      }
    }
    return filteredStockData; //<>//
  }

// same functionality as the other filterByTickers but for a single ticker
  static ArrayList<DataPoint> filterByTickers(ArrayList<DataPoint> stockInfo, String ticker) {
    ArrayList<DataPoint> filteredStockData = new ArrayList<DataPoint>(stockInfo);
    Collections.copy(filteredStockData, stockInfo);
    for (int i = 0; i < filteredStockData.size(); i++) {
      boolean hasAppeared = false;
      if (filteredStockData.get(i).ticker().contentEquals(ticker)) {
        hasAppeared = true;
      }
      if (!hasAppeared) {
        filteredStockData.remove(i);
        i--;
      }
    }
    return filteredStockData;
  }

  static ArrayList<DataPoint> sortByDate(ArrayList<DataPoint> stockData) {
    ArrayList<DataPoint> sortedStockData = new ArrayList<DataPoint>(stockData);
    int arraySize = sortedStockData.size();
    for (int i = 0; i < arraySize; i++) {
      for (int j = i; j < arraySize; j++) {
        if (sortedStockData.get(i).date.toInt() > sortedStockData.get(j).date.toInt()) {
          Collections.swap(sortedStockData, i, j);
        }
      }
    }
    return sortedStockData;
  }

  static ArrayList<DataPoint> sortByYear(ArrayList<DataPoint> stockData) {
    ArrayList<DataPoint> sortedStockData = stockData;
    for (int i = 0; i < sortedStockData.size(); i++) {
      for (int j = i+1; j < sortedStockData.size(); j++) {
        if (Integer.parseInt(sortedStockData.get(i).date.year()) > Integer.parseInt(sortedStockData.get(j).date.year())) {
          Collections.swap(sortedStockData, i, j);
        }
      }
    }
    return sortedStockData;
  }

  static ArrayList<DataPoint> sortByMonth(ArrayList<DataPoint> stockData) {
    ArrayList<DataPoint> sortedStockData = stockData;
    for (int i = 0; i < sortedStockData.size(); i++) {
      for (int j = i+1; j < sortedStockData.size(); j++) {
        if (Integer.parseInt(sortedStockData.get(i).date.month()) > Integer.parseInt(sortedStockData.get(j).date.month())) {
          Collections.swap(sortedStockData, i, j);
        }
      }
    }
    return sortedStockData;
  }

  static ArrayList<DataPoint> sortByDay(ArrayList<DataPoint> stockData) {
    ArrayList<DataPoint> sortedStockData = stockData;
    for (int i = 0; i < sortedStockData.size(); i++) {
      for (int j = i+1; j < sortedStockData.size(); j++) {
        if (Integer.parseInt(sortedStockData.get(i).date.day()) > Integer.parseInt(sortedStockData.get(j).date.day())) {
          Collections.swap(sortedStockData, i, j);
        }
      }
    }
    return sortedStockData;
  }

  // return the index of the lowest value of a DataPoint in an ArrayList
  static int maxValueIndex(int DATA_TYPE, ArrayList<DataPoint> stockData) {
    switch(DATA_TYPE) {
    case OPEN_PRICE: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).openPrice()) {
            max = stockData.get(i).openPrice();
            index = i;
          }
        }
        return index;
      }

    case CLOSE_PRICE: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).closePrice()) {
            max = stockData.get(i).closePrice();
            index = i;
          }
        }
        return index;
      }

    case ADJUSTED_CLOSE: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).adjustedClose()) {
            max = stockData.get(i).adjustedClose();
            index = i;
          }
        }
        return index;
      }

    case LOW: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).low()) {
            max = stockData.get(i).low();
            index = i;
          }
        }
        return index;
      }

    case HIGH: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).high()) {
            max = stockData.get(i).high();
            index = i;
          }
        }
        return index;
      }

    case VOLUME: {
        int index = 0;
        float max = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (max < stockData.get(i).volume()) {
            max = stockData.get(i).volume();
            index = i;
          }
        }
        return index;
      }
    default: 
      return -1;
    }
  }

  static int minValueIndex(int DATA_TYPE, ArrayList<DataPoint> stockData) {
    switch(DATA_TYPE) {
    case OPEN_PRICE: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).openPrice()) {
            min = stockData.get(i).openPrice();
            index = i;
          }
        }
        return index;
      }

    case CLOSE_PRICE: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).closePrice()) {
            min = stockData.get(i).closePrice();
            index = i;
          }
        }
        return index;
      }

    case ADJUSTED_CLOSE: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).adjustedClose()) {
            min = stockData.get(i).adjustedClose();
            index = i;
          }
        }
        return index;
      }

    case LOW: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).low()) {
            min = stockData.get(i).low();
            index = i;
          }
        }
        return index;
      }

    case HIGH: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).high()) {
            min = stockData.get(i).high();
            index = i;
          }
        }
        return index;
      }

    case VOLUME: {
        int index = 0;
        float min = 0;
        for (int i = 0; i < stockData.size(); i++) {
          if (min > stockData.get(i).volume()) {
            min = stockData.get(i).volume();
            index = i;
          }
        }
        return index;
      }
      
    default: 
      return -1;
    }
  }
  
  //takes DataPoint arraylist and trims it to the two dates passed and sorts it chronologically
  static ArrayList<DataPoint> trimBetweenDates(ArrayList<DataPoint> stockData, Date startDate, Date endDate){
    ArrayList<DataPoint> trimmedStockData = stockData;
    for (int i = 0; i < trimmedStockData.size(); i++){
      if (trimmedStockData.get(i).date().yearNum() < startDate.yearNum() || trimmedStockData.get(i).date().yearNum() > endDate.yearNum()){
        trimmedStockData.remove(i);
      }
      else if (trimmedStockData.get(i).date().yearNum() == startDate.yearNum() || trimmedStockData.get(i).date().yearNum() == endDate.yearNum()){
        if (trimmedStockData.get(i).date().yearNum() == startDate.yearNum() && trimmedStockData.get(i).date().monthNum() < startDate.monthNum()){
          trimmedStockData.remove(i);
        }
        else if (trimmedStockData.get(i).date().yearNum() == endDate.yearNum()){
          trimmedStockData.remove(i);
        }
        else if (trimmedStockData.get(i).date().monthNum() == startDate.monthNum() || trimmedStockData.get(i).date().monthNum() == endDate.monthNum()){
          if (trimmedStockData.get(i).date().monthNum() == startDate.monthNum() && trimmedStockData.get(i).date().dayNum() < startDate.dayNum()){
            trimmedStockData.remove(i);
          }
          else if (trimmedStockData.get(i).date().monthNum() == endDate.monthNum() && trimmedStockData.get(i).date().dayNum() > endDate.dayNum()){
            trimmedStockData.remove(i);
          }
        }
      }
    }
    trimmedStockData = sortByDate(trimmedStockData);
    return trimmedStockData;
  }
  
  //converts a onstant which represents a typ of information into a string 
  static String convertConstantToString(int constant){
    switch(constant){  
      case TICKER:
        return "Ticker";
      case OPEN_PRICE:
        return "Open Price";
      case CLOSE_PRICE:
        return "Close Price";
      case ADJUSTED_CLOSE:
        return "Adjusted Close Price";
      case LOW:
        return "Low";
      case HIGH:
        return "High";
      case VOLUME:
        return "Volume";
      case DATE:
        return "Date";
      default: return "";
    }
  }
  
  static float getAverage(ArrayList<DataPoint> stockData, String ticker, int dataType){
   float totalSum = 0;
   float average = 0;
   ArrayList<DataPoint> dataPoints = StockInfoManipulator.filterByTickers(stockData, ticker);
   switch(dataType){
     case OPEN_PRICE:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.openPrice();
        }
        average = totalSum/dataPoints.size();
        return average;
        
        case CLOSE_PRICE:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.closePrice();
        }
        average = totalSum/dataPoints.size();
        return average;
        
        case ADJUSTED_CLOSE:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.adjustedClose();
        }
        average = totalSum/dataPoints.size();
        return average;
        
        case LOW:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.low();
        }
        average = totalSum/dataPoints.size();
        return average;
        
        case HIGH:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.high();
        }
        average = totalSum/dataPoints.size();
        return average;
        
     case VOLUME:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.volume();
        }
        average = totalSum/dataPoints.size();
        return average;
     case OPEN_CLOSE_DIFF:
        for(int i = 0; i < dataPoints.size(); i++){
          DataPoint dataPoint = dataPoints.get(i);
          totalSum = totalSum + dataPoint.openCloseDiff();
        }
        average = totalSum/dataPoints.size();
        return average;
        
        default: return 0;
   }
   
  }

  //this method creates a list of the tickers present in a DataPoint ArrayList
  static ArrayList<String> getListOfTickers(ArrayList<DataPoint> dataPoints)
  {
    ArrayList<String> tickersList = new ArrayList<String>();
  // adds the first ticker
   DataPoint initial = dataPoints.get(0);
   tickersList.add(initial.ticker());
   for (int k = 1; k < dataPoints.size(); k++){
     DataPoint data = dataPoints.get(k);
     boolean newTicker = true;
     for( int a = 0; a < tickersList.size(); a++)
     {
       String ticker = tickersList.get(a);
       if (ticker.contentEquals(data.ticker())){
         newTicker = false;
       }
     }
     if (newTicker)
     {
       tickersList.add(data.ticker());
     }
   }
   return tickersList;
    
  }
   //gets the percentage increase of the closing price compared to its opening price
  static ArrayList<Float> percentageDifference(ArrayList<DataPoint> stockDataPoints){
    ArrayList<Float> percentages = new ArrayList<Float>();
    for (int i = 0; i < stockDataPoints.size(); i++){
        DataPoint data = stockDataPoints.get(i);
        float percentage = (data.closePrice - data.openPrice())/data.openPrice();
        percentages.add(percentage);
    }
    return percentages;
  }
  
}
