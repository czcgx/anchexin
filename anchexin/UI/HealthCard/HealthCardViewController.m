//
//  HealthCardViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "HealthCardViewController.h"

@interface HealthCardViewController ()

@end

@implementation HealthCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//待办服务
-(void)tabContent_1
{
    [tabContentView_1 removeFromSuperview];
    
    tabContentView_1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height)];
    tabContentView_1.backgroundColor=[UIColor clearColor];
    
    [tabContentView addSubview:tabContentView_1];
    
    healthyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView_1.frame.size.height-50)];
    healthyTableView.tag=1;
    healthyTableView.delegate=self;
    healthyTableView.dataSource=self;
    healthyTableView.backgroundView=nil;
    healthyTableView.backgroundColor=[UIColor clearColor];
    healthyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tabContentView_1 addSubview:healthyTableView];

    
    //预约
    UIView *orderView=[[UIView alloc] initWithFrame:CGRectMake(0,tabContentView_1.frame.size.height-50, WIDTH, 50)];
    orderView.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    [orderView addSubview:[self customLabel:CGRectMake(15, 15, 80, 20) color:[UIColor darkGrayColor] text:@"您选择了" alignment:-1 font:17.0]];
    chooseLabel=[self customLabel:CGRectMake(95, 15, 50, 20) color:[UIColor redColor] text:@"0项" alignment:-1 font:17.0];
    [orderView addSubview:chooseLabel];
    [orderView addSubview:[self customLabel:CGRectMake(135, 15, 50, 20) color:[UIColor darkGrayColor] text:@"服务" alignment:-1 font:17.0]];
    
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(205, 10, 100, 30)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [buttonView addSubview:[self customImageView:CGRectMake(5, 3, 24, 24) image:IMAGE(@"orderhealth")]];
    [buttonView addSubview:[self customLabel:CGRectMake(30,5, 80, 20) color:[UIColor darkGrayColor] text:@"现在预约" alignment:-1 font:16.0]];
    [buttonView addSubview:[self customButton:buttonView.bounds tag:11 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [orderView addSubview:buttonView];

    [tabContentView_1 addSubview:orderView];

}

//保养卡
-(void)tabContent_2
{
    [tabContentView_2 removeFromSuperview];
    tabContentView_2=[[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, tabContentView.frame.size.height)];
    tabContentView_2.backgroundColor=[UIColor clearColor];
    
    maintenanceTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView_2.frame.size.height)];
    maintenanceTableView.tag=2;
    maintenanceTableView.delegate=self;
    maintenanceTableView.dataSource=self;
    maintenanceTableView.backgroundView=nil;
    maintenanceTableView.backgroundColor=[UIColor clearColor];
    maintenanceTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [tabContentView_2 addSubview:maintenanceTableView];
    [tabContentView addSubview:tabContentView_2];
    
}

//维修记录视图
-(void)tabContent_3
{
    //维修记录视图
    [tabContentView_3 removeFromSuperview];
    tabContentView_3=[[UIView alloc] initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH, tabContentView.frame.size.height)];
    tabContentView_3.backgroundColor=[UIColor clearColor];
    
    repairTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height)];
    repairTableView.tag=3;
    repairTableView.delegate=self;
    repairTableView.dataSource=self;
    repairTableView.backgroundView=nil;
    repairTableView.backgroundColor=[UIColor clearColor];
    repairTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tabContentView_3 addSubview:repairTableView];
    
    [tabContentView addSubview:tabContentView_3];

}
/*
-(void)viewWillAppear:(BOOL)animated
{
    if (carArray.count==0)
    {
        NSLog(@"ssssss");
        
        CarTypeViewController *type=[[CarTypeViewController alloc] init];
        [self.navigationController pushViewController:type animated:YES];
    }
    
}
*/

