//
//  ViewController.m
//  DYYNetworkJudge
//
//  Created by 杜阳阳 on 16/10/26.
//  Copyright © 2016年 dyy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

- (IBAction)judgeNetwork:(id)sender {
    NSString *urlString = @"http://www.baidu.com";
    //普通网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSError *error;
        NSHTTPURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:urlString]] returningResponse:&response error:&error];
        if (!data) {
            //safari网络请求
            SFSafariViewController *sfViewControllr = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:urlString]];
            sfViewControllr.view.frame = [[UIScreen mainScreen] bounds];
            [self addChildViewController:sfViewControllr];
            [self.view addSubview:sfViewControllr.view];
            sfViewControllr.delegate = self;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"网络正常" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            });
        };
    });
}

#pragma mark ----------SFSafariViewControllerDelegate--------------

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully{
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
    UIAlertView *alert;
    if (didLoadSuccessfully) {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请前往设置，取消对本应用网络的禁止！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请检查网络！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

#pragma clang diagnostic pop

@end
