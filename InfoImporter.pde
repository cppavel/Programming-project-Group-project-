//Class that reads the data from .csv files and rewrited it into multiple .txt files by ticker
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class and implemented the getData() and getCompanyInformation() methods. The getData() method was later improved by Pavel.
//[PAVEL]
//Here I created getData() and loadData() methods. We could not store all the data from to 2GB file in the program at the same time, so I decided to parse it into files by ticker and then get the particular tickers when neccessary.
//---------------------------------------------------------------------------------------------------------------------------------------------------
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

// A class that stores ways of getting information from the two different types of files

class InfoImporter 
{
  ArrayList<DataPoint> getData(ArrayList<String> tickers) {

    
    ArrayList<DataPoint> dataPoints = new ArrayList<DataPoint>();
    for (int i = 0; i<tickers.size(); i++)
    {
   
        BufferedReader reader = createReader("TickerFiles\\"+tickers.get(i)+".txt");

        String line = "";
        boolean isFinished = false;

        //this will just make sure that the header row gets ignored
        try {
          line = reader.readLine();
        } 
        catch (IOException e) {
          e.printStackTrace();
          line = null;
        }

        while (!isFinished) {
          try {
            line = reader.readLine();
          } 
          catch (IOException e) {
            e.printStackTrace();
            line = null;
          }
          if (line == null) {

            isFinished = true;
          } else 
          { 
            String[] info = split(line, ",");
            String[] dateStrings = split(info[DATE], "-");

            dataPoints.add(
              new DataPoint( info[TICKER], Float.parseFloat(info[OPEN_PRICE]), Float.parseFloat(info[CLOSE_PRICE]), Float.parseFloat(info[ADJUSTED_CLOSE]), 
              Float.parseFloat(info[LOW]), Float.parseFloat(info[HIGH]), Integer.parseInt(info[VOLUME]), new Date(dateStrings[YEAR], dateStrings[MONTH], dateStrings[DAY]))
              );
          }
        }
    }
    
    return dataPoints;
  }


