//
//  ViewController.m
//  WaterFallLayout2
//
//  Created by zhengbing on 6/30/16.
//  Copyright © 2016 zhengbing. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)water:(id)sender {
    
    DetailsViewController *d = [[DetailsViewController alloc] init];
    d.isWater = YES;
    [self.navigationController pushViewController:d animated:YES];
}

- (IBAction)line:(id)sender {
    DetailsViewController *d = [[DetailsViewController alloc] init];
    d.isWater = NO;
    [self.navigationController pushViewController:d animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
