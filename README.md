# Programming-project-Group-project-
A project I developed with Enda, Brian and Filip as a part of Programming project module. We used SVN as a version control system. 

# Project Report: [Link](https://github.com/cppavel/Programming-project-Group-project-/blob/master/CS1013-report-36.pdf).

# 1 Launching our program
The program works with standard .csv ﬁles. It requires a ﬁle called ”daily prices2GB.csv” to be put in the folder with the main script (Stocks.pde). If you want to test the program on a smaller dataset, simply change the ﬁle by renaming it to ”daily prices2GB.csv”. We do not have a 2GB ﬁle on our svn repository. Therefore, when you check out the ”Stocks” folder on your PC, put your local copy of the 2GB ﬁle to the folder.
# 2 Design
Our application shows a loading screen when launched. After the data is parsed the user is transferred to the main screen, which allows them to browse through the tickers and see information about them. The program provides the opportunity to search for the tickers by their name, sector and industry (and the same time), and exchange. It also allows the user to browse through the search results using the ”forward” and ”backward” buttons. The current ticker (when browsing is applicable) is highlighted in the blue box and all the other search results are highlighted in red. The main purpose of the graph screen is getting the input from the user: ticker/tickers, type of graph, data types (e.g. open price), the date range and the way tickers are sorted in the list. There are three types of graphs available for the user: candle graph, bar chart, and line graph. Candle graph is used to visualize the dynamics of the stock on each day of the speciﬁed date range. It displays the opening and the close price for a given data type. If the diﬀerence between them is greater than zero the candle is green, otherwise, it is red. The vertical lines of the candle indicate the peak and the lowest point of the day. The bar chart visualizes the average of a given data type for a list of tickers. It also has an option to display the average relative diﬀerence between the close and open prices for the speciﬁed dates. If the average is negative the bar is red, otherwise, the bar’s color is set to green. Finally, the line graph shows how the given data type changes over time. The graphs have a consistent color scheme as well as provide labels and captions, where applicable. The user has an opportunity to navigate back to the main screen if they wish.
# 3 Teamwork organization
We had one in-person team meeting at the start of the semester, where we discussed our plans, set up subversion, and planned the way we were going to communicate. However, after the campus was closed all of our communication happened online. Mostly we used messenger, where we put updates about what we did as well as discussed the problems and ideas. Besides, we used discord for voice chat meetings and the blackboard system during the labs. After somebody committed the new version, they always wrote a comment about the changes. Moreover, we set weekly goals and did our best to achieve them before the next week. If somebody was having trouble with a particular issue for a long time, we always discussed the problem together to ﬁnd a solution.
# 4 The way we split up the work
# 4.1 Pavel
I would say that I made equal contributions to the backend and frontend of our project. At the very start of the project, my main task was creating the simple UI controls and reviewing my teammates’ code to optimize the program in terms of responding to queries and loading data. Then as we moved towards the labs, where we had to do demonstrations, I was responsible for creating them. That included merging the diﬀerent versions of the program, ﬁxing bugs and implementing the new UI elements. To be more speciﬁc in terms of UI, I implemented a textbox, search bar, scroll bar, text view (a kind of rich textbox). I also wrote events behind those controls and implemented a mechanism for searching tickers in the text view. During the last weeks, we encountered a problem with parsing a 2GB ﬁle, so I came up with the approach to separate it into many smaller ﬁles by the ticker. I implemented the loadData() and getData() methods. Finally, in the last week before the demonstration, my task was to merge the two versions of the project we had (one which had a graph screen as the main one and the other with a text view for browsing tickers). That took me quite a bit of time to accomplish. While I was merging the versions, I also ﬁxed a signiﬁcant number of bugs, implemented a loading screen, and made a few changes to the visualizations (graphs).

