//A class which implements a widget that stores information about tickers and allows to scroll through as well as highlight a particular subset of the tickers and navigate through that subset
//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I created and maintained that class
//---------------------------------------------------------------------------------------------------------------------------------------------------
class TextView extends Widget
{
  ArrayList<CompanyInfo> dataPoints;
  ScrollBar scrollBar;

  int lineHeight;
  int columns;
  String[] labels;
  int lines;

  int widthPerColumn;

  int lowerIndex;
  int upperIndex;
  int highlight = -1;

  int navigationIndex = 0;

  String sectorHighlight = "";
  String industryHighlight = "";
  String exchangeHighlight = "";

  ArrayList<Integer> navigation = new ArrayList<Integer>();

  TextView(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, ArrayList<CompanyInfo> dataPoints, int linesNumber, 
    int columns, String[] labels, int id)
  {
    super(x, y, width, height, label, widgetColor, widgetFont, event, id);

    this.dataPoints = dataPoints;

    scrollBar = new ScrollBar(x + width - DEFAULT_SCROLL_BAR_SIZE, y, DEFAULT_SCROLL_BAR_SIZE, height,DEFAULT_SCROLL_BAR_SIZE*4,WHITE, stdFont, event,BLACK, id);

    lineHeight = height/(linesNumber+1);

    this.columns = columns;
    this.labels = labels;
    lines = linesNumber;

    widthPerColumn = (this.width-DEFAULT_SCROLL_BAR_SIZE)/columns;

    labels[0] = "  "+labels[0];
  }

  void drawTop()
  { 
    fill(labelColor);
    textFont(widgetFont);
    for (int i = 0; i <columns; i++)
    {
      textAlign(LEFT, TOP);
      text(labels[i], this.x + widthPerColumn * i, this.y);
    }
  }

  void setPositionToShow(int index)
  {
    highlight = index;
    sectorHighlight = "";
    industryHighlight = "";
    exchangeHighlight = "";
    move(index);
  }

  void forward()
  {
    if (navigationIndex<navigation.size()-1)
    {
      navigationIndex++;
      move(this.navigation.get(navigationIndex));
    }
  }

  void backward()
  {

    if (navigationIndex>0)
    {
      navigationIndex--;
      move(this.navigation.get(navigationIndex));
    }
  }

  void move(int index)
  {
    this.scrollBar.barPointer.y = this.scrollBar.y + index*(this.scrollBar.height-this.scrollBar.barPointer.height)/(dataPoints.size()-lines);
  }
  
  void setExchangeHighlight(String exchange)
  {
    exchangeHighlight = exchange;
    highlight = -1;
    sectorHighlight = "";
    industryHighlight = "";
    
    navigationIndex = 0;
    navigation.clear();
    
    for(int i = 0; i<dataPoints.size();i++)
    {
      if(dataPoints.get(i).exchange.equals(exchange))
      {
        navigation.add(i);
      }
    }
    if (navigation.size()>0)
    {
      move(navigation.get(0));
    } else
    {
      move(0);
    }
  }

  void setIndustryHighlight(String industry)
  {
    industryHighlight = industry;
    highlight = -1;
    exchangeHighlight = "";

    navigationIndex = 0;
    navigation.clear();

    if (!industry.equals(""))
    {
      for (int i = 0; i<dataPoints.size(); i++)
      {
        if (dataPoints.get(i).industry.equals(industry))
        {
          navigation.add(i);
        }
      }

      if (!sectorHighlight.equals(""))
      {
        for (int i = 0; i<navigation.size(); i++)
        {
          if (!dataPoints.get(navigation.get(i)).sector.equals(sectorHighlight))
          {
            navigation.remove(i);
            i--;
          }
        }
      }
    }
    else
    {
       for (int i = 0; i<dataPoints.size(); i++)
      {
        if (dataPoints.get(i).sector.equals(sectorHighlight))
        {
          navigation.add(i);
        }
      }
    }

    if (navigation.size()>0)
    {
      move(navigation.get(0));
    } else
    {
      move(0);
    }
  }

  void setSectorHighlight(String sector)
  {
    sectorHighlight = sector;
    highlight = -1;
    
    exchangeHighlight = "";

    navigationIndex = 0;

    navigation.clear();

    if (!sector.equals(""))
    {
      for (int i = 0; i<dataPoints.size(); i++)
      {
        if (dataPoints.get(i).sector.equals(sector))
        {
          navigation.add(i);
        }
      }

      if (!industryHighlight.equals(""))
      {
        for (int i = 0; i<navigation.size(); i++)
        {
          if (!dataPoints.get(navigation.get(i)).industry.equals(industryHighlight))
          {
            navigation.remove(i);
            i--;
          }
        }
      }
    } else
    {
      for (int i = 0; i<dataPoints.size(); i++)
      {
        if (dataPoints.get(i).industry.equals(industryHighlight))
        {
          navigation.add(i);
        }
      }
    }

    if (navigation.size()>0)
    {
      move(navigation.get(0));
    } else
    {
      move(0);
    }
  }
  
  @Override
  int[] getEvent (int mX, int mY)
  {
    return this.scrollBar.getEvent(mX,mY);
  }

  void getBounds()
  {
    float scale = this.scrollBar.getNormalizedValue() * (dataPoints.size()-lines)/(dataPoints.size());

    int indexToShow = (int)(dataPoints.size()*scale);

    lowerIndex = indexToShow;

    if (lowerIndex>dataPoints.size() - lines)
    {
      lowerIndex = dataPoints.size() - lines;
    }

    upperIndex = indexToShow + lines - 1;

    if (upperIndex > dataPoints.size() - 1)
    {
      upperIndex = dataPoints.size() - 1;
    }
  }

  @Override
    void draw() {   
    stroke(strokeColour);
    fill(widgetColor);
    rect(x, y, width, height);
    drawTop();
    getBounds();
    int currentY = this.y + lineHeight;

    for (int i = lowerIndex; i <= upperIndex; i++)
    {
      String[] data = this.dataPoints.get(i).convertToString();//{"number",ticker,exchange,name,sector,industry};
      data[0] = "  "+ (i + 1) + "";
      for (int j = 0; j<columns; j++)
      {
        textAlign(LEFT);
        textFont(widgetFont);
        color col;
        if (navigation.size()>0&&i==navigation.get(navigationIndex))
        {
          col = BLUE;
        } else
        {
          col = RED;
        }
        if (data[4].equals(sectorHighlight)&&data[5].equals(industryHighlight))
        {
          fill(widgetColor);
          stroke(col);
          rect(this.x + widthPerColumn*j, currentY, widthPerColumn, lineHeight);
          fill(col);
          text(data[j], this.x + widthPerColumn*j, currentY, widthPerColumn, lineHeight);
        } 
        else if (data[4].equals(sectorHighlight)&&industryHighlight.equals("")||data[5].equals(industryHighlight)&&sectorHighlight.equals("")||i==highlight||data[2].equals(exchangeHighlight))
        {
          fill(widgetColor);
          stroke(col);
          rect(this.x + widthPerColumn*j, currentY, widthPerColumn, lineHeight);
          fill(col);
          text(data[j], this.x + widthPerColumn*j, currentY, widthPerColumn, lineHeight);
        } 
        else 
        {
          fill(labelColor);
          text(data[j], this.x + widthPerColumn*j, currentY, widthPerColumn, lineHeight);
        }
      }
      currentY+=lineHeight;
    }
    this.scrollBar.draw();
  }
}
