//
//  ActivitiyInfoViewController.h
//  AnCheXin
//
//  Created by cgx on 14-7-11.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "BaseViewController.h"

@interface ActivitiyInfoViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *activityWebView;
    int requestFlag;
    
    UIView *view;
    UIView *titleView;
    
}

@property(nonatomic,retain)NSDictionary *activityInfo;

@end
