//
//  StationImgViewController.m
//  anchexin
//
//  Created by cgx on 14-9-16.
//
//

#import "StationImgViewController.h"

@interface StationImgViewController ()

@end

@implementation StationImgViewController
@synthesize stationId;

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
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    imgScrollView=[[UIScrollView alloc] initWithFrame:mainView.bounds];
    [mainView addSubview:imgScrollView];
    [self.view addSubview:mainView];
    
    
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory]get_getRepairStationImage:stationId action:@"getRepairStationImage"];
    
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 150)];
        [imgView setImageWithURL:[NSURL URLWithString:[responseObject objectForKey:@"image"]] placeholderImage:nil];
        
        [imgScrollView addSubview:imgView];
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
