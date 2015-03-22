//
//  CarInfoViewController.m
//  anchexin
//
//  Created by cgx on 14-12-23.
//
//

#import "CarInfoViewController.h"

@interface CarInfoViewController ()

@end

@implementation CarInfoViewController
@synthesize flag;
@synthesize carInfo;

-(void)refreshCar:(NSNotification *)notification
{
    //NSLog(@"notificationnotification::%@",notification);
    
    [carInfoContentArray removeObjectAtIndex:0];
    [carInfoContentArray insertObject:[notification.object objectAtIndex:0] atIndex:0];
    
    carId=[notification.object objectAtIndex:1];
    
    [carTableView reloadData];//刷新
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCar:) name:@"refreshCar" object:nil];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    //横线
    [mainView addSubview:[self drawLine:CGRectMake(0, 20, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    carInfoArray=[[NSArray alloc] initWithObjects:@"具体车型",@"车牌号码",@"行驶里程",@"上路时间", nil];
    
    carInfoContentArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    //carDic=[document readDataFromDocument:@"car" IsArray:NO];
    if (carInfo && flag)
    {
        [carInfoContentArray addObject:[NSString stringWithFormat:@"%@%@",[carInfo objectForKey:@"carbrand"],[carInfo objectForKey:@"carname"]]];

        carId=[carInfo objectForKey:@"carid"];
        
    }
    else
    {
        [carInfoContentArray addObject:@""];
        carId=@"";
    }
    
    //保存carId
    [[NSUserDefaults standardUserDefaults] setObject:carId forKey:@"Save_CarId"];
    //NSLog(@"carInfoContentArray::%@",carInfoContentArray);
    
    for (int i=0; i<carInfoArray.count-1; i++)
    {
        [carInfoContentArray addObject:@""];
    }
    
    
    carTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 21, WIDTH, 200)];
    carTableView.delegate=self;
    carTableView.dataSource=self;
    carTableView.backgroundView=nil;
    carTableView.backgroundColor=[UIColor clearColor];
    carTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    carTableView.scrollEnabled=NO;
    [mainView addSubview:carTableView];
    
    [mainView addSubview:[self drawLine:CGRectMake(0, 220, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];

    [mainView addSubview:[self customView:CGRectMake(60, 250, 200, 40) labelTitle:@"确认提交" buttonTag:1]];
    
    [self.view addSubview:mainView];

}

-(void)customEvent:(UIButton *)sender
{
    //NSLog(@"carInfoContentArray::%@",carInfoContentArray);
    
    if (sender.tag==1)
    {
        if ([[carInfoContentArray objectAtIndex:0] length]==0)
        {
            [self alertOnly:@"请选择具体车型"];
        }
        else if ([[carInfoContentArray objectAtIndex:1] length]!=7)
        {
            [self alertOnly:@"请重新选择车牌号码"];
        }
        else if ([[carInfoContentArray objectAtIndex:2] length]==0)
        {
            [self alertOnly:@"请输入里程数"];
        }
        else if ([[carInfoContentArray objectAtIndex:3] length]==0)
        {
            [self alertOnly:@"请选择上路时间"];
        }
        else
        {
            //提交
            [ToolLen ShowWaitingView:YES];
            
            [[self JsonFactory] set_addHealthCard:carId currentMileage:[carInfoContentArray objectAtIndex:2] buyTime:[carInfoContentArray objectAtIndex:3] lastMaintainTime:@"" lastCurrentMileage:@"" checkItemList:@"" licenseNumber:[carInfoContentArray objectAtIndex:1]action:@"addHealthCard"];
            
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [carInfoArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    AccountCell *cell=(AccountCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"AccountCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.nameLabel.text=[carInfoArray objectAtIndex:indexPath.row];
    
    UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 49.5, WIDTH-30, 0.5)];
    showLineLabel.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [cell.contentView addSubview:showLineLabel];
    
    if (indexPath.row==0)
    {
        cell.iconImageView.hidden=NO;
        cell.iconImageView.image=IMAGE(@"station_arrow");
        //cell.iconImageView.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    else
    {
        cell.iconImageView.hidden=YES;
    }

    cell.iconImageView.hidden=YES;
    //cell.valueLabel.frame=CGRectMake(115, 14, 180, 21);
    cell.valueLabel.text=[carInfoContentArray objectAtIndex:indexPath.row];//显示具体内容
    
    /*
    if (indexPath.row==0)
    {
        cell.valueLabel.text=[userDic objectForKey:@"mail"];
    }
    else if (indexPath.row==1)
    {
        cell.valueLabel.text=[userDic objectForKey:@"mobile"];
    }
    else if (indexPath.row==2)
    {
        cell.valueLabel.text=[userDic objectForKey:@"username"];
    }
    else
    {
        cell.valueLabel.text=@"";
    }
    
     
    if (indexPath.row==3)
    {
        showLineLabel.hidden=YES;
    }
    else
    {
        showLineLabel.hidden=NO;
    }
     */
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            //选择车辆
            CarTypeViewController *type=[[CarTypeViewController alloc] init];
            type.state=0;
            CustomNavigationController *navType=[[CustomNavigationController alloc] initWithRootViewController:type];
            
            [self presentViewController:navType animated:YES completion:^{
                
            }];
            
            break;
        }
        case 1:
        {
            //选择车牌省份简称
            carNumArray=[[NSArray alloc]initWithObjects:@"京",@"沪",@"苏",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"黔",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台",nil];
            
            [self initSelectionPanel:carNumArray column:9 isElse:0 event:@selector(choose:)];
            
            break;
            
        }
        case 2:
        {
            carNumArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
            
            [self initSelectionPanel:carNumArray column:7 isElse:2 event:@selector(chooseMeters:)];
            
            break;
        }
        case 3:
        {
            NSDate *senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY"];
            
            NSString *locationString=[dateformatter stringFromDate:senddate];
            
           // NSLog(@"locationString:%@",locationString);
            
            NSMutableArray *carYear=[[NSMutableArray alloc] initWithCapacity:0];
            
            for (int i=0; i<20; i++)
            {
                [carYear addObject:[NSString stringWithFormat:@"%d",[locationString intValue]-i]];
                
            }
            carNumArray=[[NSArray alloc] initWithArray:carYear];
            [self initSelectionPanel:carNumArray column:7 isElse:0 event:@selector(chooseYear:)];
            
            break;
        }
            
        default:
            break;
    }
}


//初始化选择面板
-(void)initSelectionPanel:(NSArray *)tempArray column:(int)column isElse:(int)isElse event:(SEL)event
{
    //列数量
    int columns=column;
    //行数量
    int rows=0;
    if (tempArray.count%columns)
    {
        rows=(int)(tempArray.count/columns)+1;
    }
    else
    {
        rows=(int)(tempArray.count/columns);
    }
    
    float heigh=1.5;
    [orderView removeFromSuperview];
    orderView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, heigh*rows*(self.view.frame.size.width/columns))];
    orderView.backgroundColor=[UIColor clearColor];
    
    for (int i=0; i<rows; i++)
    {
        for (int j=0; j<columns; j++)
        {
            if (columns*i+j<tempArray.count)
            {
                UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/columns *j,self.view.frame.size.width/columns * i*heigh, self.view.frame.size.width/columns, self.view.frame.size.width/columns*heigh)];
                
                subView.backgroundColor=[UIColor whiteColor];
                
                //｜
                UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/columns-0.5, 0, 0.5, self.view.frame.size.width/columns*heigh)];
                line1.backgroundColor=[UIColor lightGrayColor];
                [subView addSubview:line1];
                
                //—
                UILabel *line_=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/columns*heigh-0.5, self.view.frame.size.width/columns, 0.5)];
                line_.backgroundColor=[UIColor lightGrayColor];
                [subView addSubview:line_];
                
                //
                UILabel *subLbl=[[UILabel alloc] initWithFrame:subView.bounds];
                subLbl.backgroundColor=[UIColor clearColor];
                subLbl.textAlignment=NSTextAlignmentCenter;
                subLbl.textColor=[UIColor blackColor];
                subLbl.text=[tempArray objectAtIndex:columns*i+j];
                subLbl.font=[UIFont systemFontOfSize:14.0];
                [subView addSubview:subLbl];
                
                //按钮
                UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                subBtn.frame=subView.bounds;
                subBtn.tag=columns*i+j;
                [subBtn addTarget:self action:event forControlEvents:UIControlEventTouchUpInside];
                [subView addSubview:subBtn];
                
                [orderView addSubview:subView];
                
            }
            else
            {
                if (isElse==1)
                {
                    if (i==3 && j==4)
                    {
                        UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/columns *j,self.view.frame.size.width/columns * i*heigh, self.view.frame.size.width/columns*2, self.view.frame.size.width/columns*heigh)];
                        
                        subView.backgroundColor=[UIColor whiteColor];
                        
                        //｜
                        UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(subView.frame.size.width-0.5, 0, 0.5, subView.frame.size.height)];
                        line1.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line1];
                        
                        //—
                        UILabel *line_=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/columns*heigh-0.5, self.view.frame.size.width/columns*2, 0.5)];
                        line_.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line_];
                        
                        //
                        UILabel *subLbl=[[UILabel alloc] initWithFrame:subView.bounds];
                        subLbl.backgroundColor=[UIColor clearColor];
                        subLbl.textAlignment=NSTextAlignmentCenter;
                        subLbl.textColor=[UIColor blackColor];
                        subLbl.text=@"删除";
                        subLbl.font=[UIFont systemFontOfSize:14.0];
                        [subView addSubview:subLbl];
                        
                        //按钮
                        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                        subBtn.frame=subView.bounds;
                        subBtn.tag=columns*i+j;
                        [subBtn addTarget:self action:@selector(del) forControlEvents:UIControlEventTouchUpInside];
                        [subView addSubview:subBtn];
                        
                        [orderView addSubview:subView];
                    }
                    else
                    {
                        UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/columns *4,self.view.frame.size.width/columns * i*heigh, self.view.frame.size.width/columns*4, self.view.frame.size.width/columns*heigh)];
                        
                        subView.backgroundColor=[UIColor whiteColor];
                        
                        //｜
                        UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(subView.frame.size.width-0.5, 0, 0.5, subView.frame.size.width)];
                        line1.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line1];
                        
                        //—
                        UILabel *line_=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/columns*heigh-0.5, self.view.frame.size.width/columns*4, 0.5)];
                        line_.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line_];
                        
                        //
                        UILabel *subLbl=[[UILabel alloc] initWithFrame:subView.bounds];
                        subLbl.backgroundColor=[UIColor clearColor];
                        subLbl.textAlignment=NSTextAlignmentCenter;
                        subLbl.textColor=[UIColor blackColor];
                        subLbl.text=@"确定";
                        subLbl.font=[UIFont systemFontOfSize:14.0];
                        [subView addSubview:subLbl];
                        
                        //按钮
                        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                        subBtn.frame=subView.bounds;
                        //subBtn.tag=columns*i+j;
                        [subBtn addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
                        [subView addSubview:subBtn];
                        
                        [orderView addSubview:subView];
                        
                    }
                }
                else if(isElse==2)//
                {
                    if (i==1 && j==3)
                    {
                        UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/columns *j,self.view.frame.size.width/columns * i*heigh, self.view.frame.size.width/columns*2, self.view.frame.size.width/columns*heigh)];
                        
                        subView.backgroundColor=[UIColor whiteColor];
                        
                        //｜
                        UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(subView.frame.size.width-0.5, 0, 0.5, subView.frame.size.height)];
                        line1.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line1];
                        
                        //—
                        UILabel *line_=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/columns*heigh-0.5, self.view.frame.size.width/columns*2, 0.5)];
                        line_.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line_];
                        
                        //
                        UILabel *subLbl=[[UILabel alloc] initWithFrame:subView.bounds];
                        subLbl.backgroundColor=[UIColor clearColor];
                        subLbl.textAlignment=NSTextAlignmentCenter;
                        subLbl.textColor=[UIColor blackColor];
                        subLbl.text=@"删除";
                        subLbl.font=[UIFont systemFontOfSize:14.0];
                        [subView addSubview:subLbl];
                        
                        //按钮
                        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                        subBtn.frame=subView.bounds;
                        //subBtn.tag=columns*i+j;
                        [subBtn addTarget:self action:@selector(delMeters) forControlEvents:UIControlEventTouchUpInside];
                        [subView addSubview:subBtn];
                        
                        [orderView addSubview:subView];
                    }
                    else
                    {
                        UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-self.view.frame.size.width/columns *2,self.view.frame.size.width/columns * i*heigh, self.view.frame.size.width/columns*2, self.view.frame.size.width/columns*heigh)];
                        
                        subView.backgroundColor=[UIColor whiteColor];
                        
                        //｜
                        UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(subView.frame.size.width-0.5, 0, 0.5, subView.frame.size.width)];
                        line1.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line1];
                        
                        //—
                        UILabel *line_=[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/columns*heigh-0.5, self.view.frame.size.width/columns*4, 0.5)];
                        line_.backgroundColor=[UIColor lightGrayColor];
                        [subView addSubview:line_];
                        
                        //
                        UILabel *subLbl=[[UILabel alloc] initWithFrame:subView.bounds];
                        subLbl.backgroundColor=[UIColor clearColor];
                        subLbl.textAlignment=NSTextAlignmentCenter;
                        subLbl.textColor=[UIColor blackColor];
                        subLbl.text=@"确定";
                        subLbl.font=[UIFont systemFontOfSize:14.0];
                        [subView addSubview:subLbl];
                        
                        //按钮
                        UIButton *subBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                        subBtn.frame=subView.bounds;
                        //subBtn.tag=columns*i+j;
                        [subBtn addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
                        [subView addSubview:subBtn];
                        
                        [orderView addSubview:subView];
                    }
                    
                }
            }
           
        }
    }
    
    
    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [orderView addSubview:line];
    
    [self.view addSubview:orderView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        orderView.frame=CGRectMake(0, self.view.frame.size.height-heigh*rows*(self.view.frame.size.width/columns), self.view.frame.size.width, heigh*rows*(self.view.frame.size.width/columns));
        
    }];

    
}

