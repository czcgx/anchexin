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
    /*
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
    
     */
    
    
    
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
    
    //[subView addSubview:[self customImageView:CGRectMake(15, 65, 20, 20) image:IMAGE(@"login_pwd")]];//图标
    codeTextField=[[UITextField alloc] initWithFrame:CGRectMake(15, 57, 180, 35)];
    codeTextField.returnKeyType=UIReturnKeyDone;
    codeTextField.font=[UIFont systemFontOfSize:15.0];
    codeTextField.placeholder=@"请点击右侧获取验证码";
    codeTextField.delegate=self;
    codeTextField.borderStyle=UITextBorderStyleRoundedRect;
    codeTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [subView addSubview:codeTextField];
    
    UIView *customView=[[UIView alloc] initWithFrame:CGRectMake(230, 57, 80, 35)];
    customView.backgroundColor=[UIColor clearColor];
    customView.layer.cornerRadius = 5;//(值越大，角就越圆)
    customView.layer.masksToBounds = YES;
    customView.layer.borderWidth=1.0;
    customView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    checkLabel=[self customLabel:customView.bounds color:[UIColor darkGrayColor] text:@"验证码" alignment:0 font:16.0];
    [customView addSubview:checkLabel];
    checkButton=[self customButton:customView.bounds tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES];
    [customView addSubview:checkButton];
    
    [subView addSubview:customView];

    
    UILabel *lineDown=[[UILabel alloc] initWithFrame:CGRectMake(0, 99, WIDTH, 1)];
    lineDown.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lineDown];
    [mainView addSubview:subView];
    
    
    [mainView addSubview:[self customView:CGRectMake(20, 140, 280, 40) labelTitle:@"登录" buttonTag:2]];
    
    [self.view addSubview:mainView];
    
    
}


//减少
-(void)reduce
{
    //NSLog(@"11111");
    
    times--;
    checkLabel.text=[NSString stringWithFormat:@"%d 秒",times];
    if (times==0)
    {
        [timer invalidate];
        timer=nil;
        
        //按钮倒计时间
        checkButton.enabled=YES;
        checkLabel.text=@"验证码";
        checkLabel.textColor=[UIColor darkGrayColor];
    }
    
}


-(void)customEvent:(UIButton *)sender
{
    
    if (sender.tag==1)//获取验证码接口
    {
        //NSLog(@"requestTimes:::%@",@"1");
        if (userTextField.text.length==11)
        {
            requestTimes=1;
            //获取验证码
            [[self JsonFactory] getSecret:userTextField.text action:@"getSecret"];
            
            //按钮倒计时间
            checkButton.enabled=NO;
            
            times=60;
            checkLabel.text=[NSString stringWithFormat:@"%d 秒",times];
            checkLabel.textColor=[UIColor lightGrayColor];
            
            timer= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduce) userInfo:nil repeats:YES];
        }
        else
        {
            [self alertOnly:@"您输入的手机号有误"];
        }
    }
    if (sender.tag==2)//登录接口
    {
        [userTextField resignFirstResponder];
        [codeTextField resignFirstResponder];
        if ([userTextField.text isEqualToString:@"anchexin"] && [codeTextField.text isEqualToString:@"111111"])
        {
            //体验接口
            [document deleteFileFromDocument:@"user"];//删除保存的用户信息
            [document deleteFileFromDocument:@"car"];//删除车辆信息
            [self refreshAccount];
            
            UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
            [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
            
            [AppDelegate setGlobal].rootController.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
            
            MoreViewController *more=[[MoreViewController alloc] init];
            [AppDelegate setGlobal].rootController.leftViewController = more;
            
            CityViewController *city=[[CityViewController alloc] init];
            [AppDelegate setGlobal].rootController.rightViewController=city;
            
            
            [[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
        }
        else
        {
            if (userTextField.text.length==11 && codeTextField.text.length==6)
            {
                [userTextField resignFirstResponder];
                [codeTextField resignFirstResponder];
                
                requestTimes=2;
                [ToolLen ShowWaitingView:YES];
                //登录接口
                [[self JsonFactory] get_login:userTextField.text secret:codeTextField.text action:@"login"];
            }
            else
            {
                [self alertOnly:@"请检查您输入的手机号或验证码正确"];
            }

        }
    }
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"vaild"];//保存有效
        //保存验证码
        [[NSUserDefaults standardUserDefaults] setObject:codeTextField.text forKey:@"checkCode"];
        
        //保存天气油价信息
        [document saveDataToDocument:@"weatherOil" fileData:responseObject];
        
        //保存用户信息
        [document saveDataToDocument:@"user" fileData:[responseObject objectForKey:@"user"]];
        
        //保存车辆信息
        [document saveDataToDocument:@"car" fileData:[responseObject objectForKey:@"car"]];
        
        [AppDelegate setGlobal].token=[[responseObject objectForKey:@"user"] objectForKey:@"token"];
        [AppDelegate setGlobal].uid=[[responseObject objectForKey:@"user"]  objectForKey:@"id"];
        
        if ([[responseObject objectForKey:@"car"] count]>0)
        {
            
            if ([[[responseObject objectForKey:@"car"] objectForKey:@"current_mileage"] intValue]==0 || [[[responseObject objectForKey:@"car"] objectForKey:@"license_number"] isEqualToString:@""])
            {
                
                CarInfoViewController *car=[[CarInfoViewController alloc] init];
                car.title=@"车辆信息";
                car.carInfo=[responseObject objectForKey:@"car"];
                car.flag=true;
                [self.navigationController pushViewController:car animated:YES];
            }
            else
            {
                [self refreshAccount];
                
                UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
                [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
                
                [AppDelegate setGlobal].rootController.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
                
                MoreViewController *more=[[MoreViewController alloc] init];
                [AppDelegate setGlobal].rootController.leftViewController = more;
                
                CityViewController *city=[[CityViewController alloc] init];
                [AppDelegate setGlobal].rootController.rightViewController=city;
                
                //[[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
                
                [[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
            }
        }
        else
        {
            
            CarInfoViewController *car=[[CarInfoViewController alloc] init];
            car.title=@"车辆信息";
            car.flag=false;
            
            [self.navigationController pushViewController:car animated:YES];
            
        }
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
