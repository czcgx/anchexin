//
//  ChangeStateServiceViewController.m
//  AnCheXin
//
//  Created by cgx on 14-2-26.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "ChangeStateServiceViewController.h"

@interface ChangeStateServiceViewController ()

@end

@implementation ChangeStateServiceViewController
@synthesize carid;

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
    
    self.title=@"保养卡信息";
 
    //按钮的提交
    UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(barUpload) ];
    bar.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=bar;
 
    maintenanceTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    maintenanceTableView.tag=2;
    maintenanceTableView.delegate=self;
    maintenanceTableView.dataSource=self;
    maintenanceTableView.backgroundView=nil;
    maintenanceTableView.backgroundColor=[UIColor clearColor];
    maintenanceTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:maintenanceTableView];
  
    
    [ToolLen ShowWaitingView:YES];
    flag=1;//获取保养项目
    [[self JsonFactory] get_getMaintainInfo:carid action:@"getMaintainInfo"];//保养卡信息
    
}


-(void)barUpload
{
    /*
    //进入首页
    RootViewController *root=[[RootViewController alloc]init];
    root.navigationItem.hidesBackButton=YES;
    
    [self.navigationController pushViewController:root animated:YES];
    [root release];
    
    //[self.navigationController popViewControllerAnimated:YES];
     */
    
    //进入首页
    UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
    [AppDelegate setGlobal].rootController = [[DDMenuController alloc] initWithRootViewController:tabBarController];
    
    [AppDelegate setGlobal].rootController.view.frame=CGRectMake(WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
    
    MoreViewController *more=[[MoreViewController alloc] init];
    [AppDelegate setGlobal].rootController.leftViewController = more;
    
    CityViewController *city=[[CityViewController alloc] init];
    [AppDelegate setGlobal].rootController.rightViewController=city;
    
    
     [[UIApplication sharedApplication].keyWindow addSubview:[AppDelegate setGlobal].rootController.view];
     
     [UIView animateWithDuration:1.0 animations:^{
     self.view.frame=CGRectMake(-WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
     [AppDelegate setGlobal].rootController.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
     }];

}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && flag==1)
    {
        mainteArray=[[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"content"]];
        
        flagArray=[[NSMutableArray alloc] init];
        for (int i=0; i<[mainteArray count]; i++)
        {
            if ([[[[[mainteArray objectAtIndex:i] objectForKey:@"items"] objectAtIndex:0] objectForKey:@"checked"]intValue]==2)
            {
                [flagArray addObject:@"0"];//默认都为展开状态
                
            }
            else
            {
                [flagArray addObject:@"1"];//默认都为闭合状态
            }
        }
        
        [maintenanceTableView reloadData];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [mainteArray count];
 
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[flagArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        return 60.0;
    }
    else
    {
        return [[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] count]*40+60;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIndefiner=@"cellIndefiner2";
    MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.upButton.tag=indexPath.row+1;
    [cell.upButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
    showLineLabel.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:showLineLabel];
    
    if ([[flagArray objectAtIndex:indexPath.row]isEqualToString:@"0"])
    {
        cell.downView.hidden=YES;
        cell.upImageView.image=IMAGE(@"pulldown");
        showLineLabel.hidden=NO;
    }
    else
    {
        cell.downView.hidden=NO;
        cell.upImageView.image=IMAGE(@"pullup");
        showLineLabel.hidden=YES;
        
        cell.downView.frame=CGRectMake(0, 60,WIDTH, [[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] count]*40);
        
        for (int i=0; i<[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] count]; i++)
        {
            UILabel *keyLabel=[[UILabel alloc] initWithFrame:CGRectMake(22, 10+40*i, 130,20)];
            keyLabel.backgroundColor=[UIColor clearColor];
            keyLabel.font=[UIFont systemFontOfSize:13.0];
            keyLabel.textColor=[UIColor darkGrayColor];
            keyLabel.textAlignment=NSTextAlignmentLeft;
            keyLabel.text=[[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] objectAtIndex:i] objectForKey:@"name"];
            [cell.downView addSubview:keyLabel];
            
            
            //判断是什么状态
            UIImageView *flagimg=[[UIImageView alloc] initWithFrame:CGRectMake(230, 8.5+40*i, 60, 23)];
             if ([[[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] objectAtIndex:i] objectForKey:@"checked"]intValue]==1)
             {
                 flagimg.image=IMAGE(@"finish");
             }
             else
             {
                 flagimg.image=IMAGE(@"unfinish");
             }
            
             [cell.downView addSubview:flagimg];
            
            UIButton *editButton=[UIButton buttonWithType:UIButtonTypeCustom];
            editButton.frame=CGRectMake(200, 40*i, 100, 40);
            editButton.tag=indexPath.row *1000+i;
            [editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
            [cell.downView addSubview:editButton];
            
            UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 40+40*i, WIDTH-40, 0.5)];
            lineLabel.backgroundColor=[UIColor lightGrayColor];
            [cell.downView addSubview:lineLabel];
            
        }
    }
    
     cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@ km/%@个月",[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"mileage"]stringValue],[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"period"]stringValue]];
     cell.maintenanceMonth.text=[NSString stringWithFormat:@"第%d次保养",(int)(indexPath.row+1)];
    
    
    return cell;

}

