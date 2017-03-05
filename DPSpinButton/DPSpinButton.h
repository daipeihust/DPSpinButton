//
//  DPSpinButton.h
//  TemplateSpinDemo
//
//  Created by DaiPei on 2017/2/21.
//  Copyright © 2017年 DaiPei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SpinState) {
    SpinStateFree,
    SpinStateBusy,
    SpinStateCount
};

@protocol DPSpinButtonDelegate;

@interface DPSpinButton : UIView

@property (nonatomic, weak) id<DPSpinButtonDelegate> delegate;

- (void)spinStateChangeTo:(SpinState)state;


@end

@protocol DPSpinButtonDelegate <NSObject>

- (void)giftSpinButtonDidPress:(DPSpinButton *)giftSpinButton;
- (void)giftSpinButtonDidFree:(DPSpinButton *)giftSpinButton;

@end
