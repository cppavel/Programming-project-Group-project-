import java.util.Comparator;
class DataPointComparator implements Comparator
{
  
  int compareType;
  public DataPointComparator(int compareType)
  {
    this.compareType = compareType;
  }
  public int compare(Object obj1, Object obj2)
  {
    
    DataPoint a = (DataPoint)obj1;
    DataPoint b = (DataPoint)obj2;
    
    switch(compareType)
    {
      case VOLUME:  return int(a.volume - b.volume);
      default:  return DATA_POINT_COMPARATOR_DEFAULT_VALUE;
    }
    
   
  }
 
}
