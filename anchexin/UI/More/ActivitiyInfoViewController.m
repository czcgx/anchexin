//
//  ActivitiyInfoViewController.m
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "ActivitiyInfoViewController.h"

@interface ActivitiyInfoViewController ()

@end

@implementation ActivitiyInfoViewController
@synthesize activityInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    self.title=@"活动详情";

    activityWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBar,WIDTH,480-NavigationBar-50+(iPhone5?88:0))];
    activityWebView.delegate=self;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [activityWebView setScalesPageToFit:YES];
    [self.view addSubview:activityWebView];
    
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, activityWebView.frame.size.height+NavigationBar, WIDTH, 50)];
    view.backgroundColor=kUIColorFromRGB(Commonbg);
    
    if ([[activityInfo objectForKey:@"have"] isEqualToString:@"true"])
    {
        titleView=[self customView:CGRectMake(20, 7, 280, 35) labelTitle:@"活动已经领取" buttonTag:1];
        [view addSubview:titleView];
    }
    else
    {
        titleView=[self customView:CGRectMake(20, 7, 280, 35) labelTitle:@"领取参加活动" buttonTag:2];
        [view addSubview:titleView];
    }
    [self.view addSubview:view];
    
   
    [ToolLen ShowWaitingView:YES];
    requestFlag=1;
    [[self JsonFactory]getActivityDetail:[activityInfo objectForKey:@"id"] action:@"getActivityDetail"];
    
}


-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==2)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            requestFlag=2;
            [[self JsonFactory]getActivityDetail:[activityInfo objectForKey:@"id"] action:@"receiveActivity"];
        }
       
    }
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestFlag==1)
    {
         [activityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[responseObject objectForKey:@"url"]]]];
    }
    else  if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestFlag==2)
    {
        [activityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[responseObject objectForKey:@"url"]]]];
        
        [titleView removeFromSuperview];
        titleView=[self customView:CGRectMake(20, 7, 280, 35) labelTitle:@"活动已经领取" buttonTag:1];
        [view addSubview:titleView];
    }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
}


#pragma mark －webview的委托代理的实现
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [ToolLen ShowWaitingView:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [ToolLen ShowWaitingView:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [ToolLen ShowWaitingView:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请求网页失败"
                                                 message:nil
                                                delegate:nil
                                       cancelButtonTitle:@"确定"
                                       otherButtonTitles: nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
