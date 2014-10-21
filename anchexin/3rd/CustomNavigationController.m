//
//  CustomNavigationController.m
//  AnCheXin
//
//  Created by cgx on 13-11-6.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CustomNavigationController.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

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
    
   //

    
    /*
    self.navigationBar.translucent=YES;//不透明
        
    //设置为UIRectEdgeNone,即从导航栏下面计算，（0，0）。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationBar.barTintColor=[UIColor clearColor];
    self.navigationBar.tintColor = kUIColorFromRGB(0x000000);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:kUIColorFromRGB(0x000000), NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0], NSFontAttributeName, nil]];
     */

    
    // Set Navigation Bar style
    CGRect rect = CGRectMake(0.0f, 0.0f, ScreenWidth,64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 1.0 alpha:0.0f] CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor: [UIColor clearColor]];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment: 0.0f forBarMetrics: UIBarMetricsDefault];//title的位置
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    ;    //设置文本的阴影色彩和透明度。
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:kUIColorFromRGB(0xFFFFFF), NSForegroundColorAttributeName,  [UIColor colorWithWhite:0.1f alpha:0.5f], UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1.0)], UITextAttributeTextShadowOffset, [UIFont systemFontOfSize:20.0], UITextAttributeFont,nil]];//title的颜色
    
    
    
    /*
    UIColor *titleColor = [UIColor colorWithRed: 150.0f/255.0f green: 149.0f/255.0f blue: 149.0f/255.0f alpha: 1.0f];
    UIColor* shadowColor = [UIColor colorWithWhite: 1.0 alpha: 1.0];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
*/
    
    
    
    
}

//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1 )
    {
         viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];//重新定义左按钮
    }
    
}


-(UIBarButtonItem*)customLeftBackButton
{
    /*
   // UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                  style:UIBarButtonItemStylePlain target:self
                                                                 action:@selector(popself)];
    */
    
    
    UIImage *image=IMAGE(@"thebackbuttonbg");//返回按钮的背景
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 10, 20, 20);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backItem;
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