//点击
-(void)touch:(UIButton *)sender
{
    
    NSInteger place=[sender tag]-1;   //button 的tag值是cell的哪一行
    NSIndexPath *ip = [NSIndexPath indexPathForRow:place inSection:0];
    //NSLog(@"ttssssss::%d",place);
    
    if ([[flagArray objectAtIndex:place]isEqualToString:@"0"])
    {
        [flagArray removeObjectAtIndex:place];          //如果点击某一行，则把当前行的0删除
        [flagArray insertObject:@"1" atIndex:place];    //在当前行增加1
    }
    else
    {
        [flagArray removeObjectAtIndex:place];         //如果点击某一行，则把当前行的0删除
        [flagArray insertObject:@"0" atIndex:place];   //在当前行增加1
    }
    
    [maintenanceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

//更新保养卡
-(void)edit:(UIButton *)sender
{
    //NSLog(@"edit::%d",[sender tag]);
    
    //[[[[mainteArray objectAtIndex:[sender tag]] objectForKey:@"items"] objectAtIndex:i] objectForKey:@"name"];
    
    int bigIndex=(int)([sender tag]/1000);
    int smallIndex=(int)([sender tag]%1000);
    //NSLog(@"big::%d,small:%d",bigIndex,smallIndex);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",bigIndex] forKey:@"AnCheXin_Index"];
    
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"]];
    
    NSDictionary *mainDic=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex];
    
    int mileage=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"mileage"] intValue];
    int period=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"period"] intValue];
    //NSLog(@"mile::%d",mileage);
    
    
    if ([[mainDic objectForKey:@"checked"] intValue]==1)
    {
        NSMutableDictionary *remDic=[[NSMutableDictionary alloc]initWithDictionary:mainDic];
        
        //NSLog(@"before:%@",remDic);
        [remDic removeObjectForKey:@"checked"];
        [remDic setObject:@"0" forKey:@"checked"];
        
        // NSLog(@"after:%@",remDic);
        [tempArray removeObjectAtIndex:smallIndex];
        [tempArray insertObject:remDic atIndex:smallIndex];
        
        //NSLog(@"temp::%@",tempArray);
        [mainteArray removeObjectAtIndex:bigIndex];
        [mainteArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:tempArray,@"items",[NSNumber numberWithInt:mileage],@"mileage",[NSNumber numberWithInt:period],@"period", nil] atIndex:bigIndex];
        

        
        flag=2;//更改状态
        [[self JsonFactory] get_updateMaintainInfo:carid checkItem:[[[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex] objectForKey:@"id"] stringValue] mileage:[NSString stringWithFormat:@"%d",mileage] period:[NSString stringWithFormat:@"%d",period] op:@"0" action:@"updateMaintainInfo"];
        
        [maintenanceTableView reloadData];
        
    }
    else if([[mainDic objectForKey:@"checked"] intValue]==0)
    {
        
        NSMutableDictionary *remDic=[[NSMutableDictionary alloc]initWithDictionary:mainDic];
        // NSLog(@"before:%@",remDic);
        
        [remDic removeObjectForKey:@"checked"];
        [remDic setObject:@"1" forKey:@"checked"];
        // NSLog(@"after:%@",remDic);
        [tempArray removeObjectAtIndex:smallIndex];
        [tempArray insertObject:remDic atIndex:smallIndex];
        
        // NSLog(@"temp::%@",tempArray);
        [mainteArray removeObjectAtIndex:bigIndex];
        [mainteArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:tempArray,@"items",[NSNumber numberWithInt:mileage],@"mileage",[NSNumber numberWithInt:period],@"period", nil] atIndex:bigIndex];
        
       
        
        // NSLog(@"main::%@",mainteArray);
        /*
         NSLog(@"1::%@",[[[AppDelegate setGlobal].carDic objectForKey:@"carid"] stringValue]);
         NSLog(@"2::%@",[[[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex] objectForKey:@"id"] stringValue]);
         NSLog(@"3::%@",[NSString stringWithFormat:@"%d",mileage]);
         NSLog(@"4::%@",[NSString stringWithFormat:@"%d",period]);
         */
        
        flag=2;//更改状态
       [[self JsonFactory] get_updateMaintainInfo:carid checkItem:[[[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex] objectForKey:@"id"] stringValue] mileage:[NSString stringWithFormat:@"%d",mileage] period:[NSString stringWithFormat:@"%d",period] op:@"1" action:@"updateMaintainInfo"];
        
        [maintenanceTableView reloadData];
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