# 4.2 Enda
Most of my work was on the back end, although I did contribute a large amount to the implementation of the graph screen. The ﬁrst objective I gave myself was to make a candle graph (“CandleGraph” class). This graph shows a series of open prices, close prices, the highs and lows for a given date all in one graphic. I found this to be an interesting problem. I ended up creating another class called “Candle” to represent each candle in the candle graph. Originally the design was very basic, but after adding new features to the graph gradually while working on other parts of the project, I believe the end result looks good. I reworked the entire class to implement it as a Widget and to make sure that it could be resized and given a diﬀerent position easily. This took quite a long time to implement, however, none of these features were used in the ﬁnal project. I designed and implemented the graph screen and its widgets, however, I think that a better approach could have been found if I had more time to develop it. As for the backend, I made the “StockInfoManipulator”, “InfoImporter”, “ScreenManipulator” and the “DataPointSort” classes. I made the StockInfoManipulator class to help everyone in the group build up their classes if they need to manipulate, parse or sort any of the information from the DataPoints or import information from a ﬁle. There are a number of methods that I am really happy with from this class, particularly methods involving dates such as ﬁlterByDates(), and sortByDate(). I struggled with various diﬀerent methods of working with dates before I found quite an easy solution. I am very happy with how the getCompanyInformation() in the InfoImporter class was implemented. I learned about regular expressions and how to get the contents of a string between two quotation
marks. I made the ScreenManipulator class to change the contents of the screen, such as the contents of the graphs, the dates that will be shown on the slider to ﬁlter by date, and to initialize the contents of the graph screen. I made some other smaller classes such as the “Slider” and “Text” classes.

# 4.3 Filip
Most of my work for the ﬁrst couple of weeks was on the LineGraph class. This graph shows a series of Dates on the x axis and one of the diﬀerent types of information (open price, close price and others) on the y axis in a line graph. When writing this class I encountered an issue where processing increases the y values as you go down, this meant a big portion of my time writing this class was spent on researching ways to translate points in order to make the graph appear upside down and how to make the text the right way up. Later I had to rework the class in order to implement it as a widget which was an easy task as I did not run into many problems. The way this class handles data could be improved however as it is one of the slowest visualization classes in our program. Scaling the values in order to ﬁt them between the start of the graph and the top was a major challenge for me as I couldn’t ﬁnd an easy way to do it but with some experimentation, I came up with a method that I think is quite eﬃcient and I am happy with it. I also worked on the StockInfoManipulator class for some of the functions that my LineGraph class needed like the trimBetweenDates() but I also wrote a version of the sortByDate() function that was later improved on by Enda with a more eﬃcient algorithm. I struggled with comparing if a date was in the range passed into the function in the trimBetweenDates() however I ﬁgured out a method where the years are compared ﬁrst then months and days which helped me later when sorting the dates by the chronological order in the lineGraph class. A massive problem I encountered was understanding my teammates’ code but by communicating with the person that wrote the speciﬁc piece of code I was having trouble understanding it was easy for me to get a grasp on what it does and how it works.

