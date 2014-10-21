//
//  VehicleDiagnosisViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "VehicleDiagnosisViewController.h"

@interface VehicleDiagnosisViewController ()

@end

@implementation VehicleDiagnosisViewController

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
    mainView.backgroundColor=kUIColorFromRGB(0xF1F1F1);
    
    [mainView addSubview:[self customLabel:CGRectMake(20, 15, 200, 20) color:[UIColor lightGrayColor] text:[NSString stringWithFormat:@"更新时间:%@",@"2014-08-01 18:02"] alignment:-1 font:13.0]];
    //横线
    UILabel *lineLabel1=[[UILabel alloc] initWithFrame:CGRectMake(15, 50, 290, 1)];
    lineLabel1.backgroundColor=[UIColor lightGrayColor];
    [mainView addSubview:lineLabel1];
    
    
    [mainView addSubview:[self customLabel:CGRectMake(20, 65, 50, 20) color:[UIColor colorWithRed:153/255.0 green:200/255.0 blue:130/255.0 alpha:1.0] text:@"VIN码" alignment:-1 font:16.0]];
    
    [mainView addSubview:[self customLabel:CGRectMake(70, 65, 200, 20) color:[UIColor colorWithRed:153/255.0 green:200/255.0 blue:130/255.0 alpha:1.0] text:@"YGSH5622SWG178749" alignment:-1 font:16.0]];
    
     [mainView addSubview:[self customLabel:CGRectMake(20, 85, 60, 20) color:[UIColor colorWithRed:153/255.0 green:200/255.0 blue:130/255.0 alpha:1.0] text:@"里程数" alignment:-1 font:16.0]];
     [mainView addSubview:[self customLabel:CGRectMake(80, 85, 200, 20) color:[UIColor colorWithRed:153/255.0 green:200/255.0 blue:130/255.0 alpha:1.0] text:@"1000公里" alignment:-1 font:16.0]];
    //横线
    UILabel *lineLabel2=[[UILabel alloc] initWithFrame:CGRectMake(0, 120, WIDTH, 1)];
    lineLabel2.backgroundColor=[UIColor lightGrayColor];
    [mainView addSubview:lineLabel2];
    
    vehicleDiagnosisArray=[[NSArray alloc] initWithObjects:@"电瓶电压",@"冷却液温度",@"发动机转速",@"发动机负荷",@"机油" ,nil];
    
    vehicleDiagnosisTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 121, WIDTH, 250)];
    vehicleDiagnosisTableView.delegate=self;
    vehicleDiagnosisTableView.dataSource=self;
    vehicleDiagnosisTableView.backgroundView=nil;
    vehicleDiagnosisTableView.backgroundColor=[UIColor clearColor];
    vehicleDiagnosisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    vehicleDiagnosisTableView.scrollEnabled=NO;
    [mainView addSubview:vehicleDiagnosisTableView];
    
    
    UILabel *lineLabel3=[[UILabel alloc] initWithFrame:CGRectMake(0, 370, WIDTH, 1)];
    lineLabel3.backgroundColor=[UIColor lightGrayColor];
    [mainView addSubview:lineLabel3];
    
    [self.view addSubview:mainView];
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [vehicleDiagnosisArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    VehicleCell *cell=(VehicleCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"VehicleCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
