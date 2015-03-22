//
//  CarSeriesAndYearViewController.m
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "CarSeriesAndYearViewController.h"

@interface CarSeriesAndYearViewController ()

@end

@implementation CarSeriesAndYearViewController
@synthesize seriesid;
@synthesize year;
@synthesize brandID;
@synthesize series;

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
    
    carSeriesYearTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    carSeriesYearTableView.delegate=self;
    carSeriesYearTableView.dataSource=self;
    if (IOS7)
    {
        carSeriesYearTableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    [self.view addSubview:carSeriesYearTableView];
 
    
    [ToolLen ShowWaitingView:YES];
    flag=1;
    [[self JsonFactory] get_getCarModelListBySeriesAndYear:seriesid year:year action:@"getCarModelListBySeriesAndYear"];
    
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject!=nil && flag==1 && responseObject)
    {
        
        seriesYearArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"carbrandlist"]];
        
        [carSeriesYearTableView reloadData];
        
    }
    else if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject!=nil && flag==2 && responseObject)
    {
        /*
        //创建健康卡
        CreateHealthyCarViewController *create=[[CreateHealthyCarViewController alloc]init];
        create.blindcarID=[responseObject objectForKey:@"carid"];//绑定车辆的id
        //create.hidesBottomBarWhenPushed=YES;
        create.state=1;
        [self.navigationController pushViewController:create animated:YES];
         */
        
        
        //设置通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCar" object:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@%@",series,carName],[responseObject objectForKey:@"carid"], nil]];
        
        
        //消除层
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }
  
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [seriesYearArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIndefiner=@"cellIndefiner";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiner];
        
       // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
     cell.textLabel.text=[[seriesYearArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //绑定接口
    [ToolLen ShowWaitingView:YES];
    flag=2;
    
    /*
    NSString *carID;
    if ([carDic count]>0)
    {
        carID=[carDic objectForKey:@"carid"];
    }
    else
    {
        carID=@"";
    }
    */
    

    //NSLog(@"carid::%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Save_CarId"]);
    carName=[[seriesYearArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    [[self JsonFactory] setCarType:carName carId:[[NSUserDefaults standardUserDefaults] objectForKey:@"Save_CarId"] brandId:brandID carmodelid:[[seriesYearArray objectAtIndex:indexPath.row] objectForKey:@"id"] series:series action:@"setCarType"];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
