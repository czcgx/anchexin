//
//  RegisterViewController.m
//  anchexin
//
//  Created by cgx on 14-9-5.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize state;

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
    if (state==1)
    {
        self.title=@"注册";
    }
    else
    {
        self.title=@"忘记密码";
    }
    
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0))];
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
    
    //[subView addSubview:[self customImageView:CGRectMake(15, 65, 20, 20) image:IMAGE(@"login_pwd")]];//图标
    codeTextField=[[UITextField alloc] initWithFrame:CGRectMake(15, 57, 180, 35)];
    codeTextField.returnKeyType=UIReturnKeyDone;
    codeTextField.font=[UIFont systemFontOfSize:15.0];
    codeTextField.placeholder=@"请点击右侧获取验证码";
    codeTextField.delegate=self;
    codeTextField.borderStyle=UITextBorderStyleRoundedRect;
    codeTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [subView addSubview:codeTextField];
    [subView addSubview:[self customView:CGRectMake(230, 57, 80, 35) labelTitle:@"验证码" buttonTag:1]];
    
    UILabel *lineDown=[[UILabel alloc] initWithFrame:CGRectMake(0, 99, WIDTH, 1)];
    lineDown.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lineDown];
    [mainView addSubview:subView];
    
    
    //[mainView addSubview:[self customView:CGRectMake(50, 140, 100, 35) labelTitle:@"注册" buttonTag:2]];
    
    //[mainView addSubview:[self customView:CGRectMake(170, 140, 100, 35) labelTitle:@"登录" buttonTag:1]];
    
    [self.view addSubview:mainView];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        requestTimes=1;
        if (userTextField.text.length==11)
        {
            [[self JsonFactory] getSecret:userTextField.text action:@"getSecret"];
        }
        else
        {
            [self alertOnly:@"您输入的手机号有误"];
        }
    }
    else if(sender.tag==2)
    {
        if (pwdTextField.text.length>0 && userTextField.text.length==11 && codeTextField.text.length==6)
        {
            requestTimes=2;
            [[self JsonFactory] newRegister:pwdTextField.text mobile:userTextField.text secret:codeTextField.text action:@"newRegister"];
        }
        else
        {
            [self alertOnly:@"请检查您是否输入有误"];
        }
    }
    else
    {
        if (userTextField.text.length==11 && codeTextField.text.length==6)
        {
            requestTimes=3;
            [[self JsonFactory] forgetPassword:userTextField.text secret:codeTextField.text action:@"forgetPassword"];
        }
        else
        {
            [self alertOnly:@"请检查您是否输入有误"];
        }

    }
}
-(void)JSONSuccess:(id)responseObject
{
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        [self alertOnly:@"验证码正在发送..."];
        
        if (state==1)
        {
            UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 130, WIDTH, 50)];
            subView.backgroundColor=[UIColor whiteColor];
            [mainView addSubview:subView];
            
            UILabel *lineup=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH,1)];
            lineup.backgroundColor=kUIColorFromRGB(CommonLinebg);
            [subView addSubview:lineup];
            
            [subView addSubview:[self customImageView:CGRectMake(15, 15, 20, 20) image:IMAGE(@"login_pwd")]];//图标
            pwdTextField=[[UITextField alloc] initWithFrame:CGRectMake(50, 5, 260, 40)];
            pwdTextField.returnKeyType=UIReturnKeyDone;
            pwdTextField.font=[UIFont systemFontOfSize:15.0];
            pwdTextField.placeholder=@"请输入密码";
            pwdTextField.delegate=self;
            pwdTextField.borderStyle=UITextBorderStyleRoundedRect;
            pwdTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            [subView addSubview:pwdTextField];
            
            UILabel *lineDown=[[UILabel alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
            lineDown.backgroundColor=kUIColorFromRGB(CommonLinebg);
            [subView addSubview:lineDown];
            
            [mainView addSubview:[self customView:CGRectMake(60, 200, 200, 40) labelTitle:@"注册" buttonTag:2]];

        }
        else
        {
            
            [mainView addSubview:[self customView:CGRectMake(60, 150, 200, 40) labelTitle:@"密码发送到手机" buttonTag:3]];
            
        }
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        //保存用户信息
        [document saveDataToDocument:@"user" fileData:[responseObject objectForKey:@"user"]];
        //保存车辆信息
        [document saveDataToDocument:@"car" fileData:[responseObject objectForKey:@"carlist"]];
        //保存天气油价信息
        [document saveDataToDocument:@"weatherOil" fileData:responseObject];
        
        
        [AppDelegate setGlobal].token=[[responseObject objectForKey:@"user"] objectForKey:@"token"];
        [AppDelegate setGlobal].uid=[[responseObject objectForKey:@"user"]  objectForKey:@"userid"];
        
        /*
        UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
        [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
        [AppDelegate setGlobal].rootController.view.frame=CGRectMake(WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
        
        MoreViewController *more=[[MoreViewController alloc] init];
        [AppDelegate setGlobal].rootController.leftViewController = more;
        
        CityViewController *city=[[CityViewController alloc] init];
        [AppDelegate setGlobal].rootController.rightViewController=city;
        
        [[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.view.frame=CGRectMake(-WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
            [AppDelegate setGlobal].rootController.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
        }];
         */
        
        //选择车辆
        CarTypeViewController *type=[[CarTypeViewController alloc] init];
        type.state=1;
        [self.navigationController pushViewController:type animated:YES];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==3)
     {
         [self alertOnly:@"密码已成功发送您手机,请稍后查看..."];
         
         [self.navigationController popViewControllerAnimated:YES];
     }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
