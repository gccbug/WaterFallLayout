//
//  LineFlowLayout.m
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import "LineFlowLayout.h"
#import "UIView+ChangeFrameValue.h"

static CGFloat const itemHW = 100;
static CGFloat screenWidth;


@interface LineFlowLayout()
@property (nonatomic, assign) BOOL firstLoaded;
@end


@implementation LineFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/**
 *  当layout准备好后 调用
 */
- (void)prepareLayout{
    [super prepareLayout];
    NSLog(@"prepareLayout");
    if (!_firstLoaded) {
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat cellInset = (self.collectionView.width - itemHW) * 0.5;
        self.itemSize = CGSizeMake(itemHW, itemHW);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, cellInset, 0, cellInset);
        self.minimumLineSpacing = 70;
        _firstLoaded = YES;
    }
}

/**
 *  判断视图滚动后的位置并返回其offset
 *
 *  @param proposedContentOffset 预计滚动后的位置
 *  @param velocity              滚动速度
 *
 *  @return 返回滚动后所停留的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.size;
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    CGFloat spacing = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        CGFloat newSpacing = attr.center.x - (proposedContentOffset.x + screenWidth * 0.5);
        if ( ABS(newSpacing) < ABS(spacing)) {
            spacing = newSpacing;
        }
    }
    CGPoint backPoint = CGPointMake(proposedContentOffset.x + spacing, proposedContentOffset.y);
    return backPoint;
}

/**
 *  设置为YES则每当显示框改变时 都会调用layout适配
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/**
 *  返回所有显示区域内item属性的方法
 *
 *  @param rect 显示区域内
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        CGRect collectionRect;
        collectionRect.origin = self.collectionView.contentOffset;
        collectionRect.size = self.collectionView.size;
        if (CGRectIntersectsRect(collectionRect, attr.frame)) {
            [self changeShowLayoutAttributes:attr];
        }
    }
    return array;
}

/**
 *  改变显示的layoutattributes属性
 */
- (void)changeShowLayoutAttributes:(UICollectionViewLayoutAttributes *)attr{
    CGFloat spacing = attr.center.x - (self.collectionView.contentOffset.x + screenWidth * 0.5);
    spacing = ABS(spacing);
    CGFloat newAlpha = 0.7;
    CGFloat scale = 1;
    if (spacing <= screenWidth * 0.5) {
        scale += 0.5 - 0.5 * (spacing / (screenWidth * 0.5));
        newAlpha += 0.3 - 0.3 * (spacing / (screenWidth * 0.5));
    }
    attr.transform3D = CATransform3DMakeScale(scale, scale, 1.0f);
    attr.alpha = newAlpha;
}

@end
