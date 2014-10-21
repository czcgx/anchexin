//
//  CarYearViewController.m
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "CarYearViewController.h"

@interface CarYearViewController ()

@end

@implementation CarYearViewController
@synthesize seriesid;
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
    
    carYearTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    carYearTableView.delegate=self;
    carYearTableView.dataSource=self;
    if (IOS7)
    {
        carYearTableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    [self.view addSubview:carYearTableView];

    
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] get_getYearListBySeries:seriesid action:@"getYearListBySeries"];
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject!=nil && responseObject)
    {
        yearArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"yearlist"]];
        
        [carYearTableView reloadData];
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [yearArray count];
    
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
    
    cell.textLabel.text=[[yearArray objectAtIndex:indexPath.row] objectForKey:@"year"];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarSeriesAndYearViewController *seriesYear=[[CarSeriesAndYearViewController alloc] init];
    
    seriesYear.title=[NSString stringWithFormat:@"%@的%@的系列",[[yearArray objectAtIndex:indexPath.row] objectForKey:@"year"],self.title];
    /*
    if (seriesYear.title.length>9)
    {
         seriesYear.title=[NSString stringWithFormat:@"%@...",[[seriesYear.title substringFromIndex:0] substringToIndex:9]];
    }
     */
    
    seriesYear.seriesid=seriesid;
    seriesYear.year=[[yearArray objectAtIndex:indexPath.row] objectForKey:@"year"];
    seriesYear.brandID=brandID;
    seriesYear.series=self.title;
    
    [self.navigationController pushViewController:seriesYear animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
