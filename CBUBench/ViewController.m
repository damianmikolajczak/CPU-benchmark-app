//
//  ViewController.m
//  CPUb
//
//  Created by Damian Mikołajczak on 05/01/2021.
//

#import "ViewController.h"

@implementation ViewController
@synthesize MenuContainer;
@synthesize ChartContainer;

-(void) ShowChart{
    ChartContainer.hidden=FALSE;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ChartContainer.hidden=TRUE;
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)ShowBarChart:(NSSwitch *)sender {
    if ([sender state]==0) {
        ChartContainer.hidden = TRUE;
        MenuContainer.hidden = FALSE;
    }else{
        ChartContainer.hidden = FALSE;
        MenuContainer.hidden = TRUE;
    }
}
@end
