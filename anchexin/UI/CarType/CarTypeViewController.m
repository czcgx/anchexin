//
//  CarTypeViewController.m
//  AnCheXin
//
//  Created by cgx on 13-11-9.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CarTypeViewController.h"

@interface CarTypeViewController ()

@end

@implementation CarTypeViewController
@synthesize state;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)popself
{
    UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
    [tabBarController setSelectedIndex:2];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self skinOfBackground];
    self.title=@"车型选择";
   // self.view.backgroundColor=kUIColorFromRGB(0x1c1c1c);
   
    if (state==0)
    {
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.backBarButtonItem=nil;
        self.navigationItem.leftBarButtonItem=nil;
        
        UIImage *image=IMAGE(@"thebackbuttonbg");//返回按钮的背景
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 10, 20, 20);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem=backItem;

    }
    
    dataSource=[[NSMutableArray alloc]init];
    sections=[[NSMutableArray alloc]init];
    rows=[[NSMutableArray alloc]init];
    
    carTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
   
    carTableView.sectionIndexColor=[UIColor whiteColor];
    carTableView.sectionIndexBackgroundColor=[UIColor clearColor];
    carTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    
    carTableView.backgroundColor=[UIColor clearColor];
    carTableView.backgroundView=nil;
    carTableView.backgroundView.backgroundColor=[UIColor clearColor];
    carTableView.delegate=self;
    carTableView.dataSource=self;
    carTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    carTableView.scrollsToTop=NO;
    [self.view addSubview:carTableView];
    
    //NSLog(@"[AppDelegate setGlobal].token:%@",[AppDelegate setGlobal].token);
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] get_getCarBrandList:@"getCarBrandList"];//请求车辆列表
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject!=nil && responseObject)
    {
        array=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"carbrandlist"] ];
        
        NSString *temp=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[array objectAtIndex:0] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
        
        [sections addObject:temp];
        [dataSource addObject:temp];
        
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        for (int i=0; i<[array count]; i++)
        {
            NSString *temp_=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[array objectAtIndex:i] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
            
            if ([temp isEqualToString:temp_])
            {
                [tempArray addObject:[[array objectAtIndex:i] objectForKey:@"name"]];
            }
            else
            {
                [rows addObject:tempArray];
                
                tempArray=[[NSMutableArray alloc] init];
                [tempArray addObject:[[array objectAtIndex:i] objectForKey:@"name"]];
                temp=temp_;
                [sections addObject:temp];
                [dataSource addObject:temp];
                
            }
            if (i==[array count]-1)
            {
                [rows addObject:tempArray];
            }
        }
        
        [carTableView reloadData];
        
    }

}


//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return dataSource;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
        NSInteger count = 0;
       // NSLog(@"%@-%d",title,index);
   
        for(NSString *character in dataSource)
        {
            if([character isEqualToString:title])
            {
                return count;
            }
            count ++;
        }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [rows[section] count];

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    bgView.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    
    UILabel *upLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    upLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:upLabel];
    
    UILabel *sectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 30, 20)];
    sectionLabel.backgroundColor=[UIColor clearColor];
    sectionLabel.textAlignment=NSTextAlignmentLeft;
    sectionLabel.textColor=[UIColor whiteColor];
    sectionLabel.font=[UIFont boldSystemFontOfSize:19.0];
    sectionLabel.text=sections[section];
    [bgView addSubview:sectionLabel];
    
    UILabel *downLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29.5, WIDTH, 0.5)];
    downLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:downLabel];
    
    return bgView;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sections[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    CarTypeCell *cell=(CarTypeCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CarTypeCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UILabel *labelbg=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
    labelbg.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [cell.contentView addSubview:labelbg];
    
    for (int i=0; i<[array count]; i++)
    {
        if ([[[array objectAtIndex:i] objectForKey:@"name"] isEqualToString:rows[indexPath.section][indexPath.row]])
        {
            [cell.imageViewIcon setImageWithURL:[NSURL URLWithString:[[array objectAtIndex:i] objectForKey:@"img"]] placeholderImage:nil];
            
            break;
        }
    }
    
    
    cell.carTypeName.text=rows[indexPath.section][indexPath.row];
   
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSString *brandID=nil;
    for (int i=0; i<[array count]; i++)
    {
        if ([[[array objectAtIndex:i] objectForKey:@"name"] isEqualToString:rows[indexPath.section][indexPath.row]])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[[array objectAtIndex:i] objectForKey:@"img"] forKey:@"AnCheXin_CarImage"];
            
            brandID=[[[array objectAtIndex:i] objectForKey:@"id"] stringValue];
            break;
        }
    }
    
    CarSeriesViewController *carSeries=[[CarSeriesViewController alloc]init];
    carSeries.hidesBottomBarWhenPushed=YES;
    carSeries.title=[NSString stringWithFormat:@"%@系列",rows[indexPath.section][indexPath.row]];
    
    carSeries.brandID=brandID;
    [self.navigationController pushViewController:carSeries animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
