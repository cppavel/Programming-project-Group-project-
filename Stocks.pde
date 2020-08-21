//Main class
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//The class is mostly maintained by Pavel (file loading and data preprocessing, which are done in a separate thread; searchbar, textview and button events; loading screen initizialization).
//Pavel was also responsible for merging the versions and creating working demos to show at the labs
//
// [Enda]
// Created basic ArrayList declarations and assignments. I also created the mousePressed events for the graphScreen
//
//[Brian]
//Implemented the BarChart to the graphScreen
//---------------------------------------------------------------------------------------------------------------------------------------------------

// imports
import java.util.Collections;
import java.util.*;
import javafx.util.Pair;

//
int numberOfLinesIn2GBFile = 20900000;
float percentageLoaded = 0;

// Object declarations

//fonts
PFont stdFont;

//stockData

ArrayList<CompanyInfo> companyInfoList = new ArrayList<CompanyInfo>();
ArrayList<String> tickers = new ArrayList<String>();
ArrayList<String> exchanges = new ArrayList<String>();
ArrayList<String> sectors = new ArrayList<String>();
ArrayList<String> industries = new ArrayList<String>();

HashMap<String, CompanyInfo> companyInfoListHashed = new HashMap <String, CompanyInfo>();

ArrayList<ArrayList<String>> sortedTickers = new ArrayList<ArrayList<String>>();

ArrayList<DataPoint> stockData = new ArrayList<DataPoint>();


//importing info
InfoImporter infoGetter = new InfoImporter();

//screens
ScreenManipulator screenManipulator = new ScreenManipulator();
Screen screenOne, currentScreen, graphScreen;

//widgets, which need to be declated in stocks
TextBox focus;

//loaded flag

boolean loaded = false;

LoadingScreen lScreen;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  smooth(12);
  fullScreen();
}

void setup() 
{
  //not resizeable currently
  surface.setResizable(false);

  thread("setupAsync");
  
  lScreen = new LoadingScreen();
}

void setupAsync()
{
  // screen settings
  screenOne  = new Screen(GRAY);
  currentScreen = screenOne;

  stdFont = loadFont("YuGothicUI-Semibold-14.vlw");

  textFont(stdFont, 12);
  fill(BLACK);

  // import information
  try
  {
    tickers = infoGetter.loadData("daily_prices2GB.csv");
  }
  catch(Exception e)
  {
    println(e);
  }

  Collections.sort(tickers);


  // import information
  graphScreen  = new Screen(GREEN_LOWLIGHT);

  // initialize screens
  screenManipulator.initGraphScreen(graphScreen, tickers);

  companyInfoList = infoGetter.getCompanyInformation("stocks.csv");

  companyInfoList.remove(0);

  for (CompanyInfo cI : companyInfoList)
  {
    companyInfoListHashed.put(cI.ticker, cI);
  }

  Collections.sort(companyInfoList);

  // get information
  exchanges = StockInfoManipulator.parseExchanges(companyInfoList);


  //creating a list of queries and the corresponding list of integers

  //screen where we choose a query

  ArrayList<Integer> values = new ArrayList<Integer>();

  screenOne.addWidget(new TextView(0, DEFAULT_SEARCH_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-DEFAULT_SEARCH_BAR_HEIGHT, "", WHITE, stdFont, EVENT_TEXT_VIEW, companyInfoList, 50, 6, new String[] {"Number", "Ticker", "Exchange", "Name", "Sector", "Industry"}, 1));
  ArrayList<String> allTickers = new ArrayList<String>();
  for (int i = 0; i<companyInfoList.size(); i++)
  {
    values.add(i+1);
    allTickers.add(companyInfoList.get(i).ticker);
  }
  screenOne.addWidget(new SearchBar(SCREEN_WIDTH/5, 0, SCREEN_WIDTH/5, DEFAULT_SEARCH_BAR_HEIGHT, "Tickers search", CYAN, stdFont, EVENT_SEARCHBAR, allTickers, values, 1));

  values.clear();  

  for (int i = 0; i<companyInfoList.size(); i++)
  {

    if (!sectors.contains(companyInfoList.get(i).sector))
    {
      sectors.add(companyInfoList.get(i).sector);
      values.add(sectors.size());
    }
  }

  screenOne.addWidget(new SearchBar(2*SCREEN_WIDTH/5, 0, SCREEN_WIDTH/5, DEFAULT_SEARCH_BAR_HEIGHT, "Sectors search", CYAN, stdFont, EVENT_SEARCHBAR, sectors, values, 2));

  values.clear();  

  for (int i = 0; i<companyInfoList.size(); i++)
  {

    if (!industries.contains(companyInfoList.get(i).industry))
    {
      industries.add(companyInfoList.get(i).industry);
      values.add(industries.size());
    }
  }

  screenOne.addWidget(new SearchBar(3*SCREEN_WIDTH/5, 0, SCREEN_WIDTH/5, DEFAULT_SEARCH_BAR_HEIGHT, "Industries search", CYAN, stdFont, EVENT_SEARCHBAR, industries, values, 3));
  
  values.clear();
  for(int i = 0; i<exchanges.size();i++)
  {
    values.add(i+1);
  }    
  screenOne.addWidget(new SearchBar(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/10, DEFAULT_SEARCH_BAR_HEIGHT, "Exchanges search", CYAN, stdFont, EVENT_SEARCHBAR,exchanges, values, 4));
  screenOne.addWidget(new Widget(4*SCREEN_WIDTH/5, 0, SCREEN_WIDTH/10, DEFAULT_BUTTON_HEIGHT, "BACKWARD", CYAN, stdFont, EVENT_BUTTON, 1));
  screenOne.addWidget(new Widget(9*SCREEN_WIDTH/10, 0, SCREEN_WIDTH/10, DEFAULT_BUTTON_HEIGHT, "FORWARD", CYAN, stdFont, EVENT_BUTTON, 2));
  screenOne.addWidget(new Widget(0, 0, SCREEN_WIDTH/10, DEFAULT_BUTTON_HEIGHT, "GRAPHS", CYAN, stdFont, EVENT_BUTTON, 3));

  loaded = true;
}

