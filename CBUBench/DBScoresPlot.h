//
//  DBScoresPlot.h
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import <Foundation/Foundation.h>
#import <CorePlot/CorePlot.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBScoresPlot : NSObject
@property (nonatomic, retain) CPTGraphHostingView *myView;
@property (nonatomic, retain) CPTXYGraph          *myGraph;
@property (nonatomic, retain) NSMutableArray      *dataToPlot;

-(id)initWithHostingView:(CPTGraphHostingView *)hostingView andData:(NSMutableArray *)data;
-(void)initialisePlot;
@end

NS_ASSUME_NONNULL_END

