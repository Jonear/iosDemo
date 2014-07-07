//
//  ADLivelyTableView.m
//  ADLivelyTableView
//
//  Created by Romain Goyet on 18/04/12.
//  Copyright (c) 2012 Applidium. All rights reserved.
//

#import "ADLivelyTableView.h"
#import <QuartzCore/QuartzCore.h>

NSTimeInterval ADLivelyDefaultDuration = 0.2;

CGFloat CGFloatSign(CGFloat value) {
    if (value < 0) {
        return -1.0f;
    }
    return 1.0f;
}

ADLivelyTransform ADLivelyTransformFade = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * ADLivelyDefaultDuration;
};

@implementation ADLivelyTableView
#pragma mark - NSObject
- (void)dealloc {
    Block_release(_transformBlock);
    [super dealloc];
}

#pragma mark - UIView
+ (Class)layerClass {
    // This lets us rotate cells in the tableview's 3D space
    return [CATransformLayer class];
}

#pragma mark - UITableView
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    // The order here is important, as there seem to be some observing done on setDelegate:
    if (delegate == self) {
        _preLivelyDelegate = nil;
    } else {
        _preLivelyDelegate = delegate;
    }
    [super setDelegate:self];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_preLivelyDelegate respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([_preLivelyDelegate respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:_preLivelyDelegate];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

#pragma mark - ADLivelyTableView
- (CGPoint)scrollSpeed {
    return CGPointMake(_lastScrollPosition.x - _currentScrollPosition.x,
                       _lastScrollPosition.y - _currentScrollPosition.y);
}

- (void)setInitialCellTransformBlock:(ADLivelyTransform)block {
    CATransform3D transform = CATransform3DIdentity;
    if (block != nil) {
        transform.m34 = -1.0/self.bounds.size.width;
    }
    self.layer.transform = transform;

    if (block != _transformBlock) {
        Block_release(_transformBlock);
        _transformBlock = Block_copy(block);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_preLivelyDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_preLivelyDelegate scrollViewDidScroll:scrollView];
    }
    _lastScrollPosition = _currentScrollPosition;
    _currentScrollPosition = [scrollView contentOffset];
}

#pragma mark - UITableViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_preLivelyDelegate respondsToSelector:@selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:)]) {
        [_preLivelyDelegate collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }
    
    float speed = self.scrollSpeed.y;
    float normalizedSpeed = MAX(-1.0f, MIN(1.0f, speed/20.0f));
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_transformBlock) {
            NSTimeInterval animationDuration = _transformBlock(cell.layer, normalizedSpeed);
            // The block-based equivalent doesn't play well with iOS 4
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:animationDuration];
        }
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1.0f;
        if (_transformBlock) {
            [UIView commitAnimations];
        }
    });
}

@end
