//
//  DetailViewController.m
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import "DetailViewController.h"
#import "TransitionAnimator.h"

@interface DetailViewController ()<UINavigationControllerDelegate>
//@property (nonatomic, strong) WDPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, assign) BOOL isClickPush;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactive;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isClickPush = YES;
    self.navigationController.delegate = self;
}

#pragma mark - UINavationController delegate method
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        TransitionAnimatorPop *animator = [[TransitionAnimatorPop alloc] init];
        [self.interactive updateInteractiveTransition:0];
        animator.sourceView = self.sorceView;
        return animator;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.interactive = [[UIPercentDrivenInteractiveTransition alloc] init];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(Pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)Pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    CGFloat persent =  translatedPoint.x / [[UIScreen mainScreen] bounds].size.width;
    persent = fabs(persent);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.isClickPush = NO;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self.interactive updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (persent > 0.5) {
                [self.interactive finishInteractiveTransition];
            } else {
                [self.interactive cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
