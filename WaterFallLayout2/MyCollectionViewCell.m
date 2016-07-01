//
//  MyCollectionViewCell.m
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _imageView.layer.borderWidth = 2.5;
}

-(void)setImageName:(NSString *)imageName{
    _imageView.image = [UIImage imageNamed:imageName];
}














@end
