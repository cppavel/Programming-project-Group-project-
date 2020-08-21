// A class to represent the date of a stock
// [Enda]
// I made this class along with the return methods apart from the toString() method
class Date{
  private String year;
  private String month;
  private String day;
  
  Date(){
    year = "";
    month = "";
    day = "";
  }
  
  Date(String year, String month, String day){
    this.year = year;
    this.month = month;
    this.day = day;
  }
  
  String year(){
    return year;
  }
  
  String month(){
    return month;
  }
  
  String day(){
    return day;
  }
  
  Date date(){
    return this;
  }
  
  int yearNum(){
    return Integer.parseInt(year);
  }
  
  int monthNum(){
    return Integer.parseInt(month);
  }
  
  int dayNum(){
    return Integer.parseInt(day);
  }
  
  int toInt(){
    String date = String.valueOf(year+month+day);
    return Integer.parseInt(date);
  }
  
  String toString()
  {
    return year +"/"+ month + "/" + day;
  }
  
}
