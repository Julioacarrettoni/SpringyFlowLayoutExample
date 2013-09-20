//
//  SpringyFLowLayout.m
//  SpringyFlowLayoutExample
//
//  Created by Julio Andrés Carrettoni on 19/08/13.
//  Copyright (c) 2013 Julio Andrés Carrettoni. All rights reserved.
//

#import "SpringyFLowLayout.h"

@implementation SpringyFLowLayout {
    UIDynamicAnimator* _dynamicAnimator;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        
        NSArray* items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes* item in items) {
            UIAttachmentBehavior* spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];

            spring.length = 0.0;
            spring.damping = 0.2;
            spring.frequency = 0.4;
            
            [_dynamicAnimator addBehavior:spring];
        }
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_dynamicAnimator itemsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    UIScrollView* scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior* spring in _dynamicAnimator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch/scrollView.frame.size.height;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDelta * scrollResistance;
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return NO;
}

@end