# 4.4 Brian
I began with the Barchart class. The version of this class deals with two queries. It displays the average of a datatype within a date range on the y-axis, each of the tickers selected is put on the x-axis. The other query is the open and close diﬀerence, which displays the open and close percentage diﬀerence. The bar is green when there is an increase in the close price compared to the open price. However, it underwent multiple changes before that. In the beginning it was very simple and ineﬃcient. I then changed it to extend the widget class which was a relatively simple task. This allowed it to be implemented in the program easily. After a team meeting, we agreed that our graphs should go for a similar style and aesthetic and I was asked to modify it to ﬁt that and also to change it to only display one ticker and all the data of a datatype within the date range selected. While doing this modiﬁcation I vastly improved the aesthetic
and more importantly the eﬃciency of this class. After some more deliberation, I decided that it was far too similar to the line graph so it was changed to deal with its original query of the averages of multiple tickers. I used the more eﬃcient code of the new bar chart and modiﬁed it to display that query and added another query which I had previously done some work on of the open/close query. In the end, it resulted in a far superior class than the one at the start. Other than the bar chart I also added to other classes in our code. I created methods in StockInfoManipuator which allowed for the creation of two queries to be displayed on bar chart(getAverage, getPercentageDiﬀerence, etc.). I also modiﬁed a multitude of other classes implementing Barchart into our program among some other minor additions I made to classes. While working on this project I encountered and overcame many problems and learned a signiﬁcant amount. The problem of understanding each other’s code and their plans on how everything was going ﬁt together was ﬁxed with proper communication. I learned that communication was vital when working on a project in a team. Also of having a clear plan on how everything was going to ﬁt together and goals to be achieved will be something that I’ll do for all future team projects as I believe many problems could’ve been avoided with this.
# 5 Notes on teamwork
It is especially important to note that everybody contributed to all the aspects of the project. Although writing code is probably considered most important now, it is a big mistake not to take the ideas, suggestions, bug ﬁxes, and peer code review into account. These were the things that greatly inﬂuenced our project and improved the quality of work we did.
# 6 Features
The features we implemented can be divided into three distinct groups: queries, UI, and backend. As for the queries, there are two general types of them: visualizing the data for a given ticker/tickers and providing information about the ticker. Our program allows users to plot all the types of data for a given ticker against the speciﬁed time range. Line graph and candle graph show how the given variable evolved, for example, adjusted close price, whereas the bar chart visualizes the averages of a given data type for a list of tickers, including the open-close price diﬀerence, which is not supported by the other graphs. Moreover, the program allows the user to sort the tickers in the list by their open price, close price, etc., so it is easier to choose the tickers for the visualization and analyze the data. In terms of providing information about the tickers, the program can search through the list of tickers by their parameters (name, exchange, sector, and industry). One can navigate through the list of search results. Since it might take a while for our program to launch there is a loading screen implemented. Moreover, the UI is built in a consistent color scheme and is made to be easy to use. There is a good amount of comments and labels so that the user knows what they need to enter. For the data loading, we use a special method that separates the initial input ﬁle into the list of ﬁles sorted by the ticker, which makes it possible for our program to work with a 2GB dataset. Moreover, for the loading screen to be shown loading is done asynchronously in a separate thread. The loading screen is replaced with the main one once the loading is ﬁnished. Also, for each widget, there is an event code and its unique id. That is done to distinguish between the widgets of diﬀerent types as well as the diﬀerent widgets of one type in the program. Finally, we use the Collections.sort method with the implemented comparators to sort our objects.
# 7 Problems encountered
As it was already mentioned, the greatest problem was to ensure our program can deal with a 2GB data set. Initially, all the data was stored in the array of objects. It worked even for the 100k dataset, however, there was no possibility to store over 20 million objects in the program for the 2GB data set. That required more than 8GB of RAM, which is impossible in the x64 processor conﬁgurations (for the programs with ordinary access permissions) not to mention the 32-bit conﬁgurations. The solution we came up with is to separate the initial ﬁle into several smaller ﬁles sorted by the ticker. That was done by reading the whole dataset and creating a HashMap of buﬀered writers to place the data entries into the new ﬁles. Once the program needs to access the given list of tickers for forming the results of the query it simply loads all the information from the respective ﬁles. Although it still might take a while (on 2GB dataset), this approach turns out to be suﬃcient to work with most queries, which can be made by the user. There was also a less signiﬁcant problem of outputting the rotated text on the screen. A Text class was implemented to deal with this issue. It uses the push Matrix and pop Matrix methods as well as the rotation of the coordinate system. Finally, there was a problem that nothing could be shown on the screen before the setup was ﬁnished. Since the loading process takes a while, there was a need to implement the loading screen. We transferred the loading process into a separate method and ran it in a diﬀerent thread. Now that the method was called asynchronously the loading screen could be shown. At the very end of the loading method, the ﬂag is set to indicate that the loading has ﬁnished, which is then allows the main screen of the program to show up.
