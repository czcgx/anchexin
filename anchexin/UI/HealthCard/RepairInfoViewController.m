//
//  RepairInfoViewController.m
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "RepairInfoViewController.h"

@interface RepairInfoViewController ()

@end

@implementation RepairInfoViewController
@synthesize repairRecord;

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
    // Do any additional setup after loading the view
    [self skinOfBackground];
    
    UIWebView *infoWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    infoWebView.delegate=self;
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *urlString=[NSString stringWithFormat:@"http://apiv200.anchexin.com/getRepairOrder?repairOrder=%@&isVip=1",[repairRecord objectForKey:@"id"]];
    //NSLog(@"urlString:%@",urlString);
    
    [infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    [infoWebView setScalesPageToFit:YES];
    [self.view addSubview:infoWebView];

}


#pragma mark －webview的委托代理的实现
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
