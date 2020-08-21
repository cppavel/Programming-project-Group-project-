// Creates and draws a list of the tickers. These tickers can be selected and returned using the "getSelectedTickers" method.
//---------------------------------------------------------------------------------------------------------------------------------------------------
// [Enda]
// I created this class. Adjustements to this class were made by Pavel also.
//[PAVEL]
//Minor changes: fixed a small bug with scrollBar here, made it possible to choose multiple tickers for the BarChart graph.
//---------------------------------------------------------------------------------------------------------------------------------------------------
class TickerList extends Widget {
  private ArrayList<Widget> tickerList = new ArrayList<Widget>();
  private ArrayList<String> selectedTickers = new ArrayList<String>();
  private ScrollBar tickerScrollBar;
  private Widget tickerButton;

  TickerList(ArrayList<String> tickers) {
    super();
    tickerButton = new Widget(0, TICKER_LIST_HEIGHT, TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, "TICKERS", GREEN, stdFont, 0, ID_NULL);
    tickerList = generateWidgets(tickers);
    tickerScrollBar = new ScrollBar(TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, DEFAULT_SCROLL_BAR_SIZE, SCREEN_HEIGHT -(int)(3.5*TICKER_LIST_HEIGHT), DEFAULT_SCROLL_BAR_SIZE*4, LIGHT_GRAY_1, stdFont, EVENT_TICKERS_SCROLL, GRAY, ID_NULL);
  }

  ArrayList<Widget> generateWidgets(ArrayList<String> tickers) {
    ArrayList<Widget> widgets = new ArrayList<Widget>();
    for (int i = 0; i < tickers.size(); i++) {
      widgets.add(new Widget(0, TICKER_LIST_HEIGHT*(i+2), TICKER_LIST_WIDTH, TICKER_LIST_HEIGHT, tickers.get(i), GRAY, stdFont, EVENT_TICKER_LIST_SELECT, i));
    }
    return widgets;
  }

  @Override
    void draw() {
    stroke(BLACK);
    for (Widget widget : tickerList) {
      widget.draw();
    }
    tickerScrollBar.draw();
    tickerButton.draw();
  }

  @Override
    int[] getEvent(int mX, int mY) {
    int[] tickerScrollEvent = tickerScrollBar.getEvent(mX, mY);
    if (tickerScrollEvent[EVENT] != EVENT_NULL) {
      return tickerScrollEvent;
    }
    if (mY > 2*TICKER_LIST_HEIGHT && mY < SCREEN_HEIGHT-2.5*TICKER_LIST_HEIGHT) {
      for (int i = 0; i < tickerList.size(); i++) {
        if (mX >= tickerList.get(i).x && mX <= tickerList.get(i).x + tickerList.get(i).width && mY >= tickerList.get(i).y && mY <= tickerList.get(i).y + tickerList.get(i).height) {
          return new int[] {tickerList.get(i).event, tickerList.get(i).id};
        }
      }
    }
    return new int[] {EVENT_NULL, ID_NULL};
  }

  void reset()
  {

    if (selectedTickers.size()>1)
    {
      selectedTickers.clear();

      for (int i = 0; i < tickerList.size(); i++) {
        tickerList.get(i).setColor(GRAY);
      }
    }
  }

  ArrayList<DataPoint> select(int index, boolean selectMultiple) {

    if (!selectMultiple)
    {
      selectedTickers.clear();
    }
    if (selectedTickers.contains(tickerList.get(index).label))
    {
      selectedTickers.remove(tickerList.get(index).label);
    } else
    {
      selectedTickers.add(tickerList.get(index).label);
      tickerList.get(index).setColor(LIGHT_GRAY_1);
    }
    for (int i = 0; i < tickerList.size(); i++) {
      if (selectMultiple&&!selectedTickers.contains(tickerList.get(i).label))
      {
        tickerList.get(i).setColor(GRAY);
      } else if (!selectMultiple)
      {
        if (i!=index)
        {
          tickerList.get(i).setColor(GRAY);
        }
      }
    }
    return infoGetter.getData(currentScreen.tickerList.getSelectedTickers());
  }

  void move(float mousePos) {
    if (mousePos>= TICKER_LIST_HEIGHT+DEFAULT_SCROLL_BAR_SIZE*2 && mousePos <= SCREEN_HEIGHT-DEFAULT_SCROLL_BAR_SIZE*2-int(2.5*TICKER_LIST_HEIGHT)) {
      tickerScrollBar.barPointer.setY((int)mousePos - DEFAULT_SCROLL_BAR_SIZE*2);
      float yIncrease = tickerScrollBar.getNormalizedValue()*(tickerList.size()*TICKER_LIST_HEIGHT-(SCREEN_HEIGHT-4.5*TICKER_LIST_HEIGHT));      
      for (int i = 0; i < tickerList.size(); i++) {
        tickerList.get(i).setY((int)(((i+2)*TICKER_LIST_HEIGHT) - yIncrease));
      }
    }
  }

  ArrayList<String> getSelectedTickers() {
    return selectedTickers;
  }
}
