//
//  ViewController.m
//  XZ_login
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ZZTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
//    UIViewController * lvc = [[[UIViewController alloc] init] initView];
    UIViewController * lvc = [[UIViewController alloc] init];
    [UIViewController initView:lvc];
    [self presentViewController:lvc animated:YES completion:^{
        lvc.view.backgroundColor = [UIColor whiteColor];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
