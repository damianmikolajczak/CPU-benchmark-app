//
//  TestsScore.h
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TestsScore : NSObject <NSCoding>
@property double RungeKuttaScore, LucasLahmerScore, BubbleSortScore, TotalScore;
-(id) initScoreWithRK4: (double) RK4 andLL: (double) LL andBS: (double) BS andTotal: (double) Total;
@end

NS_ASSUME_NONNULL_END
