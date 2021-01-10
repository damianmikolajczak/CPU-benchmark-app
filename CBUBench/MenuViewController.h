//
//  MenuViewController.h
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import <Cocoa/Cocoa.h>
#import "TestsScore.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : NSViewController
@property (weak) IBOutlet NSTextField *TotalScore;
@property (weak) TestsScore *currentScore;
@property (weak) IBOutlet NSTextField *RungeKuttaScore;
@property (weak) IBOutlet NSTextField *LucasLahmerScore;
@property (weak) IBOutlet NSTextField *BubbleSortScore;
@property (weak) IBOutlet NSButton *ScoreDetailsButton;

@end

NS_ASSUME_NONNULL_END

