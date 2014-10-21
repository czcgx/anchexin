//
//  GuideViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

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
    
    [MobClick event:@"opGuidePage"];//统计操作指南页面
    
    guideScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    guideScrollView.delegate=self;
    guideScrollView.userInteractionEnabled=YES;
    guideScrollView.pagingEnabled=YES;
    
    guideScrollView.contentSize=CGSizeMake(3*WIDTH, guideScrollView.frame.size.height);

    for (int i=0; i<3; i++)
    {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, guideScrollView.frame.size.height)];
        NSString *iconStr=nil;
        if (iPhone5)
        {
            iconStr=[NSString stringWithFormat:@"page%d_1",i+1];
        }
        else
        {
            iconStr=[NSString stringWithFormat:@"page%d",i+1];
        }
       
        img.image=IMAGE(iconStr);
        
        
        [guideScrollView addSubview:img];
        
        
    }
    
    [self.view addSubview:guideScrollView];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/3) / pagewidth) + 1;
    //NSLog(@"currentPage::%d",currentPage);
    if (currentPage==2)
    {
         [self.view addSubview:[self customButton:CGRectMake(100, 480+(iPhone5?88:0)-150,120, 100) tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }
    
}
//进入首页
-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        [[AppDelegate setGlobal].rootController setRootController:[AppDelegate setGlobal].tabBarController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
