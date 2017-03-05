//
//  DPSpinButton.m
//  TemplateSpinDemo
//
//  Created by DaiPei on 2017/2/21.
//  Copyright © 2017年 DaiPei. All rights reserved.
//

#import "DPSpinButton.h"

typedef NS_ENUM(NSUInteger, TouchState) {
    TouchStatePress,
    TouchStateFree,
    TouchStateCount
};

typedef NS_ENUM(NSUInteger, ButtonState) {
    ButtonStateHigh,
    ButtonStateMid,
    ButtonStateLow,
    ButtonStateCount
};

@interface DPSpinButton ()

@property (nonatomic, strong) UIImageView *back;
@property (nonatomic, strong) UIImageView *front;
@property (nonatomic, strong) UIImageView *button;
@property (nonatomic, assign) TouchState touchState;
@property (nonatomic, assign) ButtonState buttonState;
@property (nonatomic, assign) SpinState spinState;
@property (nonatomic, assign) BOOL animated;

@end

@implementation DPSpinButton


- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.back];
        [self addSubview:self.button];
        [self addSubview:self.front];
        self.animated = NO;
        self.touchState = TouchStatePress;
        self.buttonState = ButtonStateHigh;
        self.spinState = SpinStateFree;
    }
    return self;
}

#pragma mark - Public

- (void)spinStateChangeTo:(SpinState)state {
    self.spinState = state;
    if (state == SpinStateFree && self.touchState == TouchStatePress) {
        if (self.buttonState == ButtonStateMid) {
            [self playPressAnimationAndCallDelegate];
        } else if (self.buttonState == ButtonStateLow) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(giftSpinButtonDidPress:)]) {
                [self.delegate giftSpinButtonDidPress:self];
            }
        }
    }
}

#pragma mark - Private Mehthod

- (void)playPressAnimationAndCallDelegate {
    if (self.animated) {
        return ;
    }
    self.animated = YES;
    CGFloat height = self.frame.size.height;
    if (self.spinState == SpinStateFree) {
        [UIView animateWithDuration:0.08 animations:^{
            self.button.frame = CGRectMake(0, height / 16, self.button.frame.size.width, self.button.frame.size.height);
        } completion:^(BOOL finished) {
            self.button.frame = CGRectMake(0, height / 16, self.button.frame.size.width, self.button.frame.size.height);
            self.animated = NO;
            self.buttonState = ButtonStateLow;
            if (self.touchState == TouchStateFree) {
                [self playFreeAnimationAndCallDelegate];
            }
        }];
    }else if (self.spinState == SpinStateBusy) {
        [UIView animateWithDuration:0.05 animations:^{
            self.button.frame = CGRectMake(0, height / 60, self.button.frame.size.width, self.button.frame.size.height);
        } completion:^(BOOL finished) {
            self.button.frame = CGRectMake(0, height / 60, self.button.frame.size.width, self.button.frame.size.height);
            self.animated = NO;
            self.buttonState = ButtonStateMid;
            if (self.touchState == TouchStateFree) {
                [self playFreeAnimationAndCallDelegate];
            }
        }];
    }
    if (self.spinState == SpinStateFree) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(giftSpinButtonDidPress:)]) {
            [self.delegate giftSpinButtonDidPress:self];
        }
    }
}

- (void)playFreeAnimationAndCallDelegate {
    if (self.animated) {
        return ;
    }
    self.animated = YES;
    [UIView animateWithDuration:0.08 animations:^{
        self.button.frame = CGRectMake(0, 0, self.button.frame.size.width, self.button.frame.size.height);
    } completion:^(BOOL finished) {
        self.button.frame = CGRectMake(0, 0, self.button.frame.size.width, self.button.frame.size.height);
        self.animated = NO;
        self.buttonState = ButtonStateHigh;
        if (self.touchState == TouchStatePress) {
            [self playPressAnimationAndCallDelegate];
        }
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(giftSpinButtonDidFree:)]) {
        [self.delegate giftSpinButtonDidFree:self];
    }
}

#pragma mark - Override

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.back.frame = CGRectMake(0, 0, width, height);
    self.button.frame = CGRectMake(0, 0, width, height);
    self.front.frame = CGRectMake(0, 0, width, height);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.touchState = TouchStatePress;
    
    [self playPressAnimationAndCallDelegate];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.touchState = TouchStateFree;
    
    [self playFreeAnimationAndCallDelegate];
    
}

#pragma mark - Getter

- (UIImageView *)back {
    if (!_back) {
        _back = [[UIImageView alloc] init];
        _back.image = [UIImage imageNamed:@"back"];
        _back.contentMode = UIViewContentModeCenter;
    }
    return _back;
}

- (UIImageView *)button {
    if (!_button) {
        _button = [[UIImageView alloc] init];
        _button.image = [UIImage imageNamed:@"button"];
        _button.contentMode = UIViewContentModeCenter;
    }
    return _button;
}

- (UIImageView *)front {
    if (!_front) {
        _front = [[UIImageView alloc] init];
        _front.image = [UIImage imageNamed:@"front"];
        _front.contentMode = UIViewContentModeCenter;
    }
    return _front;
}


@end
