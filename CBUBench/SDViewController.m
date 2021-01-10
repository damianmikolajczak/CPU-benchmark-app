//
//  SDViewController.m
//  CBUBench
//
//  Created by Damian Mikołajczak on 10/01/2021.
//

#import "SDViewController.h"


@interface SDViewController ()

@end

@implementation SDViewController

- (void)viewDidAppear{
    [super viewDidAppear];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString            *fName=@"bench_archive";
    NSFileManager       *fm=[NSFileManager defaultManager];
    NSMutableArray      *scorsArray= [NSKeyedUnarchiver unarchiveObjectWithFile:fName];
    
    TestsScore *obj=[scorsArray lastObject];
    
    self.RungeKuttaScore.doubleValue = obj.RungeKuttaScore;
    self.LucasLahmerScore.doubleValue = obj.LucasLahmerScore;
    self.BubbleSortScore.doubleValue = obj.BubbleSortScore;
}

@end
