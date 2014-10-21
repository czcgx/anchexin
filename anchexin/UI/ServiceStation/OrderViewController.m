//
//  OrderViewController.m
//  anchexin
//
//  Created by cgx on 14-9-14.
//
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize orderArray;
@synthesize stationId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)customUI:(NSString *)item
{
    [bottomView removeFromSuperview];
    
    bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH, 100)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [bottomView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [bottomView addSubview:[self customLabel:CGRectMake(20, 15, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约项目"] alignment:-1 font:15.0]];
    [bottomView addSubview:[self customLabel:CGRectMake(100, 15, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"健康项目"] alignment:-1 font:15.0]];
    [bottomView addSubview:[self customImageView:CGRectMake(272, 10, 30, 30) image:IMAGE(@"ill_pull")]];
    [bottomView addSubview:[self customButton:CGRectMake(100, 15, 200, 20) tag:0 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, 49.5, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //预约项目
    [bottomView addSubview:[self customLabel:CGRectMake(20, 15+50, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"已选择"] alignment:-1 font:15.0]];
    
    /*
     NSLog(@"ssss::%@",orderArray);
     orderMutableArray=[[NSMutableArray alloc] initWithArray:orderArray];
     selectedArray=[[NSMutableArray alloc] init];
     for (int i=0; i<orderMutableArray.count; i++)
     {
         [selectedArray addObject:[[orderMutableArray objectAtIndex:i] objectForKey:@"name"]];
     }
     */
    
    
    orderListArray=[[NSMutableArray alloc] init];
    uploadorderListArray=[[NSMutableArray alloc] init];
    for (int i=0; i<[orderListArrayFlag count]; i++)
    {
        for (int j=0; j<[[orderListArrayFlag objectAtIndex:i] count]; j++)
        {
            if ([[orderListArrayFlag[i] objectAtIndex:j]isEqualToString:@"1"])
            {
                [orderListArray addObject:[[tempArray[i] objectAtIndex:j] objectForKey:@"name"]];
                [uploadorderListArray addObject:[tempArray[i] objectAtIndex:j]];
            }
        }
    }
    
   // NSLog(@"orderListArray::%@",orderListArray);
    
    NSString *LabelString=[NSString stringWithFormat:@"%@",[orderListArray componentsJoinedByString:@"、"]];
    CGSize constraint = CGSizeMake(200.0, 20000.0f);
    CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = MAX(size.height, 30.0f);
    UILabel *selectedLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 15+50, 200,height+5)];
    //cell.contentLabel.frame = CGRectMake(30,34, 260, height+10);//给label定位
    [selectedLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
    [selectedLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
    [selectedLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
    selectedLabel.text=[orderListArray componentsJoinedByString:@"、"];
    [bottomView addSubview:selectedLabel];
    //[bottomView addSubview:[self customLabel:CGRectMake(100, 15+50, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",] alignment:-1 font:15.0]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, selectedLabel.frame.size.height+50.5+30, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    float h=selectedLabel.frame.size.height+50+30;
    
    //额外需求
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"额外需求"] alignment:-1 font:15.0]];
    
    ewaiTextField=[[UITextField alloc] initWithFrame:CGRectMake(100, h+15, 200, 20)];
    [ewaiTextField setBorderStyle:UITextBorderStyleNone];
    ewaiTextField.delegate=self;
    ewaiTextField.textAlignment=NSTextAlignmentLeft;
    ewaiTextField.font=[UIFont systemFontOfSize:15.0];
    ewaiTextField.placeholder=@"请填写您的额外需求";
    [bottomView addSubview:ewaiTextField];
    ewaiTextField.returnKeyType=UIReturnKeyDone;
    //[bottomView addSubview:[self customLabel:CGRectMake(100, h+15, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"健康项目"] alignment:-1 font:15.0]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //预约日期
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约日期"] alignment:-1 font:15.0]];
    orderDate=[self customLabel:CGRectMake(100,  h+15+50, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"请点击选择日期"] alignment:-1 font:15.0];
    [bottomView addSubview:orderDate];
    [bottomView addSubview:[self customButton:orderDate.frame tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //预约时间
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*2, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约时间"] alignment:-1 font:15.0]];
    orderTime=[self customLabel:CGRectMake(100,  h+15+50*2, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"请点击选择时间"] alignment:-1 font:15.0];
    [bottomView addSubview:orderTime];
    [bottomView addSubview:[self customButton:orderTime.frame tag:3 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50*2, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //联系人
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*3, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"联系人"] alignment:-1 font:15.0]];
    orderContact=[self customLabel:CGRectMake(100,  h+15+50*3, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"点击填写联系人"] alignment:-1 font:15.0];
    [bottomView addSubview:orderContact];
    [bottomView addSubview:[self customButton:orderContact.frame tag:4 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50*3, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //联系电话
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*4, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"联系电话"] alignment:-1 font:15.0]];
    orderPhone=[self customLabel:CGRectMake(100,  h+15+50*4, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"点击填写联系电话"] alignment:-1 font:15.0];
    [bottomView addSubview:orderPhone];
    [bottomView addSubview:[self customButton:orderPhone.frame tag:5 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(0, h+49.5+50*4, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [orderScrollView addSubview:bottomView];
    
    
    bottomView.frame=CGRectMake(0, 80, WIDTH,  h+49.5+50*4);
    bottomView.backgroundColor=[UIColor whiteColor];
    orderScrollView.contentSize=CGSizeMake(WIDTH,  h+49.5+50*4+80 +80);
    [pmView removeFromSuperview];
    pmView=[self customView:CGRectMake(60, h+49.5+50*4+80 +25, 200, 40) labelTitle:@"提交预约" buttonTag:1];
    [orderScrollView addSubview:pmView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];

    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0,NavigationBar, WIDTH,480+(iPhone5?88:0)-NavigationBar )];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    

    orderScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height)];
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 50)];
    subView.backgroundColor=[UIColor whiteColor];
    [subView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [subView addSubview:[self customLabel:CGRectMake(20, 15, 280, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@ %@",[[carArray objectAtIndex:0] objectForKey:@"carname"],[[carArray objectAtIndex:0] objectForKey:@"carseries"]] alignment:-1 font:15.0]];
    [subView addSubview:[self drawLine:CGRectMake(0, 49, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [orderScrollView addSubview:subView];
    
    //self customUI:nil];
    
    [mainView addSubview:orderScrollView];
    [self.view addSubview:mainView];
                                                              
    
    calendar= [[CKCalendarView alloc] initWithStartDay:startMonday];
    calendar.frame = CGRectMake(10, 480+(iPhone5?88:0), 300, 470);
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    //维修种类
    sectionArray=[[NSArray alloc] initWithObjects:@"美容",@"保养",@"维修",nil];
    
    listTableView=[[UITableView alloc]initWithFrame:CGRectMake(15, 5, 290, 260)];
    listTableView.delegate=self;
    listTableView.dataSource=self;
    listTableView.tag=1;
    listTableView.backgroundView=nil;
    listTableView.backgroundColor=[UIColor clearColor];
    
    [ToolLen ShowWaitingView:YES];
    requestTimes=0;
    [[self JsonFactory] getServiceList:[[carArray objectAtIndex:0] objectForKey:@"carid"] action:@"getServiceList"];
    
    dataPickerView= [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 0, 280, 216)];//显示数据面板
    dataPickerView.datePickerMode=UIDatePickerModeTime;//显示日期格式
    
    [dataPickerView addTarget:self action:@selector(ChangeDate:) forControlEvents:UIControlEventValueChanged];//更改选择日期
    
    actionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                            delegate:self
                                   cancelButtonTitle:@"完成"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil];
    actionSheet.backgroundColor=[UIColor clearColor];
    
                                                              
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==0)
    {
        ListArray=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"serviceList"]];
        
        NSMutableArray *tempArray0=[[NSMutableArray alloc] init];
        NSMutableArray *tempArray1=[[NSMutableArray alloc] init];
        NSMutableArray *tempArray2=[[NSMutableArray alloc] init];
        
        for (int i=0; i<[ListArray count]; i++)
        {
            //0 美容 1 保养 2 维修
            if ([[[ListArray objectAtIndex:i] objectForKey:@"level"] intValue]==0)
            {
                [tempArray0 addObject:[ListArray objectAtIndex:i]];
            }
            else if ([[[ListArray objectAtIndex:i] objectForKey:@"level"] intValue]==1)
            {
                [tempArray1 addObject:[ListArray objectAtIndex:i]];
            }
            else if ([[[ListArray objectAtIndex:i] objectForKey:@"level"] intValue]==2)
            {
                [tempArray2 addObject:[ListArray objectAtIndex:i]];
            }
        }
        
        tempArray=[[NSMutableArray alloc] initWithObjects:tempArray0,tempArray1,tempArray2, nil];
        // NSLog(@"tempArray::%@",tempArray);
        
        orderListArrayFlag=[[NSMutableArray alloc] init];
        //NSLog(@"orderArray::%@",orderArray);
        
        for (int i=0; i<[tempArray count]; i++)
        {
            NSMutableArray *temp=[[NSMutableArray alloc] init];
            for (int j=0; j<[[tempArray objectAtIndex:i] count]; j++)
            {
                int p=0;
                for (int z=0; z<[orderArray count]; z++)
                {
                    NSString *ij=[[[tempArray objectAtIndex:i] objectAtIndex:j] objectForKey:@"name"];
                    if ([ij isEqualToString:[[orderArray objectAtIndex:z] objectForKey:@"name"]])
                    {
                        p=1;
                        break;
                    }
                }
                if (p==0)
                {
                    [temp addObject:@"0"];
                }
                else
                {
                    [temp addObject:@"1"];
                }
            }
            
            [orderListArrayFlag addObject:temp];
            
        }
        
        [self customUI:nil];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        MyOrderViewController *myorder=[[MyOrderViewController alloc] init];
        myorder.title=@"我的订单";
        myorder.state=0;
        [self.navigationController pushViewController:myorder animated:YES];
    }
}

-(void)customEvent:(UIButton *)sender
{
    pt=(int)sender.tag;
    if (sender.tag==0)
    {
        [dataPickerView removeFromSuperview];
        
        //创建PickerView的信息
        [actionSheet addSubview:listTableView];//显示数据面板
        [actionSheet showInView:[self.view  window]];//显示picker；
        
    }
    else if (sender.tag==1)
    {
        //NSLog(@"提交预约");
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        for (int i=0; i<[uploadorderListArray count]; i++)
        {
            [temp addObject:[[uploadorderListArray objectAtIndex:i] objectForKey:@"id"]];
        }
        
      //  NSLog(@"");

        if (uploadorderListArray.count==0)
        {
            [self alertOnly:@"您未选择预约项目"];
            return;
        }
        else if(orderDate.text.length==0 &&  orderTime.text.length==0)
        {
            [self alertOnly:@"您未选择预约时间"];
            return;
        }
        else if(orderContact.text.length==0 )
        {
            [self alertOnly:@"您未填写联系人"];
            return;
        }
        else if(orderPhone.text.length==0 )
        {
            [self alertOnly:@"您未填写联系方式"];
            return;
        }
    
        [ToolLen ShowWaitingView:YES];
        requestTimes=1;
        [[self JsonFactory] addRequest:orderContact.text mobile:orderPhone.text startTime:[NSString stringWithFormat:@"%@ %@",orderDate.text,orderTime.text] serviceIds:[temp componentsJoinedByString:@","] station:stationId car:[[carArray objectAtIndex:0] objectForKey:@"carid"]  description:ewaiTextField.text  token:nil action:@"addRequest"];
        
        
    }
    else if (sender.tag==2)
    {
        //预约日期
        [self orderDate];
    }
    else if (sender.tag==3)
    {
        [listTableView removeFromSuperview];
        //预约时间
        [actionSheet addSubview:dataPickerView];
        [actionSheet showInView:[self.view window]];
    }
    else if (sender.tag==4)
    {
        //填写联系人
       // NSLog(@"修改公里数");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"请输入联系人"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert show];
        
    }
    else if (sender.tag==5)
    {
        //填写手机号
        //NSLog(@"修改公里数");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"请输入联系人手机号"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert show];
      
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //得到输入框
        UITextField *tf=[alertView textFieldAtIndex:0];
       // NSLog(@"tf::%@",tf.text);
        
        if (pt==4)
        {
            orderContact.text=tf.text;
        }
        else if (pt==5)
        {
            orderPhone.text=tf.text;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//选择日期
-(void)orderDate
{
    [UIView animateWithDuration:0.5 animations:^{
        calendar.frame=CGRectMake(10, NavigationBar+30, 300, 470);
        
    }completion:^(BOOL finished) {
        
    }];
}


- (void)calendar:(CKCalendarView *)calendar1 didSelectDate:(NSDate *)date
{
   // NSLog(@"dateeeee::%@",date.description);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm +0800"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
   // NSLog(@"destDateString::%@",destDateString);
    
    NSString *dateStr=[NSString stringWithFormat:@"%@-%@-%@",[[destDateString substringFromIndex:0] substringToIndex:4],[[destDateString substringFromIndex:5] substringToIndex:2],[[destDateString substringFromIndex:8] substringToIndex:2]];
    
    orderDate.text=dateStr;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        calendar.frame=CGRectMake(10, 480+(iPhone5?88:0), 300, 470);
        
    }completion:^(BOOL finished) {
        
    }];
    
}

//改变日期
-(void)ChangeDate:(id)sender
{
    UIDatePicker *control=(UIDatePicker *)sender;
    NSDate *selectedDate=control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm +0800"];
    NSString *destDateString = [dateFormatter stringFromDate:selectedDate];
    //NSLog(@"destDateString::%@",destDateString);
    
    NSString *dateStr=[NSString stringWithFormat:@"%@:%@",[[destDateString substringFromIndex:11] substringToIndex:2],[[destDateString substringFromIndex:14] substringToIndex:2]];
    
    orderTime.text=dateStr;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tempArray[section] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionArray objectAtIndex:section];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiner];
        cell.backgroundColor=[UIColor clearColor];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    
    if ([[orderListArrayFlag[indexPath.section] objectAtIndex:indexPath.row]isEqualToString:@"1"])
    {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textLabel.text=[[tempArray[indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
    return cell;
    
}


//点击选取
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[orderListArrayFlag[indexPath.section] objectAtIndex:indexPath.row]isEqualToString:@"0"])
    {
        [orderListArrayFlag[indexPath.section] removeObjectAtIndex:indexPath.row];
        [orderListArrayFlag[indexPath.section] insertObject:@"1" atIndex:indexPath.row];
        
    }
    else
    {
        [orderListArrayFlag[indexPath.section] removeObjectAtIndex:indexPath.row];
        [orderListArrayFlag[indexPath.section] insertObject:@"0" atIndex:indexPath.row];
    }
    
    [self customUI:nil];
    
    [listTableView reloadData];
    
}

@end
