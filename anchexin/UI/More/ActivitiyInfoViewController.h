//
//  ActivitiyInfoViewController.h
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "BaseViewController.h"

@interface ActivitiyInfoViewController : BaseViewController<UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *activityWebView;
    int requestFlag;
    
    UIView *view;
    UIView *titleView;

    UIView *alertView;
    
    NSArray *payArray;
    NSDictionary *payInfo;
}

@property(nonatomic,retain)NSDictionary *activityInfo;

@end
