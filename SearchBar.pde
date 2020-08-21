// a widget which implemets a search bar for given data.

//---------------------------------------------------------------------------------------------------------------------------------------------------
//[PAVEL]
//I created and maintained that class
//---------------------------------------------------------------------------------------------------------------------------------------------------

class SearchBar extends TextBox
{
  ArrayList<SearchBarOption> options = new ArrayList<SearchBarOption>();
  ArrayList<SearchBarOption> currentOptions = new ArrayList<SearchBarOption>();
  String initialLabel;

  SearchBar(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, ArrayList <String> labels, ArrayList <Integer> values, int id)
  {
    super(x, y, width, height, label, widgetColor, widgetFont, event, DEFAULT_TEXTBOX_MAX_LENGTH, id);
    initialLabel = label;
    int currentY = y + height;
    for (int i = 0; i<values.size(); i++)
    {
      options.add(new SearchBarOption(x, currentY, width, DEFAULT_SEARCHBAR_OPTION_HEIGHT, labels.get(i), widgetColor, widgetFont, event, values.get(i), id));
      currentY+=DEFAULT_SEARCHBAR_OPTION_HEIGHT;
    }
  }

  ArrayList<SearchBarOption> search()
  {
    String query = this.label;
    int currentY = y + height;
    ArrayList<SearchBarOption> returnValue = new ArrayList<SearchBarOption>();
    if (!query.equals(""))
    {
      for (int i = 0; i < options.size(); i++)
      {
        String currentQuery = options.get(i).label;

        if (currentQuery.length()>query.length())
        {  
          currentQuery = currentQuery.substring(0, query.length());
        }

        if (currentQuery.equals(query))
        {
          returnValue.add(options.get(i));
          returnValue.get(returnValue.size()-1).y = currentY;
          currentY+=DEFAULT_SEARCHBAR_OPTION_HEIGHT;
        }
      }
    }

    return returnValue;
  }

  int clickedOnTheOption(int mX, int mY)
  {
    int returnQuery = QUERY_NULL;
    for (int i = 0; i < currentOptions.size(); i++)
    { 
      if (currentOptions.get(i).getEvent(mX, mY)[EVENT] != EVENT_NULL)
      {
        returnQuery = currentOptions.get(i).value;
        label = currentOptions.get(i).label;  
        currentOptions.clear();
        return returnQuery;
      }
    }
    return QUERY_NULL;
  }

  boolean optionWasClicked(int mX, int mY)
  {
    for (int i = 0; i < currentOptions.size(); i++)
    { 
      if (currentOptions.get(i).getEvent(mX, mY)[EVENT] != EVENT_NULL)
      {
        return true;
      }
    } 

    return false;
  }

  @Override
  void append(char s)
  {

  
      if (s==BACKSPACE)
      {
        if (!label.equals(""))
        {
          label=label.substring(0, label.length()-1);
        }
      } else if (label.length() <maxLength)
      {
        if (s>='a' && s<='z' || s>='A' && s<='Z' || s>='0'&& s<='9')
        {
          label=label+str(s);
        }
      }
      currentOptions = search();
    
  }
  @Override
  int[] getEvent(int mX, int mY)
  {
    if ((mX >=x && mX <= x+width && mY >=y && mY <=y+height) || optionWasClicked(mX, mY)) 
    {        
        return new int[]{event,id};
    }
    currentOptions.clear();
    return new int[]{EVENT_NULL,ID_NULL};
  }

  @Override
  void draw()
  {
    super.draw();

    if (label.equals(""))
    {  
      textAlign(LEFT, CENTER);
      fill(GRAY);
      textFont(widgetFont);
      text(DEFAULT_SEARCHBAR_BACKGROUND_TEXT, x, y, width, height);
    }

    for (int i =0; i <currentOptions.size(); i++)
    {
      currentOptions.get(i).draw();
    }
  }
}
