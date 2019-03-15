//
//  TransitionAnimator.m
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import "TransitionAnimator.h"
#import "PresentDetailViewController.h"

#pragma mark - PushSnipImageView
@interface PushSnipImageView : UIImageView<CAAnimationDelegate> {
    CAShapeLayer *shapeLayer;
    UIView *toView;
}

- (void)setupWithToView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end

@implementation PushSnipImageView

- (void)setupWithToView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    
    toView = theView;
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRect:fromRect].CGPath;
    self.layer.mask = shapeLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithRect:toRect].CGPath;
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:false];
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    toView.hidden = false;
    [shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}


@end



#pragma mark - Push animator
@implementation TransitionAnimatorPush

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    PushSnipImageView *imageView = [[PushSnipImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [containerView addSubview:imageView];
    
    UIGraphicsBeginImageContext(UIScreen.mainScreen.bounds.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    toView.hidden = true;
    // 坐标转化
    CGRect cellRect = [_sourceView.superview convertRect:_sourceView.frame toView:_sourceView.superview];
    CGRect cell_window_rect = [_sourceView.superview convertRect:cellRect toView:UIApplication.sharedApplication.delegate.window];
    [imageView setupWithToView:toView fromRect:cell_window_rect toRect:toView.frame];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:true];
    });
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end


#pragma mark - Pop SnipImageView
@interface PopSnipImageView : UIImageView<CAAnimationDelegate> {
    CAShapeLayer *shapeLayer;
    UIView *toView;
}
- (void)setupWithToView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end

@implementation PopSnipImageView

- (void)setupWithToView:(UIView *)theView fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    
    toView = theView;
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRect:fromRect].CGPath;
    self.layer.mask = shapeLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithRect:toRect].CGPath;
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:false];
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end

#pragma mark - Pop animator
@implementation TransitionAnimatorPop

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    PopSnipImageView *imageView = [[PopSnipImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [containerView addSubview:imageView];
    
    UIGraphicsBeginImageContext(UIScreen.mainScreen.bounds.size);
    [fromView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 坐标转化
    CGRect cellRect = [_sourceView.superview convertRect:_sourceView.frame toView:_sourceView.superview];
    CGRect cell_window_rect = [_sourceView.superview convertRect:cellRect toView:UIApplication.sharedApplication.delegate.window];
    [imageView setupWithToView:fromView fromRect:fromView.frame toRect:cell_window_rect];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end



#pragma mark - Present animator
@implementation TransitionAnimatorPresent

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    PushSnipImageView *imageView = [[PushSnipImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [containerView addSubview:imageView];
    
    UIGraphicsBeginImageContext(UIScreen.mainScreen.bounds.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    toView.hidden = true;
    // 坐标转化
    CGRect cellRect = [_sourceView.superview convertRect:_sourceView.frame toView:_sourceView.superview];
    CGRect cell_window_rect = [_sourceView.superview convertRect:cellRect toView:UIApplication.sharedApplication.delegate.window];
    [imageView setupWithToView:toView fromRect:cell_window_rect toRect:toView.frame];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:true];
    });
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end


#pragma mark - Dismiss SnipImageView
@interface DismissSnipImageView : UIImageView<CAAnimationDelegate> {
    CAShapeLayer *shapeLayer;
}
- (void)setupWithFromViewController:(PresentDetailViewController *)controller fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end

@implementation DismissSnipImageView

- (void)setupWithFromViewController:(PresentDetailViewController *)controller fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRect:fromRect].CGPath;
    self.layer.mask = shapeLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithRect:toRect].CGPath;
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:false];
    animation.delegate = self;
    [shapeLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}

@end

#pragma mark - Dismiss animator
@implementation TransitionAnimatorDimiss

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    PresentDetailViewController *fromViewController = (PresentDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromViewController.view];
    
    DismissSnipImageView *imageView = [[DismissSnipImageView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [containerView addSubview:imageView];
    
    UIGraphicsBeginImageContext(UIScreen.mainScreen.bounds.size);
    [fromViewController.backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    fromViewController.backView.hidden = true;
    // 坐标转化
    CGRect cellRect = [_sourceView.superview convertRect:_sourceView.frame toView:_sourceView.superview];
    CGRect cell_window_rect = [_sourceView.superview convertRect:cellRect toView:UIApplication.sharedApplication.delegate.window];
    [imageView setupWithFromViewController:fromViewController fromRect:fromViewController.backView.frame toRect:cell_window_rect];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:true];
    });
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
