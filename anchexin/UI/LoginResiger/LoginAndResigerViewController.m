//
//  LoginAndResigerViewController.m
//  anchexin
//
//  Created by cgx on 14-9-5.
//
//

#import "LoginAndResigerViewController.h"

@interface LoginAndResigerViewController ()

@end

@implementation LoginAndResigerViewController

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
    self.title=@"登录";
    
    //NSLog(@"user::%@",userDic);
    //NSLog(@"car:%@",carArray);
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0))];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 100)];
    subView.backgroundColor=[UIColor whiteColor];
    UILabel *lineUp=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    lineUp.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lineUp];
    
    [subView addSubview:[self customImageView:CGRectMake(15, 15, 20, 20) image:IMAGE(@"login_name")]];//图标
    userTextField=[[UITextField alloc] initWithFrame:CGRectMake(50, 5, 260, 40)];
    userTextField.returnKeyType=UIReturnKeyDone;
    userTextField.font=[UIFont systemFontOfSize:15.0];
    userTextField.placeholder=@"请输入手机号";
    userTextField.delegate=self;
    userTextField.borderStyle=UITextBorderStyleNone;
    userTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [subView addSubview:userTextField];
    
    UILabel *lineMiddle=[[UILabel alloc] initWithFrame:CGRectMake(10, 49.5, 300, 0.5)];
    lineMiddle.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lineMiddle];
    
    [subView addSubview:[self customImageView:CGRectMake(15, 65, 20, 20) image:IMAGE(@"login_pwd")]];//图标
    pwdTextField=[[UITextField alloc] initWithFrame:CGRectMake(50, 55, 260, 40)];
    pwdTextField.returnKeyType=UIReturnKeyDone;
    pwdTextField.font=[UIFont systemFontOfSize:15.0];
    pwdTextField.delegate=self;
    pwdTextField.placeholder=@"请输入密码";
    pwdTextField.borderStyle=UITextBorderStyleNone;
    pwdTextField.keyboardType=UIKeyboardTypeNamePhonePad;
    [subView addSubview:pwdTextField];
    
    UILabel *lineDown=[[UILabel alloc] initWithFrame:CGRectMake(0, 99, WIDTH, 1)];
    lineDown.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lineDown];
    [mainView addSubview:subView];
    

    //[mainView addSubview:[self customView:CGRectMake(50, 140, 100, 35) labelTitle:@"注册" buttonTag:2]];
    
    [mainView addSubview:[self customView:CGRectMake(60, 140, 200, 40) labelTitle:@"登录" buttonTag:1]];
    
    [self.view addSubview:mainView];
    
}



-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)//登录
    {
        [userTextField resignFirstResponder];
        [pwdTextField resignFirstResponder];
        
        if (userTextField.text.length >0 && pwdTextField.text.length >0)
        {
            [ToolLen ShowWaitingView:YES];
            [[self JsonFactory] get_login:userTextField.text loginpwd:pwdTextField.text action:@"login"];
        }
        else
        {
            [self alertOnly:@"请输入正确的账号密码"];
        }
        
    }
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"vaild"];//保存有效
        //保存用户信息
        [document saveDataToDocument:@"user" fileData:[responseObject objectForKey:@"user"]];
        //保存车辆信息
        [document saveDataToDocument:@"car" fileData:[responseObject objectForKey:@"carlist"]];
        //保存天气油价信息
        [document saveDataToDocument:@"weatherOil" fileData:responseObject];
        
        [AppDelegate setGlobal].token=[[responseObject objectForKey:@"user"] objectForKey:@"token"];
        [AppDelegate setGlobal].uid=[[responseObject objectForKey:@"user"]  objectForKey:@"userid"];
        
        UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
        [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
        
       // [AppDelegate setGlobal].rootController.view.frame=CGRectMake(WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
        
        MoreViewController *more=[[MoreViewController alloc] init];
        [AppDelegate setGlobal].rootController.leftViewController = more;
        
        CityViewController *city=[[CityViewController alloc] init];
        [AppDelegate setGlobal].rootController.rightViewController=city;
        
        /*
        [[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.view.frame=CGRectMake(-WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
            [AppDelegate setGlobal].rootController.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
        }];
         */
        
        [self.navigationController presentViewController:[AppDelegate setGlobal].rootController animated:YES completion:^{
            
        }];
    }
    else
    {
        
        [self alertOnly:[responseObject objectForKey:@"message"]];
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
