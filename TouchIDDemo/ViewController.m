//
//  ViewController.m
//  TouchIDDemo
//
//  Created by Bohan on 11/17/15.
//  Copyright © 2015 ChinaUMS. All rights reserved.
//

#import "ViewController.h"
#import "AuthenticationWithBiometrics.h"
#import "TouchIdViewController.h"

@interface ViewController ()<TouchIdDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"验证" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 50)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(showVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *lblDesp = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 20)];
    [lblDesp setText:@"没有设置手势密码，展示Touch ID验证界面"];
    [lblDesp setTextColor:[UIColor grayColor]];
    [lblDesp setFont:[UIFont systemFontOfSize:11]];
    [lblDesp setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblDesp];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"当前页面验证" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 50)];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(authentic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UILabel *lblDesp2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, 20)];
    [lblDesp2 setText:@"设置手势密码，可以直接在手势密码页面验证Touch ID"];
    [lblDesp2 setTextColor:[UIColor grayColor]];
    [lblDesp2 setFont:[UIFont systemFontOfSize:11]];
    [lblDesp2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblDesp2];
}

- (void) showVC
{
    TouchIdViewController *authVC = [[TouchIdViewController alloc] init];
    authVC.strAuthReason = @"验证一下你的指纹呵";
    authVC.delegate = self;
    [self.navigationController presentViewController:authVC animated:YES completion:^{
        
    }];
}

- (void)authentic
{
    [AuthenticationWithBiometrics evaluateMessage:@"验证一下你的指纹呵" withBlock:^(BOOL isSuccess, NSString *errorInfo) {
        if(isSuccess)
        {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功了" message:errorInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
        }
        else
        {
            
                if ([errorInfo isEqualToString:SHOW_PASSWORD_INPUT_TAG]) {
                    [self showAlert: @"用户选择输入密码，需要展示密码输入界面"];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败了" message:errorInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证结果" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark -TouchIdDelegate

- (void)authenticDidSuccess;
{
    NSLog(@"authentic Did Success");
    [self showAlert:@"验证成功"];
}

- (void)authenticDidFailWithInfo:(NSString *)info;
{
    NSLog(@"%@", info);
    [self showAlert:[NSString stringWithFormat:@"验证失败，%@",  info]];
}

- (void) didCancel;
{
    NSLog(@"didCancel");
    [self showAlert:@"用户取消"];
}

- (void)didSelecteCustomPassword
{
     NSLog(@"User selected to enter custom password");
     [self showAlert:@"用户选择输入密码，需要展示密码输入界面"];
}

@end
