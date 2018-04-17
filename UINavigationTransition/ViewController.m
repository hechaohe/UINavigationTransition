//
//  ViewController.m
//  UINavigationTransition
//
//  Created by hc on 2018/4/17.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(100, 200, 100, 50);
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorNamed:@"goodColor"];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushToB) forControlEvents:UIControlEventTouchUpInside];
    
}


- (IBAction)pushToB:(UIButton *)sender {

    [self.navigationController pushViewController:[BViewController new] animated:YES];

}

- (void)pushToB {
    [self.navigationController pushViewController:[BViewController new] animated:YES];
}


@end
