//
//  DetailsViewController.m
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import "DetailsViewController.h"
#import "MyCollectionViewCell.h"
#import "WaterLayout.h"
#import "LineFlowLayout.h"

#define CELLID @"DetailsViewController"


@interface DetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic, strong)UICollectionView * collectionView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self initUI];
}
-(void)initData{
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d",i+1];
        [_dataSource addObject:imageName];
    }
}
-(void)initUI{
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getter and setter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        if (self.isWater) {
            //瀑布流
            WaterLayout *layout = [[WaterLayout alloc] initWithLineNumber:3 rowGap:10 lineGap:10 sideGap:UIEdgeInsetsMake(10, 10, 10, 10)];
            layout.block = ^CGFloat(NSIndexPath *indexPath, CGFloat width){
            
                UIImage *image = [UIImage imageNamed:_dataSource[indexPath.row]];
                return ((image.size.height/image.size.width) * width);
            };
            _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:layout];

        }else{
            //线性布局
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250) collectionViewLayout:[[LineFlowLayout alloc] init]];
        }
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor yellowColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELLID];
    }
    return _collectionView;
}


#pragma mark delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    cell.imageName = _dataSource[indexPath.row];
    return cell;
}




@end
