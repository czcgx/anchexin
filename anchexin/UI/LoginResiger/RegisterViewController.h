//
//  RegisterViewController.h
//  anchexin
//
//  Created by cgx on 14-9-5.
//
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController
{
    UITextField *userTextField;
    
    int requestTimes;
    
    UIView *mainView;
    
    UITextField *codeTextField;
    
    UITextField *pwdTextField;
}

@property(nonatomic,assign)int state;

@end
