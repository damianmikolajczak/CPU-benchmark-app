//
//  MenuViewController.m
//  CPUb
//
//  Created by Damian Mikołajczak on 07/01/2021.
//

#import "MenuViewController.h"
#import "ViewController.h"
#import "TestsScore.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [[self ScoreDetailsButton] setEnabled:NO];
}

double function(double x, double t){
    return (325*sin(314.15*t)-2*x)/5;
}

int RK4(){
    double t0 = 0, x0 = 2, tn = 50, h = 0.001, K1, K2, K3, K4;
    double score = 0;
    int n = (tn-t0)/h;
    double simTime[n], simValue[n];
    simValue[1]=x0;
    
    for (int i=0; i<10; i++) {
        NSDate *start=[NSDate date];
        
        for (int k =2; k<n+1; k++) {
            simTime[k] = simTime[1] + (k-1)*h;
            K1 = h*function(simTime[k-1],simValue[k-1]);
            K2 = h*function(simTime[k-1]+h/2,simValue[k-1]+K1/2);
            K3 = h*function(simTime[k-1]+h/2,simValue[k-1]+K2/2);
            K4 = h*function(simTime[k-1]+h,simValue[k-1]+K3);
            simValue[k] = simValue[k-1] + (K1+K2+K3+K4)/6;
        }
        NSDate *stop=[NSDate date];
        NSTimeInterval executionTime = [stop timeIntervalSinceDate:start];
        score += (1/executionTime)/10;
    }
    return score;
}

int LucasLahmer(){
    double score = 0;
    unsigned long long Mp = 0;
    int s = 0;
    
    for (int i=0; i<10; i++) {
        NSDate *start=[NSDate date];
        for (int p = 3; p<64; p++) {
            Mp = (pow(2, p) - 1);
            s = 4;
            
            for (int j=0; j<(p-2); j++) {
                s = ((s*s)-2)%Mp;
            }
            if (s==0) {
                //NSLog(@"%d jest liczbą pierwszą", Mp);
            }else{
                //NSLog(@"%d nie jest liczbą pierwszą",Mp);
            }
        }
        NSDate *stop=[NSDate date];
        NSTimeInterval executionTime = [stop timeIntervalSinceDate:start];
        score += 1/(executionTime*10);
    }
    return score;
}

int bubbleSort(){
    
    const int N=1000;
    int counter=N;
    int elementBuffor=0;
    int setToSort[N];
    double score=0;
    
    NSDate *start=[NSDate date];
    for (int i=0; i<N; i++) {
        setToSort[i] = N-i;
    }
    
    while (counter > 1) {
        for (int j=0; j<(counter-1); j++) {
            if (setToSort[j] > setToSort[j+1]) {
                elementBuffor = setToSort[j];
                setToSort[j] = setToSort[j+1];
                setToSort[j+1] = elementBuffor;
            }
        }
        counter-=1;
    }
    NSDate *stop=[NSDate date];
    NSTimeInterval executionTime = [stop timeIntervalSinceDate:start];
    score += (1/executionTime);
    
    return score;
}

- (IBAction)TestStartButton:(id)sender {
    NSString            *fName=@"bench_archive";
    NSFileManager       *fm=[NSFileManager defaultManager];
    NSMutableArray      *scorsArray;
    
    double RK4Score = 0;
    double LLScore = 0;
    double bubbleSortScore = 0;
    int totalScore = 0;
    
    RK4Score = RK4()*10;
    LLScore = LucasLahmer()/5;
    bubbleSortScore = bubbleSort();
    totalScore = RK4Score + LLScore + bubbleSortScore;
    
    self.TotalScore.doubleValue = totalScore;
    self.RungeKuttaScore.doubleValue = RK4Score;
    self.LucasLahmerScore.doubleValue = LLScore;
    self.BubbleSortScore.doubleValue = bubbleSortScore;
    
    TestsScore          *scoreObj=[[TestsScore alloc] initScoreWithRK4:RK4Score andLL:LLScore andBS:bubbleSortScore andTotal:totalScore];
    
    if ([fm fileExistsAtPath:fName]==YES) {
        scorsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:fName];
    } else scorsArray = [[NSMutableArray alloc] init];
    
    [scorsArray addObject:scoreObj];
    [NSKeyedArchiver archiveRootObject:scorsArray toFile:fName];
    
    [[self ScoreDetailsButton] setEnabled:YES];
}

- (IBAction)ClearButton:(id)sender {
    NSString            *fName=@"bench_archive";
    NSFileManager       *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fName]==YES) {
        [fm removeItemAtPath:fName error:nil];
        NSLog(@"All of the elements have been removed");
    }else NSLog(@"There is nothing that can be removed");
}

- (IBAction)ScoreDetailsButton:(id)sender {
}

@end
