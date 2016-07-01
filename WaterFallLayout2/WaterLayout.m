//
//  WaterLayout.m
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout()
//1.存储每列高度的一个字典
@property(nonatomic, strong) NSMutableDictionary *dictOfLineHeight;
//2.存储所有cell frame 的一个数组
@property(nonatomic, strong) NSMutableArray *arrayOfCellFrame;
@end

@implementation WaterLayout

-(instancetype)initWithLineNumber:(NSInteger)lineNumber rowGap:(CGFloat)rowGap lineGap:(CGFloat)lineGap sideGap:(UIEdgeInsets)sideGap{
    self = [super init];
    if (self) {
        self.lineNumber = lineNumber;
        self.rowGap = rowGap;
        self.lineGap = lineGap;
        self.sideGap = sideGap;
        self.dictOfLineHeight = [NSMutableDictionary dictionary];
        self.arrayOfCellFrame = [NSMutableArray array];
    }
    return self;
}

//自动布局前的准备工作
- (void)prepareLayout{
    //1.要把存储高度的字典补充值
    for (NSInteger i = 0; i < _lineNumber; i++) {
        [self.dictOfLineHeight setObject:@(self.sideGap.top) forKey:[NSString stringWithFormat:@"%ld",i]];
    }
    //2.把cell 的尺寸存进数组
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [_arrayOfCellFrame addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}
//返回所以cell frame 信息的数组
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    return _arrayOfCellFrame;
}
//计算每个cell 的 frame 值
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //经过了逻辑处理，计算出了cell 的frame
    CGRect frame;
    CGFloat cellW = (self.collectionView.bounds.size.width - _sideGap.left - _sideGap.right - self.lineGap*(self.lineNumber - 1))/self.lineNumber;
    CGFloat cellH;
    if (self.block) {
        cellH = self.block(indexPath,cellW);
    }
    __block NSString *keyOfMinHeight = @"0";
    [_dictOfLineHeight enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_dictOfLineHeight[keyOfMinHeight] floatValue] > [obj floatValue]) {
            keyOfMinHeight = key;
        }
    }];
    NSInteger minHeiLineNumber = [keyOfMinHeight integerValue];
    CGFloat pointX = (self.sideGap.left + minHeiLineNumber * (self.lineGap + cellW));
    CGFloat pointY = [_dictOfLineHeight[keyOfMinHeight] floatValue];
    frame = CGRectMake(pointX, pointY, cellW, cellH);
    //更新高度
    _dictOfLineHeight[keyOfMinHeight] = @([_dictOfLineHeight[keyOfMinHeight] floatValue] + cellH + self.rowGap);
    
    attr.frame = frame;
    return attr;
}
//返回 集合视图的宽高
- (CGSize)collectionViewContentSize{
    __block NSString *keyOfMaxHeight = @"0";
    [_dictOfLineHeight enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_dictOfLineHeight[keyOfMaxHeight] floatValue] < [obj floatValue]) {
            keyOfMaxHeight = key;
        }
    }];
    return CGSizeMake(self.collectionView.bounds.size.width, [_dictOfLineHeight[keyOfMaxHeight] floatValue]);
}

@end