-(void)initCustomUI
{
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    
    UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(15, 50-20, 70, 70)];
    headView.backgroundColor=[UIColor whiteColor];
    headView.layer.cornerRadius = 35;//(值越大，角就越圆)
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth=2.0;
    headView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    [mainView addSubview:headView];
    img=[self customImageView:CGRectMake(25, 60-20, 50, 50) image:nil];
    [img setImageWithURL:[NSURL URLWithString:[[carArray objectAtIndex:0] objectForKey:@"iconimg"]] placeholderImage:nil];
    [mainView addSubview:img];//车的图标
    
    lb1=[self customLabel:CGRectMake(90, 70-20, 200, 20) color:[UIColor whiteColor] text:[NSString stringWithFormat:@"%@  %@",[[carArray objectAtIndex:0] objectForKey:@"carseries"],[[carArray objectAtIndex:0] objectForKey:@"license_number"] ] alignment:-1 font:16];
    lb1.shadowColor=[UIColor blackColor];
    lb1.shadowOffset=CGSizeMake(0, 1.5);
    [mainView addSubview:lb1];
    
    currentKmLabel=[self customLabel:CGRectMake(90, 90-20, 150, 20) color:[UIColor whiteColor] text:[NSString stringWithFormat:@"里程:%@公里",[[carArray objectAtIndex:0] objectForKey:@"current_mileage"] ] alignment:-1 font:14];
    currentKmLabel.shadowColor=[UIColor blackColor];
    currentKmLabel.shadowOffset=CGSizeMake(0, 1.5);
    [mainView addSubview:currentKmLabel];
    [mainView addSubview:[self customImageView:CGRectMake(275, 70-20, 30, 30) image:IMAGE(@"edit")]];
    [mainView addSubview:[self customButton:CGRectMake(270, 70-20-10, 50, 50) tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    //代办服务
    [ToolLen ShowWaitingView:YES];
    requestTimes=1;
    [[self JsonFactory] get_getServiceToDo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getServiceToDo"];//待办服务
    
    
    //tab
    tabView=[[UIView alloc] initWithFrame:CGRectMake(0, 110, WIDTH, 50)];
    tabView.backgroundColor=[UIColor clearColor];
    [tabView addSubview:[self customImageView:tabView.bounds image:IMAGE(@"rootbg")]];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(106, 10, 1, 30)];
    label1.backgroundColor=[UIColor whiteColor];
    [tabView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(107*2, 10, 1, 30)];
    label2.backgroundColor=[UIColor whiteColor];
    [tabView addSubview:label2];
    NSArray *tabArray=[NSArray arrayWithObjects:@"待办服务",@"保养卡",@"维修记录", nil];
    for (int i=0; i<tabArray.count; i++)
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(107*i, 10, 107, 30)];
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
    tabLine=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 107, 10)];
    tabLine.backgroundColor=[UIColor clearColor];
    [tabLine addSubview:[self customImageView:CGRectMake(46, 0, 15, 10) image:IMAGE(@"sanjiao")]];
    [tabView addSubview:tabLine];
    
    [mainView addSubview:tabView];
    
    //tabContent:tab内容
    tabContentView=[[UIView alloc] initWithFrame:CGRectMake(0, 160, WIDTH*3, mainView.frame.size.height-160-48)];
    tabContentView.backgroundColor=[UIColor whiteColor];
    [self tabContent_1];//代办服务
    
    [self tabContent_2];//保养卡视图
    
    [self tabContent_3];//维修记录视图
    
    [mainView addSubview:tabContentView];
    
    
    [self.view addSubview:mainView];

}

