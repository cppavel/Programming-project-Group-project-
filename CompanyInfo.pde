// A class that stores the ticker, exchange, name, sector, and industry of a company
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class and provided methods that will return each of the Strings
//[PAVEL]
//Here I created two methods: convertToString() and textRepresentation(), also I implemented a Comparable Interface in that class to use Collections.sort with it
//---------------------------------------------------------------------------------------------------------------------------------------------------
class CompanyInfo implements Comparable<CompanyInfo> {
  private String ticker;
  private String exchange;
  private String name;
  private String sector;
  private String industry;
  
  CompanyInfo(){
    this.ticker = "";
    this.exchange = "";
    this.name = "";
    this.sector = "";
    this.industry = "";
  }
  
  CompanyInfo(String ticker, String exchange, String name, String sector, String industry){
    this.ticker = ticker;
    this.exchange = exchange;
    this.name = name;
    this.sector = sector;
    this.industry = industry;
  }
  
  void printInfo(){
    println(ticker + "," ,exchange + "," , name + ",", sector + ",", industry + ",");
  }
  
  String[] convertToString()
  {
    return new String[] {"number",ticker,exchange,name,sector,industry};
  }
  
  String textRepresentation()
  {
    return " Exchange: " + exchange + " Name: " + name + " Sector: " + sector + " Industry: " + industry;
  }
  
  String ticker(){
    return ticker;
  }
  
  String exchange(){
    return exchange;
  }
  
  String name(){
    return name;
  }
  
  String sector(){
    return sector;
  }
  
  String industry(){
    return industry;
  }
  @Override
   public int compareTo(CompanyInfo o) {
        return this.ticker.compareTo(o.ticker);
    }
  
}
