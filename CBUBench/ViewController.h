//
//  ViewController.h
//  CPUb
//
//  Created by Damian Mikołajczak on 05/01/2021.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSView *MenuContainer;
@property (weak) IBOutlet CPTGraphHostingView *ChartContainer;


@end


