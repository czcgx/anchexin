//
//  LoginAndResigerViewController.h
//  anchexin
//
//  Created by cgx on 14-9-5.
//
//

#import "BaseViewController.h"

@interface LoginAndResigerViewController : BaseViewController
{
    UITextField *userTextField;
    
    UITextField *codeTextField;
    UILabel *checkLabel;
    UIButton *checkButton;
    
    int times;
    
    NSTimer *timer;
    int requestTimes;
}

@end
