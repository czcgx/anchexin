//
//  ToolLen.m
//  SuiXingPay
//
//  Created by wei peng on 12-9-13.
//
//

#import "ToolLen.h"
#import "AppDelegate.h"
#import "SinoNetMBProgressHUD.h"

@implementation ToolLen

UIWindow * awindow;
+(void)ShowWaitingView:(BOOL)isShow
{
    if (isShow)
    {
        if (!awindow)
        {
            awindow=[[UIWindow alloc] initWithFrame:CGRectMake(0,0, WIDTH, 480+(iPhone5?88:0))];
            //awindow.windowLevel=UIWindowLevelStatusBar;
        }
        [SinoNetMBProgressHUD hideHUDForView:awindow animated:NO];
        SinoNetMBProgressHUD *_hud = [SinoNetMBProgressHUD showHUDAddedTo:awindow animated:NO];
        
        _hud.labelText = @"加载中...";
        [awindow makeKeyAndVisible];
    }
    else{
        if (awindow) {
            [awindow resignKeyWindow];
            [awindow setHidden:YES];
            [SinoNetMBProgressHUD hideHUDForView:awindow animated:YES];
        }
    }
}


@end