void draw() { 
  if (loaded)
  {
    currentScreen.draw();
  } else
  {
    lScreen.draw();
  }
}

void mousePressed() {

  try
  {

    int []res = currentScreen.getEvent(mouseX, mouseY);

    int event = res[0];
    int id = res[1];
    Widget widget = currentScreen.searchWidgetByEventAndId(event, id);


    switch(event)
    {

    case EVENT_BUTTON:

      if (currentScreen == screenOne)
      {
        if (id == 1)
        {
          ((TextView)(this.screenOne.widgetList.get(0))).backward();
        } else if (id == 2)
        {
          ((TextView)(this.screenOne.widgetList.get(0))).forward();
        } else if (id == 3)
        {
          currentScreen = graphScreen;
        }

        focus =null;
      }
      break;
    case EVENT_TEXTBOX:
      focus = (TextBox)widget; 
      currentScreen.setAllTextBoxFocusFalse();
      focus.focus= true;
      break;
    case EVENT_SEARCHBAR:
      focus = (TextBox)((SearchBar)widget);  
      currentScreen.setAllTextBoxFocusFalse();
      focus.focus = true;

      break;  
    case EVENT_CHANGE_SCREEN: 
      {
        currentScreen = screenOne;
        break;
      }

    case EVENT_TICKER_LIST_SELECT:
      {
        stockData = currentScreen.tickerList.select(id,screenManipulator.chosenBarChart);
        screenManipulator.updateSlider(currentScreen, stockData);
        break;
      }
    case EVENT_GENERATE_GRAPH:
      {    
        screenManipulator.generateGraph(currentScreen, stockData); 
        break;
      }
    case EVENT_BAR_CHART:
      {
        screenManipulator.chooseBarChart(currentScreen); 
        break;
      }
    case EVENT_CANDLE_GRAPH:
      {
        screenManipulator.chooseCandleGraph(currentScreen); 
        break;
      }
    case EVENT_LINE_GRAPH:
      {
        screenManipulator.chooseLineGraph(currentScreen); 
        break;
      }
    case EVENT_CHOSE_DATA_TYPE:
      {
        screenManipulator.chooseDataType(id, currentScreen); 
        break;
      }
    case EVENT_TICKER_LIST_SORT:
      {
        screenManipulator.changeTickerList(currentScreen, id); 
        break;
      }

    default: 
      break;
    }


    if (focus!=null)
    {
      if (focus instanceof SearchBar)
      {
        SearchBar sB  = (SearchBar)focus;  
        if (currentScreen == screenOne)
        {        
          if (sB.id==1)
          {
            int tempTickerToShow = sB.clickedOnTheOption(mouseX, mouseY);  
            if (tempTickerToShow!=QUERY_NULL)
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setPositionToShow(tempTickerToShow-1);
            } else
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setPositionToShow(-1);
            }
          } 
          else if (sB.id==2)
          {
            int tempSector = sB.clickedOnTheOption(mouseX, mouseY);
            if (tempSector!=QUERY_NULL)
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setSectorHighlight(sectors.get(tempSector-1));
            } else
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setSectorHighlight("");
            }
          } 
          else if (sB.id==3)
          {
            int tempIndustry = sB.clickedOnTheOption(mouseX, mouseY);
            if (tempIndustry!=QUERY_NULL)
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setIndustryHighlight(industries.get(tempIndustry-1));
            } else
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setIndustryHighlight("");
            }
          }
          else if (sB.id ==4)
          {
            int tempExchange = sB.clickedOnTheOption(mouseX, mouseY);
            if (tempExchange!=QUERY_NULL)
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setExchangeHighlight(exchanges.get(tempExchange-1));
            } else
            {
              ((TextView)(this.screenOne.widgetList.get(0))).setExchangeHighlight("");
            }
          }
        }
      }
    }
  }
  catch(Exception e)
  {
    println(e);
  }
}  



void keyPressed()
{
  try
  {
    if (focus != null) {
      focus.append(key);
    }
  }
  catch(Exception e)
  {
    println(e);
  }
}


void mouseDragged() {

  try
  {
    int []res = currentScreen.getEvent(mouseX, mouseY);
    int event = res[0];
    int id = res[1];

    Widget widget = currentScreen.searchWidgetByEventAndId(event, id);

    switch(event)
    {
    case EVENT_TEXT_VIEW: 
      TextView currentTextView = (TextView)widget;
      if (mouseY <= currentTextView.scrollBar.y + currentTextView.scrollBar.height - currentTextView.scrollBar.barPointer.height) {
        currentTextView.scrollBar.barPointer.y = mouseY;
      } else {
        currentTextView.scrollBar.barPointer.y = currentTextView.scrollBar.y + currentTextView.scrollBar.height - currentTextView.scrollBar.barPointer.height;
      }  
      break;
    case EVENT_TICKERS_SCROLL: 
      currentScreen.tickerList.move(mouseY); 
      break;
    case EVENT_SLIDER_POINTER:
      {
        screenManipulator.moveSliderPointer(currentScreen, id, mouseX); 
        break;
      }
    }
  }
  catch(Exception e)
  {
    println(e);
  }
}
