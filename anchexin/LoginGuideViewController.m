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
    self.navigationItem.backBarButtonItem=nil;
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton=YES;
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    img.image=IMAGE(@"Default");
    [self.view addSubview:img];
    
    [self.view addSubview:[self customButton:CGRectMake(30, self.view.frame.size.height/2, 120, 120) tag:1 title:@"体验" state:0 image:IMAGE(@"login_btn") selectImage:IMAGE(@"login_btnbg")  color:[UIColor whiteColor] enable:YES]];
    
    [self.view addSubview:[self customButton:CGRectMake(160+10,self.view.frame.size.height/2, 120, 120) tag:3 title:@"登录" state:0 image:IMAGE(@"login_btn") selectImage:IMAGE(@"login_btn")  color:[UIColor whiteColor] enable:YES]];
    
    //[self.view addSubview:[self customView:CGRectMake(30, 280+(iPhone5?30:0), 260, 40) labelTitle:@"登录" buttonTag:3]];
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
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
    else if(sender.tag==3)//登录
    {
        LoginAndResigerViewController *login=[[LoginAndResigerViewController alloc] init];
        login.hidesBottomBarWhenPushed=YES;
    
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
