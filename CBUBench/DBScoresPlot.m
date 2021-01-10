//
//  DBScoresPlot.m
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import "DBScoresPlot.h"
#import "TestsScore.h"


@implementation DBScoresPlot
@synthesize myView;
@synthesize myGraph;
@synthesize dataToPlot;

-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data
{
    self = [super init];

    if ( self != nil ) {
        self.myView = hostingView;
        self.dataToPlot = data;
        self.myGraph = nil;
    }
    NSLog(@"End of the F***ing init Once");
    return self;
}

-(void)initialisePlot
{
    // Start with some simple sanity checks before we kick off
    if ( (self.myView == nil) || (self.dataToPlot == nil) ) {
        NSLog(@"Cannot initialise plot without hosting view or data.");
        return;
    }

    if ( self.myGraph != nil ) {
        NSLog(@"Graph object already exists.");
        return;
    }

    // Create a graph object which we will use to host just one scatter plot.
    CGRect frame = [self.myView bounds];
    self.myGraph = [[CPTXYGraph alloc] initWithFrame:frame];
    NSLog(@"create a graph");

    // Add some padding to the graph, with more at the bottom for axis labels.
    self.myGraph.plotAreaFrame.paddingTop = 20.0f;
    self.myGraph.plotAreaFrame.paddingRight = 20.0f;
    self.myGraph.plotAreaFrame.paddingBottom = 50.0f;
    self.myGraph.plotAreaFrame.paddingLeft = 80.0f;
    NSLog(@"Add some padding");
    
    // Tie the graph we've created with the hosting view.
    self.myView.hostedGraph = self.myGraph;

    // If you want to use one of the default themes - apply that here.
    //[self.graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];

    // Create a line style that we will apply to the axis and data line.
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    lineStyle.lineWidth = 2.0f;

    // Create a text style that we will use for the axis labels.
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor whiteColor];

    // Create the plot symbol we're going to use.
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol crossPlotSymbol];
    plotSymbol.lineStyle = lineStyle;
    plotSymbol.size = CGSizeMake(8.0, 8.0);
    NSLog(@"Created some lines, trests and symbols");
    // Setup some floats that represent the min/max values on our axis.
    NSString            *fName=@"bench_archive";
    NSMutableArray      *scoresArray= [NSKeyedUnarchiver unarchiveObjectWithFile:fName];
    float maxValue=0;
    int objIndex=1;
    for (TestsScore *testObj in scoresArray) {
        if (testObj.TotalScore>maxValue){
            maxValue=testObj.TotalScore;
            
        }
        objIndex++;
    }
    NSNumber *xAxisMax = [[NSNumber alloc] initWithInt:objIndex];
    NSNumber *yAxisMax = [[NSNumber alloc] initWithFloat:1.2*maxValue];

    // We modify the graph's plot space to setup the axis' min / max values.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.myGraph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:@0 length:xAxisMax];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:@0 length:yAxisMax];
    
    NSLog(@"Modified plot space");
    // Modify the graph's axis with a label, line style, etc.
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.myGraph.axisSet;
    
    axisSet.xAxis.title = @"Test no";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.xAxis.majorIntervalLength = @1;
    axisSet.xAxis.minorTicksPerInterval = 0;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 0;

    axisSet.yAxis.title = @"Test score [pt]";
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleOffset = 60.0f;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    axisSet.yAxis.majorIntervalLength = @2000;
    axisSet.yAxis.minorTicksPerInterval = 3;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    
    
    NSLog(@"Modified graphs axis");
    // Add a plot to our graph and axis. We give it an identifier so that we
    // could add multiple plots (data lines) to the same graph if necessary.
    CPTBarPlot *plot = [[CPTBarPlot alloc] init];
    plot.fill=[CPTFill fillWithColor:[CPTColor colorWithComponentRed:0.22 green:0.33 blue:0.49 alpha:1.0]];
    [plot setBackgroundColor:CGColorCreateSRGB(0.22, 0.22, 0.22, 1.0)];
    
    
    CPTMutableLineStyle *barLineStyle=[[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor blueColor];
    barLineStyle.lineWidth = 0.5;
    
    plot.dataSource = self;
    plot.identifier = @"mainplot";
    plot.lineStyle = barLineStyle;
    
    [self.myGraph addPlot:plot];
    NSLog(@"End of the F***ing init twice");
}

// Delegate method that returns the number of points on the plot
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ( [plot.identifier isEqual:@"mainplot"] )
    {
        return [self.dataToPlot count];
    }

    return 0;
}


// Delegate method that returns a single X or Y value for a given plot.
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ( [plot.identifier isEqual:@"mainplot"] )
    {
        NSValue *value = [self.dataToPlot objectAtIndex:index];
        CGPoint point = value.pointValue;

        // FieldEnum determines if we return an X or Y value.
        if ( fieldEnum == CPTScatterPlotFieldX )
        {
            return [NSNumber numberWithFloat:point.x];
        }
        else    // Y-Axis
        {
            return [NSNumber numberWithFloat:point.y];
        }
    }

    return [NSNumber numberWithFloat:0];
}

@end