  ArrayList<String> loadData(String fileName) throws Exception
  {

    int numberOfLinesRead = 0;
    
    long start = System.nanoTime();

    BufferedReader reader = createReader(fileName);
    boolean isFinished = false;

    ArrayList<String> tickers = new ArrayList<String>();


    HashMap<String, PrintWriter> writers = new HashMap<String, PrintWriter>();

    HashMap<String, Integer> counts = new HashMap<String, Integer>();

    ArrayList<HashMap<String, Float>> averages = new ArrayList<HashMap<String, Float>>();

    //adding hashmaps for every value
    for (int i = 0; i < 7; i++)
    {
      averages.add(new HashMap<String, Float>());
    }

    String line;

    try 
    {
      line = reader.readLine();
    } 
    catch (IOException e) 
    {
      e.printStackTrace();
      line = null;
    }    
    while (!isFinished) 
    {
      try 
      {
        line = reader.readLine();
      } 
      catch (IOException e) 
      {
        e.printStackTrace();
        line = null;
      }
      if (line == null) 
      {
        isFinished = true;
      } 
      else 
      {
        String[] info = line.split(",");
        String ticker = info[TICKER];
        float openPrice = Float.parseFloat(info[OPEN_PRICE]);
        float closePrice = Float.parseFloat(info[CLOSE_PRICE]);
        float adjClose = Float.parseFloat(info[ADJUSTED_CLOSE]);
        float low = Float.parseFloat(info[LOW]);
        float high = Float.parseFloat(info[HIGH]);
        float volume = Float.parseFloat(info[VOLUME]);
        float openCloseDiff = closePrice - openPrice;

        if (ticker.equals("PRN"))
        {
          ticker = PRN;
        }

        if (writers.containsKey(ticker))
        {

          PrintWriter br = writers.get(ticker);
          br.write(line+"\n");
        } else
        {
          tickers.add(ticker);
          PrintWriter cur = createWriter("TickerFiles\\"+ticker+".txt");
          writers.put(ticker, cur);
          cur.write(line+"\n");
        }

        if (counts.containsKey(ticker))
        {
          counts.put(ticker, counts.get(ticker) + 1);
        } else
        {
          counts.put(ticker, 1);
        }

        int count = counts.get(ticker);

        if (averages.get(OPEN_PRICE-1).containsKey(ticker))
        {       
          averages.get(OPEN_PRICE-1).put(ticker, (openPrice + averages.get(OPEN_PRICE-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(OPEN_PRICE-1).put(ticker, openPrice);
        }

        if (averages.get(CLOSE_PRICE-1).containsKey(ticker))
        {             
          averages.get(CLOSE_PRICE-1).put(ticker, (closePrice + averages.get(CLOSE_PRICE-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(CLOSE_PRICE-1).put(ticker, closePrice);
        }

        if (averages.get(ADJUSTED_CLOSE-1).containsKey(ticker))
        {         
          averages.get(ADJUSTED_CLOSE-1).put(ticker, (adjClose + averages.get(ADJUSTED_CLOSE-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(ADJUSTED_CLOSE-1).put(ticker, adjClose);
        }

        if (averages.get(LOW-1).containsKey(ticker))
        {             
          averages.get(LOW-1).put(ticker, (low + averages.get(LOW-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(LOW-1).put(ticker, closePrice);
        }

        if (averages.get(HIGH-1).containsKey(ticker))
        {             
          averages.get(HIGH-1).put(ticker, (high+ averages.get(HIGH-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(HIGH-1).put(ticker, closePrice);
        }

        if (averages.get(VOLUME-1).containsKey(ticker))
        {             
          averages.get(VOLUME-1).put(ticker, (volume + averages.get(VOLUME-1).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(VOLUME-1).put(ticker, closePrice);
        }

        // -2 is because of the constants and the way data is stored in files
        if (averages.get(OPEN_CLOSE_DIFF-2).containsKey(ticker))
        {             
          averages.get(OPEN_CLOSE_DIFF-2).put(ticker, (openCloseDiff + averages.get(OPEN_CLOSE_DIFF-2).get(ticker)*(count-1))/count);
        } else
        {
          averages.get(OPEN_CLOSE_DIFF-2).put(ticker, closePrice);
        }
        
        percentageLoaded = (100.0*numberOfLinesRead)/numberOfLinesIn2GBFile;
        numberOfLinesRead++;
      }
    }


    for (PrintWriter br : writers.values())
    {
      br.close();
    }

    ArrayList<Pair<String, Float>> tickersSortedByAvgValues;

    for (int i = 1; i <= averages.size(); i++)
    {

      tickersSortedByAvgValues = new ArrayList<Pair<String, Float>>();
      for (int j = 0; j<tickers.size(); j++)
      {
        tickersSortedByAvgValues.add(new Pair(tickers.get(j), averages.get(i-1).get(tickers.get(j))));
      }
      Collections.sort(tickersSortedByAvgValues, new Comparator<Pair<String, Float>>() {
        @Override
          public int compare(final Pair<String, Float> o1, final Pair<String, Float> o2) 
        {
          if (o1.getValue()<o2.getValue())
          {
            return -1;
          } else if (o1.getValue()>o2.getValue())
          {
            return 1;
          } else
          {
            return 0;
          }
        }
      }
      );
      ArrayList<String> sortedBySpecificValue = new ArrayList<String>();
      for (int j = 0; j<tickersSortedByAvgValues.size(); j++)
      {
        sortedBySpecificValue.add(tickersSortedByAvgValues.get(j).getKey());
      }

      sortedTickers.add(sortedBySpecificValue);
    }

    long end = System.nanoTime();

    println("Elapsed time: " + (end-start)*1.0/1e9);


    return tickers;
  }

  ArrayList<CompanyInfo> getCompanyInformation(String fileName) 
  {
    BufferedReader reader = createReader(fileName);
    ArrayList<CompanyInfo> companyInformation = new ArrayList<CompanyInfo>();
    String line = "";
    boolean isFinished = false;
    while (!isFinished) {
      try {
        line = reader.readLine();
      } 
      catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
      if (line == null) {
        isFinished = true;
      } else {
        String otherThanQuote = " [^\"] ";
        String quotedString = String.format(" \" %s* \" ", otherThanQuote);
        String regex = String.format("(?x) "+ // enable comments, ignore white spaces
          ",                         "+ // match a comma
          "(?=                       "+ // start positive look ahead
          "  (?:                     "+ //   start non-capturing group 1
          "    %s*                   "+ //     match 'otherThanQuote' zero or more times
          "    %s                    "+ //     match 'quotedString'
          "  )*                      "+ //   end group 1 and repeat it zero or more times
          "  %s*                     "+ //   match 'otherThanQuote'
          "  $                       "+ // match the end of the string
          ")                         ", // stop positive look ahead
          otherThanQuote, quotedString, otherThanQuote);
        String[] tokens = line.split(regex, -1);

        for (int i = 0; i < tokens.length; i++) {
          if (tokens[i].charAt(0) == '"') {
            tokens[i] = tokens[i].substring(1, tokens[i].length() - 1);
          }
        }

        companyInformation.add(new CompanyInfo(tokens[TICKER], tokens[EXCHANGE], tokens[NAME], tokens[SECTOR], tokens[INDUSTRY]));
      }
    }
    return companyInformation;
  }
}
