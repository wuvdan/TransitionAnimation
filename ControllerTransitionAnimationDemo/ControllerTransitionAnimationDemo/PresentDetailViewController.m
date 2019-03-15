//
//  PresentDetailViewController.m
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import "PresentDetailViewController.h"

@interface PresentDetailViewController () {
    UIButton *button;
    CGPoint _startLocation;
}
@property (nonatomic, strong, readwrite) UIView *backView; ///< 背景View

@end

@implementation PresentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backView = [[UIView alloc] init];
    self.backView.frame = self.view.bounds;
    [self.view addSubview:self.backView];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击这个页面消失" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.center = self.view.center;
    button.bounds = CGRectMake(0, 0, self.view.frame.size.width, 30);
    [button addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview: button];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizedPanGesture:)];
    [self.backView addGestureRecognizer:pan];
}

- (void)didRecognizedPanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint point       = [panGesture translationInView:self.view];
    CGPoint location    = [panGesture locationInView:self.view];
    CGPoint velocity    = [panGesture velocityInView:self.view];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _startLocation = location;
            break;
        case UIGestureRecognizerStateChanged: {
            double percent = 1 - fabs(point.y) / self.backView.frame.size.height;
            percent  = MAX(percent, 0);
            double s = MAX(percent, 0.5);
            
            CGAffineTransform translation = CGAffineTransformMakeTranslation(point.x / s, point.y / s);
            CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
            self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:percent];
            self.backView.transform = CGAffineTransformConcat(translation, scale);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            if (fabs(point.y) > 200 || fabs(velocity.y) > 500) {
                [self dismissViewControllerAnimated:true completion:nil];
            } else {
                self.view.backgroundColor = [UIColor blackColor];
                self.backView.transform = CGAffineTransformIdentity;
            }
        }
            break;
        default:
            break;
    }
}

/** button点击事件 */
- (void)didTappedButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
