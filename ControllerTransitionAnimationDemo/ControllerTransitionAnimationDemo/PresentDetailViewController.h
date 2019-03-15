//
//  PresentDetailViewController.h
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PresentDetailViewController : UIViewController
@property (nonatomic, strong, readonly) UIView *backView; ///< 背景View
@property (nonatomic, strong) UIColor *backColor; ///< 背景颜色
@end

NS_ASSUME_NONNULL_END
