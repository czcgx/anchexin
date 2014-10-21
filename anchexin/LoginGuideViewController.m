//
//  LoginGuideViewController.m
//  anchexin
//
//  Created by cgx on 14-9-4.
//
//

#import "LoginGuideViewController.h"

@interface LoginGuideViewController ()

@end

@implementation LoginGuideViewController

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
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    img.image=IMAGE(@"Default");
    [self.view addSubview:img];
    
   
    [self.view addSubview:[self customView:CGRectMake(60, 200+(iPhone5?30:0), 200, 35) labelTitle:@"体验" buttonTag:1]];
    [self.view addSubview:[self customView:CGRectMake(60, 250+(iPhone5?30:0), 200, 35) labelTitle:@"注册" buttonTag:2]];
    [self.view addSubview:[self customView:CGRectMake(60, 300+(iPhone5?30:0), 200, 35) labelTitle:@"登录" buttonTag:3]];
    
    [self.view addSubview:[self customLabel:CGRectMake(110, 350+(iPhone5?30:0), 100, 20) color:[UIColor darkGrayColor] text:@"忘记密码" alignment:0 font:13.0]];
    [self.view addSubview:[self customButton:CGRectMake(110, 340+(iPhone5?40:0), 100, 40) tag:4 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)//体验
    {
       
        UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
        [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
        
       //[AppDelegate setGlobal].rootController.view.frame=CGRectMake(WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
        
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
        
       // [self.navigationController pushViewController:[AppDelegate setGlobal].rootController animated:YES];
        
    }
    else if (sender.tag==2)//注册
    {
        RegisterViewController *reg=[[RegisterViewController alloc] init];
        reg.hidesBottomBarWhenPushed=YES;
        reg.state=1;
        [self.navigationController pushViewController:reg animated:YES];
        
    }
    else if(sender.tag==3)//登录
    {
        LoginAndResigerViewController *login=[[LoginAndResigerViewController alloc] init];
        login.hidesBottomBarWhenPushed=YES;
    
        [self.navigationController pushViewController:login animated:YES];
    }
    else
    {
        //NSLog(@"忘记密码");
        RegisterViewController *reg=[[RegisterViewController alloc] init];
        reg.hidesBottomBarWhenPushed=YES;
        reg.state=2;
        [self.navigationController pushViewController:reg animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