-(void)refreshUI
{
    if (carArray.count>0)
    {
        [img setImageWithURL:[NSURL URLWithString:[[carArray objectAtIndex:0] objectForKey:@"iconimg"]] placeholderImage:nil];
        lb1.text=[NSString stringWithFormat:@"%@  %@",[[carArray objectAtIndex:0] objectForKey:@"carseries"],[[carArray objectAtIndex:0] objectForKey:@"license_number"] ];
        currentKmLabel.text=[NSString stringWithFormat:@"里程:%@公里",[[carArray objectAtIndex:0] objectForKey:@"current_mileage"]];
        
        if (requestTimes==1)
        {
            //[ToolLen ShowWaitingView:YES];
            requestTimes=1;
            [[self JsonFactory] get_getServiceToDo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getServiceToDo"];//待办服务
            
        }
        else if (requestTimes==2)
        {
            //[ToolLen ShowWaitingView:YES];
            requestTimes=2;
            [[self JsonFactory] get_getMaintainInfo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getMaintainInfo"];//保养卡信息
        }
        else if (requestTimes==3)
        {
            
            //[ToolLen ShowWaitingView:YES];
            requestTimes=3;
            [[self JsonFactory] get_getRepairOrder:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getRepairOrderList"];//维修记录
        }
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"car::%@",carArray);
    if (carArray.count==0)
    {
        //选择车辆
        CarTypeViewController *type=[[CarTypeViewController alloc] init];
        type.state=0;
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:type];
        [self.navigationController presentViewController:customNav animated:YES completion:^{
            
        }];
    }
    else if ([[[carArray objectAtIndex:0] objectForKey:@"license_number"] length]==0)
    {
        //创建健康卡
        CreateHealthyCarViewController *create=[[CreateHealthyCarViewController alloc] init];
        create.blindcarID=[[carArray objectAtIndex:0] objectForKey:@"carid"];
        create.state=0;
        CustomNavigationController *customNav=[[CustomNavigationController alloc] initWithRootViewController:create];
        [self.navigationController presentViewController:customNav animated:YES completion:^{
            
        }];
    }
    else
    {
        [MobClick event:@"healthyPage"];//统计健康卡页面
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:@"refreshUI" object:nil];
    
    if (carArray.count==0)
    {
        
    }
    else
    {
        [self initCustomUI];//初始化UI
    }
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
       
        todoArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"content"]];
        todoMutableArray=[[NSMutableArray alloc] init];
        for (int i=0; i<[todoArray count]; i++)
        {
            [todoMutableArray addObject:@"0"];
        }
        
        [healthyTableView reloadData];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        mainteArray=[[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"content"]];
        mainteMutableArray=[[NSMutableArray alloc] init];//状态位
        for (int i=0; i<[mainteArray count]; i++)
        {
            if ([[[[[mainteArray objectAtIndex:i] objectForKey:@"items"] objectAtIndex:0] objectForKey:@"checked"]intValue]==2)
            {
                [mainteMutableArray addObject:@"0"];//默认都为展开状态
                
            }
            else
            {
                [mainteMutableArray addObject:@"1"];//默认都为闭合状态
            }
        }
        
        [maintenanceTableView reloadData];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==3)
    {
        
        repairArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"content"]];
        [repairTableView reloadData];//加载数据
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==5)//修改里程
    {
        
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithDictionary:[carArray objectAtIndex:0]];
       // NSLog(@"temp::%@",temp);
       // NSLog(@"currentKm:%@",currentKm);
        
        [temp removeObjectForKey:@"current_mileage"];
        [temp setObject:currentKm forKey:@"current_mileage"];
        
        //NSLog(@"[NSArray arrayWithObject:temp]::%@",[NSArray arrayWithObject:temp]);
        currentKmLabel.text=[NSString stringWithFormat:@"里程:%@公里",currentKm];
        [document saveDataToDocument:@"car" fileData:[NSArray arrayWithObject:temp]];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        //NSLog(@"修改公里数");
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"请输入新的里程数"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
            
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];

        }
    }
    else if (sender.tag==11)
    {
        //NSLog(@"开始预约");
        if ([[userDic objectForKey:@"valid"] intValue]==1)
        {
           NSMutableArray *orderArray=[[NSMutableArray alloc] init];
            for (int i=0; i<[todoMutableArray count]; i++)
            {
                if ([[todoMutableArray objectAtIndex:i] isEqualToString:@"1"])
                {
                    [orderArray addObject:[todoArray objectAtIndex:i]];
                }
            }
           // NSLog(@"orderArray::%@",orderArray);
    
            //服务网点
            ServiceStationViewController *controller=[[ServiceStationViewController alloc] init];
            controller.hidesBottomBarWhenPushed=YES;
            controller.title=@"预约服务网点";
            //controller.lat=lat;
            //controller.lng=lng;
            controller.orderArray=orderArray;
            controller.state=0;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            [self alertNoValid];
        }
        
    }
    else if(sender.tag>99)
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
                tabLine.frame = CGRectMake(0, 40, 107, 10);
                
                tabContentView_1.frame=CGRectMake(0, 0, WIDTH,tabContentView.frame.size.height);
                tabContentView_2.frame=CGRectMake(WIDTH, 0, WIDTH, tabContentView.frame.size.height);
                tabContentView_3.frame=CGRectMake(WIDTH*2, 0, WIDTH, tabContentView.frame.size.height);
                
                break;
            }
            case 101:
            {
                tabLine.frame = CGRectMake(107, 40, 107, 10);
                
                tabContentView_1.frame=CGRectMake(-WIDTH, 0, WIDTH, tabContentView.frame.size.height);
                tabContentView_2.frame=CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height);
                tabContentView_3.frame=CGRectMake(WIDTH, 0, WIDTH, tabContentView.frame.size.height);
                break;
            }
            case 102:
            {
                tabLine.frame = CGRectMake(107*2, 40, 107, 10);
                
                tabContentView_1.frame=CGRectMake(-WIDTH*2, 0, WIDTH, tabContentView.frame.size.height);
                tabContentView_2.frame=CGRectMake(-WIDTH, 0, WIDTH,tabContentView.frame.size.height);
                tabContentView_3.frame=CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height);
                
                break;
            }
                
            default:
                break;
        }
        
        [UIView commitAnimations];

        
        switch (sender.tag)
        {
            case 100:
            {
                [ToolLen ShowWaitingView:YES];
                requestTimes=1;
                [[self JsonFactory] get_getServiceToDo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getServiceToDo"];//待办服务
                
                break;
            }
            case 101:
            {
                [ToolLen ShowWaitingView:YES];
                requestTimes=2;
                [[self JsonFactory] get_getMaintainInfo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getMaintainInfo"];//保养卡信息
                
                break;
            }
            case 102:
            {
                
                [ToolLen ShowWaitingView:YES];
                requestTimes=3;
                [[self JsonFactory] get_getRepairOrder:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] action:@"getRepairOrderList"];//维修记录
                break;
            }
                
            default:
                break;
        }
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //得到输入框
        UITextField *tf=[alertView textFieldAtIndex:0];
       // NSLog(@"tf::%@",tf.text);
        currentKm=tf.text;
        if (tf.text.length>0)
        {
            requestTimes=5;
            [[self JsonFactory]setCarCurrentMileage:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] currentMileage:tf.text action:@"setCarCurrentMileage"];
        }
        else
        {
            [self alertOnly:@"请输入里程数"];
        }
        
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return todoArray.count;
    }
    else if(tableView.tag==2)
    {
        return [mainteArray count];;
    }
    else
    {
        return [repairArray count];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1)
    {
        return 50.0;
    }
    else if(tableView.tag==2)
    {
        
        if ([[mainteMutableArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            return 60.0;
        }
        else
        {
            return [[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"items"] count]*40+60;
        }
        
    }
    else
    {
        return 80.0;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1)
    {
        static NSString *cellIndefiner=@"cellIndefiner1";
        HealthyCell *cell=(HealthyCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"HealthyCell" owner:self options:nil];
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
        
        if ([[todoMutableArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            cell.checkImageView.image=IMAGE(@"unselected");
        }
        else
        {
            cell.checkImageView.image=IMAGE(@"selected");
        }
        
        cell.nameLabel.text=[[todoArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        if ([[[todoArray objectAtIndex:indexPath.row] objectForKey:@"urgency"] intValue]==0)
        {
            cell.stateLabel.text=@"紧急";//紧急
            cell.flagImageView.image=IMAGE(@"orange");
        }
        else
        {
            cell.stateLabel.text=@"普通";//普通
            cell.flagImageView.image=IMAGE(@"yellow");
        }
        
        cell.chooseButton.tag=indexPath.row;
        [cell.chooseButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if(tableView.tag==2)
    {
        NSString *cellIndefiner=@"cellIndefiner2";
        MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@ km/%@个月",[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"mileage"]stringValue],[[[mainteArray objectAtIndex:indexPath.row] objectForKey:@"period"]stringValue]];
        
        cell.maintenanceMonth.text=[NSString stringWithFormat:@"第%d次保养",(int)(indexPath.row+1)];
        
        cell.upButton.tag=indexPath.row+1;
        [cell.upButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
        showLineLabel.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:showLineLabel];
        
        
        if ([[mainteMutableArray objectAtIndex:indexPath.row]isEqualToString:@"0"])
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
     
    
    
     return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (requestTimes==3)
    {
        RepairInfoViewController *info=[[RepairInfoViewController alloc] init];
        info.title=@"维修详情";
        info.hidesBottomBarWhenPushed=YES;
        info.repairRecord=[repairArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:info animated:YES];
    }
    
}

-(void)choose:(UIButton *)sender
{
    
    NSInteger place=[sender tag];   //button 的tag值是cell的哪一行
    NSIndexPath *ip = [NSIndexPath indexPathForRow:place inSection:0];
    //NSLog(@"ttssssss::%d",place);
    
    if ([[todoMutableArray objectAtIndex:place]isEqualToString:@"0"])
    {
        [todoMutableArray removeObjectAtIndex:place];          //如果点击某一行，则把当前行的0删除
        [todoMutableArray insertObject:@"1" atIndex:place];    //在当前行增加1
    }
    else
    {
        [todoMutableArray removeObjectAtIndex:place];         //如果点击某一行，则把当前行的0删除
        [todoMutableArray insertObject:@"0" atIndex:place];   //在当前行增加1
    }
    
    
    int p=0;
    for (int i=0; i<todoMutableArray.count; i++)
    {
        if ([[todoMutableArray objectAtIndex:i] isEqualToString:@"1"])
        {
            p++;
        }
    }
    chooseLabel.text=[NSString stringWithFormat:@"%d项",p];
    
    [healthyTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)touch:(UIButton *)sender
{
    NSInteger place=[sender tag]-1;   //button 的tag值是cell的哪一行
    NSIndexPath *ip = [NSIndexPath indexPathForRow:place inSection:0];
    
    if ([[mainteMutableArray objectAtIndex:place]isEqualToString:@"0"])
    {
        [mainteMutableArray removeObjectAtIndex:place];          //如果点击某一行，则把当前行的0删除
        [mainteMutableArray insertObject:@"1" atIndex:place];    //在当前行增加1
    }
    else
    {
        [mainteMutableArray removeObjectAtIndex:place];         //如果点击某一行，则把当前行的0删除
        [mainteMutableArray insertObject:@"0" atIndex:place];   //在当前行增加1
    }
    
    [maintenanceTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

//更新保养卡
-(void)edit:(UIButton *)sender
{
    int bigIndex=(int)([sender tag]/1000);
    int smallIndex=[sender tag]%1000;
    //NSLog(@"big::%d,small:%d",bigIndex,smallIndex);

    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",bigIndex] forKey:@"AnCheXin_Index"];
    
    //拆分
    NSMutableArray *tempArray=[[NSMutableArray alloc] initWithArray:[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"]];
    NSDictionary *mainDic=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex];
    
    int mileage=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"mileage"] intValue];
    int period=[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"period"] intValue];
    // NSLog(@"mile::%d",mileage);
    
    requestTimes=4;
    //rFlag=1;
    if ([[mainDic objectForKey:@"checked"] intValue]==1)
    {
        NSMutableDictionary *remDic=[[NSMutableDictionary alloc]initWithDictionary:mainDic];
        
        //  NSLog(@"before:%@",remDic);
        
        [remDic removeObjectForKey:@"checked"];
        [remDic setObject:@"0" forKey:@"checked"];
        
        // NSLog(@"after:%@",remDic);
        
        [tempArray removeObjectAtIndex:smallIndex];
        [tempArray insertObject:remDic atIndex:smallIndex];
        
        //NSLog(@"temp::%@",tempArray);
        [mainteArray removeObjectAtIndex:bigIndex];
        [mainteArray insertObject:[NSDictionary dictionaryWithObjectsAndKeys:tempArray,@"items",[NSNumber numberWithInt:mileage],@"mileage",[NSNumber numberWithInt:period],@"period", nil] atIndex:bigIndex];

        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            [[self JsonFactory] get_updateMaintainInfo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] checkItem:[[[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex] objectForKey:@"id"] stringValue] mileage:[NSString stringWithFormat:@"%d",mileage] period:[NSString stringWithFormat:@"%d",period] op:@"0" action:@"updateMaintainInfo"];
        }
        
        
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
        
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            [[self JsonFactory] get_updateMaintainInfo:[[[carArray objectAtIndex:0] objectForKey:@"carid"] stringValue] checkItem:[[[[[mainteArray objectAtIndex:bigIndex] objectForKey:@"items"] objectAtIndex:smallIndex] objectForKey:@"id"] stringValue] mileage:[NSString stringWithFormat:@"%d",mileage] period:[NSString stringWithFormat:@"%d",period] op:@"1" action:@"updateMaintainInfo"];
            
        }
       
        [maintenanceTableView reloadData];
        
    }
    
}


@end
