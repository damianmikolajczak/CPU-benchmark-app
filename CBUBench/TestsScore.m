//
//  TestsScore.m
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import "TestsScore.h"

@implementation TestsScore
@synthesize RungeKuttaScore, LucasLahmerScore, BubbleSortScore, TotalScore;
-(id) initScoreWithRK4: (double) RK4 andLL: (double) LL andBS: (double) BS andTotal: (double) Total
{
    self=[super init];
    if (self) {
        [self setRungeKuttaScore:RK4];
        [self setLucasLahmerScore:LL];
        [self setBubbleSortScore:BS];
        [self setTotalScore:Total];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeDouble:RungeKuttaScore forKey:@"RungeKutta"];
    [coder encodeDouble:LucasLahmerScore forKey:@"LucasLahmer"];
    [coder encodeDouble:BubbleSortScore forKey:@"BubbleSort"];
    [coder encodeDouble:TotalScore forKey:@"Total"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        RungeKuttaScore = [coder decodeDoubleForKey:@"RungeKutta"];
        LucasLahmerScore = [coder decodeDoubleForKey:@"LucasLahmer"];
        BubbleSortScore = [coder decodeDoubleForKey:@"BubbleSort"];
        TotalScore = [coder decodeDoubleForKey:@"Total"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n\n Runge-Kutta algorithm score: %.f \n Lucas-Lahmer algorithm score: %.f \n Bubble sort algorithm score: %.f \n Total score: %.f", RungeKuttaScore, LucasLahmerScore, BubbleSortScore,TotalScore];
}
@end

