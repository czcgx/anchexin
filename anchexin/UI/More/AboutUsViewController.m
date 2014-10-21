//
//  AboutUsViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    img.image=IMAGE(@"Default");

    [self.view addSubview:img];
    
    UILabel *des=[self customLabel:CGRectMake(20, 150+(iPhone5?40:0), 280, 200) color:[UIColor whiteColor] text:@"上海安车信信息技术有限公司融合了移动互联网的前沿科技与汽车后市场的优质线下资源，以车主安心便捷地养车用车为己任，打造全新的车辆健康管理体验。" alignment:0 font:16.0];
    des.numberOfLines=0;
    [self.view addSubview:des];
    
    [self.view addSubview:[self customLabel:CGRectMake(0, img.frame.size.height-40, WIDTH, 20) color:[UIColor whiteColor] text:@"v2.0.0" alignment:0 font:12.0]];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
