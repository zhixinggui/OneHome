//
//  LoginViewController.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-18.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "LoginViewController.h"

#import "UserDataManager.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pswCode;
- (IBAction)Login:(UIButton *)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self initUI];
    
    
    
    
}

- (void)initUI{
    
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender {

    
}
- (IBAction)Login:(UIButton *)sender {
     NSLog(@"%@",_phoneNum.text);
    if ([_phoneNum.text isEqualToString:@"123"]) {
        [UserDataManager savePassWord:_phoneNum.text];
       
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
