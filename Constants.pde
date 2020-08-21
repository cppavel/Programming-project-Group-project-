//Constants file, everyone contributed to this


// Screen dimensions
final int SCREEN_WIDTH = 1920;
final int SCREEN_HEIGHT = 1080;

//General Constants

final int DATA_POINT_COMPARATOR_DEFAULT_VALUE = 0;
final int ID_NULL = -1;
final String PRN = "PRNTICKER";

// colours
final color WHITE = color(255);
final color BLACK = color(0);
final color GRAY = color(128);
final color LIGHT_GRAY_1 = color(225);
final color LIGHT_GRAY_2 = color(200);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color CYAN = color(0,255,255);
final color MAGENTA = color(255,0,255);
final color YELLOW = color(255,255,0);
final color GREEN_HIGHLIGHT = color(76, 224, 212);
final color GREEN_MIDLIGHT = color(58, 175, 169);
final color GREEN_LOWLIGHT = color(35, 106, 102);

// DataPoint information indexs
final static int TICKER = 0;
final static int OPEN_PRICE = 1;
final static int CLOSE_PRICE = 2;
final static int ADJUSTED_CLOSE = 3;
final static int LOW = 4;
final static int HIGH = 5;
final static int VOLUME = 6;
final static int DATE = 7;
// TickerList ID
final static  int OPEN_CLOSE_DIFF = 8;

// CompanyInfo indexes
final int EXCHANGE = 1;
final int NAME = 2;
final int SECTOR = 3;
final int INDUSTRY = 4;

// return events
final int EVENT_NULL = 0;
final int EVENT_TEXT_VIEW = 1;
final int EVENT_CANDLE_GRAPH = 2;
final int EVENT_SCATTERPLOT = 3;
final int EVENT_BAR_CHART = 4;
final int EVENT_TEXTBOX = 5;
final int EVENT_SEARCHBAR = 6;
final int EVENT_BARCHART = 7;
final int EVENT_TICKERS_SCROLL = 8;
final int EVENT_TICKER_LIST = 9;
final int EVENT_LOG = 10;
final int EVENT_TICKER_LIST_SORT = 11;
final int EVENT_CHANGE_SCREEN = 12;
final int EVENT_TICKER_LIST_SELECT = 13;
final int EVENT_INFO_LIST_SCROLL = 14;
final int EVENT_SLIDER_POINTER = 15;
final int EVENT_GENERATE_GRAPH = 16;
final int EVENT_CHOSE_DATA_TYPE = 17;
final int EVENT_DATA_TYPE_DISPLAY = 18;
final int EVENT_LINE_GRAPH = 19;
final int EVENT_BUTTON = 20;

// 
final int EVENT = 0;
final int ID = 1;

// date constants
final int YEAR = 0;
final int MONTH = 1;
final int DAY = 2;

//default widget parameters
final int DEFAULT_SCROLLER_SIZE_RATIO = 10;
final int DEFAULT_SCROLL_BAR_SIZE = 25;
final int DEFAULT_SCATTERPLOT_POINT_SIZE = 4;
final int DEFAULT_SCATTERPLOT_STROKE_WEIGHT = 2;
final int DEFAULT_STROKE_WEIGHT = 1;
final int DEFAULT_TEXTBOX_TICK_RATE = 50;
final int DEFAULT_TEXTBOX_MAX_LENGTH = 100;
final int DEFAULT_SEARCH_BAR_WIDTH = 200;
final int  DEFAULT_SEARCH_BAR_HEIGHT = 30;
final int DEFAULT_SEARCHBAR_OPTION_HEIGHT = 50;
final String DEFAULT_SEARCHBAR_BACKGROUND_TEXT = "  search  here  ";
final int DEFAULT_SCROLL_BAR_WIDTH = 200;
final int DEFAULT_SCROLL_BAR_HEIGHT = 30;
final int DEFAULT_TEXT_BOX_WIDTH = 200;
final int DEFAULT_TEXT_BOX_HEIGHT = 30;
final int DEFAULT_BUTTON_WIDTH = 200;
final int DEFAULT_BUTTON_HEIGHT = 30;

// candle settings
//change to be fullscreen for current demonstration
final int CANDLE_GRAPH_WIDTH = 1280;  //was 1000
final int CANDLE_GRAPH_HEIGHT = 720; // was 550
final int CANDLE_WIDTH = 12;
final float CANDLE_WIDTH_RATIO = 0.9;
final float CANDLE_HEIGHT_RATIO = 0.8;
final int CANDLE_YAXIS_SECTIONS = 10;
final int CANDLE_GRAPH_TEXT_SIZE = 14;
final boolean TEXT_ROTATE = true;
final boolean TEXT_NO_ROTATE = false;

// Barchart settings
final int BARCHART_WIDTH = 1000;
final int BARCHART_HEIGHT = 550;
final int BARCHART_MARGIN = 35;
final int BAR_WIDTH = 30;

// line graph settings
final float LINE_GRAPH_WIDTH_RATIO = 0.85;
final float LINE_GRAPH_HEIGHT_RATIO = 0.8;
//Log settings

final int DEFAULT_LOG_LINE_WIDTH  = 500;
final int DEFAULT_LOG_LINE_HEIGHT = 30;
final int DEFAULT_LOG_SQUARE_SIZE = 500;

//query codes
final int QUERY_NULL = 0;

// TickerList settings
final int TICKER_LIST_WIDTH = 120;
final int TICKER_LIST_HEIGHT = 45;


// Slider settings
final int SLIDER_POINTER_SIZE = 30;
final int SLIDER_LEFT = 0;
final int SLIDER_RIGHT = 1;
