//
//  MyOrderViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "MyOrderViewController.h"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController
@synthesize state;

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
    if (state==1)
    {
        self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    }
    
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    
    //tab
    tabView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    tabView.backgroundColor=[UIColor clearColor];
    [tabView addSubview:[self customImageView:tabView.bounds image:IMAGE(@"rootbg")]];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(160, 10, 1, 30)];
    label1.backgroundColor=[UIColor whiteColor];
    [tabView addSubview:label1];
    
    NSArray *tabArray=[NSArray arrayWithObjects:@"预约工单",@"工单", nil];
    for (int i=0; i<tabArray.count; i++)
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(160*i, 10, 160, 30)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:16.0];
        label.text=[tabArray objectAtIndex:i];
        label.tag=i+100;
        if (i==0)
        {
            label.textColor=[UIColor yellowColor];
        }
        else
        {
            label.textColor=[UIColor whiteColor];
            
        }
        label.textAlignment=NSTextAlignmentCenter;
        [tabView addSubview:label];
        
        [tabView addSubview:[self customButton:label.frame tag:i+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }
    
    //指示图标
    tabLine=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 160, 10)];
    tabLine.backgroundColor=[UIColor clearColor];
    [tabLine addSubview:[self customImageView:CGRectMake(73, 0, 15, 10) image:IMAGE(@"sanjiao")]];
    [tabView addSubview:tabLine];
    [mainView addSubview:tabView];
    
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, mainView.frame.size.height-50)];
    subView.backgroundColor=kUIColorFromRGB(Commonbg);
   
    orderTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, subView.frame.size.height)];
    orderTableView.delegate=self;
    orderTableView.dataSource=self;
    orderTableView.backgroundView=nil;
    orderTableView.backgroundColor=[UIColor clearColor];
    orderTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [subView addSubview:orderTableView];
    
    [mainView addSubview:subView];
    [self.view addSubview:mainView];

    [ToolLen ShowWaitingView:YES];
    requestTimes=0;
    [[self JsonFactory] getRequestList:nil statusList:@"-2,-1,0,1,2,3" token:nil action:@"getRequestList"];
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==0)
    {
        repairArray=nil;
        orderList=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"requestList"]];
        
        [orderTableView reloadData];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        orderList=nil;
        repairArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"content"]];
        
        [orderTableView reloadData];//加载数据
        
    }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
    
    
    
}
-(void)customEvent:(UIButton *)sender
{

    if(sender.tag>99)
    {
       // NSLog(@"代办服务");
        for (UIView *subView in[tabView subviews])
        {
            if ([subView isKindOfClass:[UILabel class]])
            {
                UILabel *selectLabel = (UILabel *)[subView viewWithTag:subView.tag];
                if (subView.tag==sender.tag)
                {
                    selectLabel.textColor=[UIColor yellowColor];
                }
                else
                {
                    selectLabel.textColor=[UIColor whiteColor];
                }
            }
        }
        
        [UIView beginAnimations:nil context:nil];//动画开始
        [UIView setAnimationDuration:0.3];
        
        switch (sender.tag)
        {
            case 100:
            {
                tabLine.frame = CGRectMake(0, 40, 160, 10);
                
                [ToolLen ShowWaitingView:YES];
                requestTimes=0;
                [[self JsonFactory] getRequestList:nil statusList:@"-2,-1,0,1,2,3" token:nil action:@"getRequestList"];
                
                break;
            }
            case 101:
            {
                tabLine.frame = CGRectMake(160, 40, 160, 10);
                
                [ToolLen ShowWaitingView:YES];
                requestTimes=1;
                [[self JsonFactory] get_getRepairOrder:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getRepairOrderList"];//维修记录
               
                break;
            }
        
                
            default:
                break;
        }
        
        [UIView commitAnimations];
        
        
        
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (requestTimes==0)
    {
        return [orderList count];
    }
    else
    {
        return [repairArray count];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (requestTimes==0)
    {
        static NSString *cellIndefiner=@"cellIndefiner";
        
        OrderCell *cell=(OrderCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        if (indexPath.row % 2)
        {
            cell.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
        }
        
        if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==1)
        {
            //已受理
            cell.iconImageView.image=IMAGE(@"order_1");
        }
        else if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==-2)
        {
            //已过期(包括待受理超时和已受理超时)
            cell.iconImageView.image=IMAGE(@"order_5");
        }
        else if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==-1)
        {
            //撤销请求(客户取消待受理)
            cell.iconImageView.image=IMAGE(@"order_2");
        }
        else if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==0)
        {
            //待受理
            cell.iconImageView.image=IMAGE(@"order_0");
        }
        else if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==2)
        {
            //拒绝受理(维修点拒绝受理)
            cell.iconImageView.image=IMAGE(@"order_5");
        }
        else if ([[[orderList objectAtIndex:indexPath.row] objectForKey:@"status"] intValue]==3)
        {
            //已经消费
            cell.iconImageView.image=IMAGE(@"order_3");
        }
        
        
        
        cell.shopNameLabel.text=[[orderList objectAtIndex:indexPath.row] objectForKey:@"stationName"];
        cell.timeLabel.text=[[orderList objectAtIndex:indexPath.row] objectForKey:@"startTime"];
        
        return cell;

    }
    else
    {
        
        static NSString *cellIndefiner=@"cellIndefiner3";
        RepairRecordCell *cell=(RepairRecordCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"RepairRecordCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        if (indexPath.row % 2)
        {
            cell.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
        }
        
        
        cell.stationName.text=[[repairArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.stationItem.text=[[repairArray objectAtIndex:indexPath.row] objectForKey:@"service"];
        cell.stationTime.text=[[repairArray objectAtIndex:indexPath.row] objectForKey:@"date"];
        cell.stationPrice.text=[NSString stringWithFormat:@"¥%@",[[[repairArray objectAtIndex:indexPath.row] objectForKey:@"amount"] stringValue]];
        
        
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (requestTimes==0)
    {
        OrderInfoViewController *info=[[OrderInfoViewController alloc] init];
        info.stationInfo=[orderList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:info animated:YES];
    }
    else
    {
        RepairInfoViewController *info=[[RepairInfoViewController alloc] init];
        info.title=@"维修详情";
        info.hidesBottomBarWhenPushed=YES;
        info.repairRecord=[repairArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:info animated:YES];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
