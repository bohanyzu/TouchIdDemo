//
//  TouchIdViewController.m
//  TouchIDDemo
//
//  Created by Bohan on 11/17/15.
//  Copyright © 2015 ChinaUMS. All rights reserved.
//

#import "TouchIdViewController.h"

@interface TouchIdViewController ()

@end

@implementation TouchIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imgLogoV = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width -220)/2, 100, 220, 165)];
    [imgLogoV setImage:[UIImage imageNamed:@"touchIdLogo.jpg"]];
    [self.view addSubview:imgLogoV];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [AuthenticationWithBiometrics evaluateMessage:self.strAuthReason withBlock:^(BOOL isSuccess, NSString *errorInfo) {
        if (isSuccess) {
            [self.delegate authenticDidSuccess];
        }
        else
        {
            if ([errorInfo isEqualToString:SHOW_PASSWORD_INPUT_TAG]) {
                [self.delegate didSelecteCustomPassword];
            }
            else
            {
                 [self.delegate authenticDidFailWithInfo:errorInfo];
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
