//
//  ViewController.m
//  ControllerTransitionAnimationDemo
//
//  Created by wudan on 2019/3/15.
//  Copyright © 2019 wudan. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "TransitionAnimator.h"
#import "PresentDetailViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic, strong) UIView *sorceView; ///< 点击选择的View
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"列表";
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionViewFlowLayout.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 50) / 4, (UIScreen.mainScreen.bounds.size.width - 50) / 4);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.sorceView = cell;
    
    if (indexPath.row % 2 == 0) {
        DetailViewController *vc = [[DetailViewController alloc] init];
        vc.view.backgroundColor = cell.contentView.backgroundColor;
        vc.sorceView = cell;
        [self.navigationController pushViewController:vc animated:true];
    } else {
        PresentDetailViewController *vc = [[PresentDetailViewController alloc] init];
        vc.transitioningDelegate = self;
        vc.view.backgroundColor = [UIColor clearColor];
        vc.backView.backgroundColor = cell.contentView.backgroundColor;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:vc animated:true completion:nil];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    TransitionAnimatorPresent *animator = [[TransitionAnimatorPresent alloc] init];
    animator.sourceView = self.sorceView;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    TransitionAnimatorDimiss *animator = [[TransitionAnimatorDimiss alloc] init];
    animator.sourceView = self.sorceView;
    return animator;
}

#pragma mark - UINavationController delegate method
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        TransitionAnimatorPush *animator = [[TransitionAnimatorPush alloc] init];
        animator.sourceView = self.sorceView;
        return animator;
    } else if (operation == UINavigationControllerOperationPop){
        TransitionAnimatorPop *animator = [[TransitionAnimatorPop alloc] init];
        animator.sourceView = self.sorceView;
        return animator;
    }
    return nil;
}

@end