//选择车牌省份简称
-(void)choose:(UIButton *)sender
{

    [carInfoContentArray removeObjectAtIndex:1];
    [carInfoContentArray insertObject:[carNumArray objectAtIndex:sender.tag] atIndex:1];
    [carTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        orderView.frame=CGRectMake(0, self.view.frame.size.height, 0, 0);
        
    }];
    
    
    //选择车牌号
    carNumArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"L",nil];
    
    [self initSelectionPanel:carNumArray column:10 isElse:1 event:@selector(chooseNum:)];
    
}

//选择数字
-(void)chooseNum:(UIButton *)sender
{
    
   // NSLog(@"choose::%@",[carNumArray objectAtIndex:sender.tag]);
    
    NSMutableString *appendStr=[[NSMutableString alloc] initWithCapacity:0];
    [appendStr appendFormat:@"%@%@",[carInfoContentArray objectAtIndex:1], [carNumArray objectAtIndex:sender.tag]];
    
    [carInfoContentArray removeObjectAtIndex:1];
    [carInfoContentArray insertObject:appendStr atIndex:1];
    [carTableView reloadData];

}

//删除按钮
-(void)del
{
    NSMutableString *appendStr=[[NSMutableString alloc]initWithFormat:@"%@", [carInfoContentArray objectAtIndex:1]];
    
    [carInfoContentArray removeObjectAtIndex:1];
    [carInfoContentArray insertObject:[[appendStr substringFromIndex:0] substringToIndex:appendStr.length-1] atIndex:1];
    
    
    [carTableView reloadData];
    
}

