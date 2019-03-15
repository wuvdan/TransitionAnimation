//
//  TransitionAnimator.h
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Push
@interface TransitionAnimatorPush : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *sourceView; ///< 点击的View

@end

#pragma mark - Pop
@interface TransitionAnimatorPop: NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *sourceView; ///< 点击的View

@end

@interface TransitionAnimatorPresent: NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *sourceView; ///< 点击的View

@end

@interface TransitionAnimatorDimiss: NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIView *sourceView; ///< 点击的View

@end

NS_ASSUME_NONNULL_END
