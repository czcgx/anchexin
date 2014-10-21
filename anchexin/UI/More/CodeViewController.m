//
//  CodeViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

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
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
    //背景视图
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(60, mainView.frame.size.height/2-100, 200, 200)];
    [img setImageWithURL:[NSURL URLWithString:[userDic objectForKey:@"qrurl"]] placeholderImage:nil];
    [mainView addSubview:img];
    
    [mainView addSubview:[self customLabel:CGRectMake(0, mainView.frame.size.height/2+130, WIDTH, 20) color:[UIColor darkGrayColor] text:@"用户个人身份识别" alignment:0 font:13.0]];
    
    [self.view addSubview:mainView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