//确定按钮
-(void)btnSure
{
    //NSLog(@"sure");
    
    [UIView animateWithDuration:0.5 animations:^{
        
        orderView.frame=CGRectMake(0, self.view.frame.size.height, 0, 0);
        
    }];
}

//选择里程数
-(void)chooseMeters:(UIButton *)sender
{
    
    //NSLog(@"choose::%@",[carNumArray objectAtIndex:sender.tag]);
    NSMutableString *appendStr=[[NSMutableString alloc] initWithCapacity:0];
    [appendStr appendFormat:@"%@%@",[carInfoContentArray objectAtIndex:2], [carNumArray objectAtIndex:sender.tag]];
    
    [carInfoContentArray removeObjectAtIndex:2];
    [carInfoContentArray insertObject:appendStr atIndex:2];
    [carTableView reloadData];
    
}

//删除里程数
-(void)delMeters
{
    
    NSMutableString *appendStr=[[NSMutableString alloc]initWithFormat:@"%@", [carInfoContentArray objectAtIndex:2]];
    if (appendStr.length>0)
    {
        [carInfoContentArray removeObjectAtIndex:2];
        [carInfoContentArray insertObject:[[appendStr substringFromIndex:0] substringToIndex:appendStr.length-1] atIndex:2];
        
        [carTableView reloadData];
    }
   
}

