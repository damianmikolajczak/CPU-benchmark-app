//
//  SDViewController.h
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import <Cocoa/Cocoa.h>
#import "TestsScore.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDViewController : NSViewController
@property (weak) IBOutlet NSTextField *RungeKuttaScore;
@property (weak) IBOutlet NSTextField *LucasLahmerScore;
@property (weak) IBOutlet NSTextField *BubbleSortScore;

@end

NS_ASSUME_NONNULL_END
