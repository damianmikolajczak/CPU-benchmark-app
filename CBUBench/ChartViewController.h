//
//  ChartViewController.h
//  CPUb
//
//  Created by Damian Mikołajczak on 07/01/2021.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>
#import "DBScoresPlot.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartViewController : NSViewController <CPTPlotDataSource>

@property (nonatomic, retain) DBScoresPlot      *scorePlot;
@property (strong) IBOutlet CPTGraphHostingView *chartView;

@end

NS_ASSUME_NONNULL_END
