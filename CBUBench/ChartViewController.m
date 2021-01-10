//
//  ChartViewController.m
//  CPUb
//
//  Created by Damian Mikołajczak on 07/01/2021.
//

#import "ChartViewController.h"
#import "TestsScore.h"

@interface ChartViewController () <CPTPlotDataSource>{
    IBOutlet CPTGraphHostingView *chartView;
    DBScoresPlot      *scorePlot;
}

@end

@implementation ChartViewController

@synthesize scorePlot;
@synthesize chartView;

-(void) viewDidAppear{
    [super viewDidAppear];
    
    NSString            *fName=@"bench_archive";
    NSMutableArray      *scoresArray= [NSKeyedUnarchiver unarchiveObjectWithFile:fName];
    NSMutableArray *data = [NSMutableArray array];
    int objIndex=1;
    for (TestsScore *testObj in scoresArray) {
        [data addObject:[NSValue valueWithPoint:CGPointMake(objIndex, [testObj TotalScore])]];
        objIndex++;
    }

    self.scorePlot = [[DBScoresPlot alloc] initWithHostingView:chartView andData:data];
    [self.scorePlot initialisePlot];
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
@end