//选择年份
-(void)chooseYear:(UIButton *)sender
{
    [carInfoContentArray removeObjectAtIndex:3];
    [carInfoContentArray insertObject:[carNumArray objectAtIndex:sender.tag] atIndex:3];
    [carTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        orderView.frame=CGRectMake(0, self.view.frame.size.height, 0, 0);
        
    }];
    
    
    //选择车牌号
    carNumArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
    
    [self initSelectionPanel:carNumArray column:6 isElse:3 event:@selector(chooseMonth:)];
    
}

//选择月份
-(void)chooseMonth:(UIButton *)sender
{
    
    NSMutableString *appendStr=[[NSMutableString alloc] initWithCapacity:0];
    [appendStr appendFormat:@"%@-%@",[carInfoContentArray objectAtIndex:3], [carNumArray objectAtIndex:sender.tag]];
    
    [carInfoContentArray removeObjectAtIndex:3];
    [carInfoContentArray insertObject:appendStr atIndex:3];
    [carTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        orderView.frame=CGRectMake(0, self.view.frame.size.height, 0, 0);
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)JSONSuccess:(id)responseObject
{
    //NSLog(@"responseObject::%@",responseObject);
    
    [ToolLen ShowWaitingView:NO];
    if (responseObject  && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        //创建健康卡成功
        ChangeStateServiceViewController *change=[[ChangeStateServiceViewController alloc] init];
        change.carid=carId;
        [self.navigationController pushViewController:change animated:YES];
        
    }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
}



@end
