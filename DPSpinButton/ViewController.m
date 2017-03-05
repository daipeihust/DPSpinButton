//
//  ViewController.m
//  DPSpinButton
//
//  Created by DaiPei on 2017/3/5.
//  Copyright © 2017年 DaiPei. All rights reserved.
//

#import "ViewController.h"
#import "DPSpinButton.h"

#define ScreenWidth     CGRectGetWidth([[UIScreen mainScreen] bounds])
#define ScreenHeight    CGRectGetHeight([[UIScreen mainScreen] bounds])


@interface ViewController () <DPSpinButtonDelegate>

@property (nonatomic, strong) DPSpinButton *spinButton;
@property (nonatomic, strong) UILabel *tintLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger second;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.spinButton = [[DPSpinButton alloc] init];
    self.spinButton.frame = CGRectMake(0, ScreenHeight / 2, ScreenWidth, ScreenHeight / 2);
    [self.view addSubview:self.spinButton];
    self.spinButton.delegate = self;
    
    self.tintLabel = [[UILabel alloc] init];
    self.tintLabel.text = @"Free";
    self.tintLabel.font = [UIFont systemFontOfSize:40];
    [self.tintLabel sizeToFit];
    self.tintLabel.center = CGPointMake(100, 100);
    [self.view addSubview:self.tintLabel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DPSpinButtonDelegate

- (void)giftSpinButtonDidPress:(DPSpinButton *)giftSpinButton {
    
    [giftSpinButton spinStateChangeTo:SpinStateBusy];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    self.second = 5;
    self.tintLabel.text = [self stringFromSecond:self.second];
    [self.tintLabel sizeToFit];
}

- (void)giftSpinButtonDidFree:(DPSpinButton *)giftSpinButton {
    NSLog(@"button did free");
}

#pragma mark - Action Method

- (void)timerFired:(NSTimer *)sender {
    if (self.second > 0) {
        self.second--;
        self.tintLabel.text = [self stringFromSecond:self.second];
        [self.tintLabel sizeToFit];
    }else {
        [self.spinButton spinStateChangeTo:SpinStateFree];
        self.tintLabel.text = @"Free";
        [sender invalidate];
    }
}

#pragma mark - Private Method

- (NSString *)stringFromSecond:(NSUInteger)second {
    return [NSString stringWithFormat:@"Spin end in %lu s", (unsigned long)second];
    
}

@end
