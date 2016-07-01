//
//  WaterLayout.h
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import <UIKit/UIKit.h>

//计算高度
typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath, CGFloat width);

@interface WaterLayout : UICollectionViewLayout
@property(nonatomic, assign) NSInteger lineNumber; //每行个数
@property(nonatomic, assign) CGFloat rowGap;    //行距（上下的距离）
@property(nonatomic, assign) CGFloat lineGap;   //列距（中间的距离）
@property(nonatomic, assign) UIEdgeInsets sideGap;  //边距

@property(nonatomic, copy) HeightBlock block;   //计算cell 高度

-(instancetype)initWithLineNumber:(NSInteger)lineNumber rowGap:(CGFloat)rowGap lineGap:(CGFloat)lineGap sideGap:(UIEdgeInsets)sideGap;

@end
