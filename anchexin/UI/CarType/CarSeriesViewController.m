//
//  CarSeriesViewController.m
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "CarSeriesViewController.h"

@interface CarSeriesViewController ()

@end

@implementation CarSeriesViewController
@synthesize brandID;

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
    
    carSeriesTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    carSeriesTableView.delegate=self;
    carSeriesTableView.dataSource=self;
    if (IOS7)
    {
         carSeriesTableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [self.view addSubview:carSeriesTableView];
    
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] get_getCarSeriesListByBrand:brandID action:@"getCarSeriesListByBrand"];
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject!=nil && responseObject)
    {
        seriesArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"carbrandlist"]];
        
        [carSeriesTableView reloadData];
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [seriesArray count];
    
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
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.text=[[seriesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarYearViewController *carYear=[[CarYearViewController alloc] init];
    carYear.title=[NSString stringWithFormat:@"%@",[[seriesArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    carYear.seriesid=[[[seriesArray objectAtIndex:indexPath.row] objectForKey:@"id"] stringValue];
    carYear.brandID=brandID;
    
    [self.navigationController pushViewController:carYear animated:YES];
  
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
