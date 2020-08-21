// [Enda]
// This class stores the position of candles and has a method to draw a candle for the candle graph
// If the close price is less than the open price, the candle will be red. This means that the value of the stock has decreased.
// If the close price is greater than the open price, the candle will be green. This means the value of the stock has incrased.
// The top point on the vertical bar represents the highest value that stock had.
// The bottom point on the vertical bar represents the lowest value that stock had.
class Candle {

  private float blockX, blockY, blockHeight;
  private float lineY1, lineY2;
  private color candleColor;

  Candle(){}

  Candle(float openCloseDiff, float candleY1Pos, float candleY2Pos, float blockX, float blockY, float blockHeight) {
    lineY1 = candleY1Pos;
    lineY2 = candleY2Pos;
    this.blockX = blockX;
    this.blockY = blockY;
    this.blockHeight = blockHeight;
    setColor(openCloseDiff);
  }

  void setColor(float openCloseDiff) {
    if (openCloseDiff > 0) {
      candleColor = RED;
    }
    else if (openCloseDiff < 0) {
      candleColor = GREEN;
    }
    else candleColor = BLACK;
  }

  void draw() {
    stroke(BLACK);
    line(blockX+CANDLE_WIDTH/2, lineY1, blockX+CANDLE_WIDTH/2, lineY2);
    fill(candleColor);
    rect(blockX, blockY, CANDLE_WIDTH, blockHeight);
  }
}
