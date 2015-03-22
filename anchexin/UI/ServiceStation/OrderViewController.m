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

/*
-(void)refreshUI
{
    
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
    
}

 */


-(void)customUI:(NSString *)item
{
    [bottomView removeFromSuperview];
    
    bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH, 100)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [bottomView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [bottomView addSubview:[self customLabel:CGRectMake(20, 15, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约项目"] alignment:-1 font:15.0]];
    /*
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
     */
    
    NSString *LabelString=nil;
    if (orderArray)
    {
        NSMutableString *appendString=[[NSMutableString alloc]initWithCapacity:0];
        
        for (int i=0; i<orderArray.count; i++)
        {
            [appendString appendString:[[orderArray objectAtIndex:i] objectForKey:@"name"]];
            if (i<orderArray.count-1) {
                [appendString appendString:@","];
            }
            
        }

         LabelString=[NSString stringWithFormat:@"%@",appendString];
    }
  
    CGSize constraint = CGSizeMake(200.0, 20000.0f);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    CGFloat height = MAX(size.height, 20.0f);
    UILabel *selectedLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 15, 200,height+5)];
    [selectedLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
    [selectedLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
    [selectedLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
    selectedLabel.text=LabelString;
    [bottomView addSubview:selectedLabel];
    //横线
    [bottomView addSubview:[self drawLine:CGRectMake(20, selectedLabel.frame.size.height+0.5+30, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    float h=selectedLabel.frame.size.height+30;
    
    //额外需求
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"额外需求"] alignment:-1 font:15.0]];
    
    ewaiTextField=[[UITextField alloc] initWithFrame:CGRectMake(100, h+15, 200, 20)];
    [ewaiTextField setBorderStyle:UITextBorderStyleNone];
    ewaiTextField.delegate=self;
    ewaiTextField.textAlignment=NSTextAlignmentLeft;
    ewaiTextField.font=[UIFont systemFontOfSize:15.0];
    if ([[fillInArray objectAtIndex:0] isEqualToString:@""])
    {
        ewaiTextField.placeholder=@"请填写您的额外需求";
    }
    else
    {
        ewaiTextField.text=[fillInArray objectAtIndex:0];
    }
    
    [bottomView addSubview:ewaiTextField];
    ewaiTextField.returnKeyType=UIReturnKeyDone;
    //[bottomView addSubview:[self customLabel:CGRectMake(100, h+15, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"健康项目"] alignment:-1 font:15.0]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //预约日期
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约日期"] alignment:-1 font:15.0]];
    if ([[fillInArray objectAtIndex:1] isEqualToString:@""])
    {
        orderDate=[self customLabel:CGRectMake(100,  h+15+50, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"请点击选择日期"] alignment:-1 font:15.0];
    }
    else
    {
        orderDate=[self customLabel:CGRectMake(100,  h+15+50, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",[fillInArray objectAtIndex:1]] alignment:-1 font:15.0];
    }
    
    [bottomView addSubview:orderDate];
    [bottomView addSubview:[self customButton:orderDate.frame tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //预约时间
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*2, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"预约时间"] alignment:-1 font:15.0]];
    if ([[fillInArray objectAtIndex:2] isEqualToString:@""])
    {
        orderTime=[self customLabel:CGRectMake(100,  h+15+50*2, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"请点击选择时间"] alignment:-1 font:15.0];
    }
    else
    {
        orderTime=[self customLabel:CGRectMake(100,  h+15+50*2, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",[fillInArray objectAtIndex:2]] alignment:-1 font:15.0];
    }
    
    [bottomView addSubview:orderTime];
    [bottomView addSubview:[self customButton:orderTime.frame tag:3 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50*2, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //联系人
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*3, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"联系人"] alignment:-1 font:15.0]];
    if ([[fillInArray objectAtIndex:3] isEqualToString:@""])
    {
        orderContact=[self customLabel:CGRectMake(100,  h+15+50*3, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"点击填写联系人"] alignment:-1 font:15.0];
    }
    else
    {
        orderContact=[self customLabel:CGRectMake(100,  h+15+50*3, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",[fillInArray objectAtIndex:3]] alignment:-1 font:15.0];
    }
    
    [bottomView addSubview:orderContact];
    [bottomView addSubview:[self customButton:orderContact.frame tag:4 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(20, h+49.5+50*3, 280, 0.5) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    //联系电话
    [bottomView addSubview:[self customLabel:CGRectMake(20, h+15+50*4, 80, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",@"联系电话"] alignment:-1 font:15.0]];
    if ([[fillInArray objectAtIndex:4] isEqualToString:[userDic objectForKey:@"mobile"]])
    {
        orderPhone=[self customLabel:CGRectMake(100,  h+15+50*4, 200, 20) color:[UIColor darkGrayColor] text:[userDic objectForKey:@"mobile"] alignment:-1 font:15.0];
    }
    else
    {
        orderPhone=[self customLabel:CGRectMake(100,  h+15+50*4, 200, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@",[fillInArray objectAtIndex:4]] alignment:-1 font:15.0];
    }
    
    [bottomView addSubview:orderPhone];
    [bottomView addSubview:[self customButton:orderPhone.frame tag:5 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [bottomView addSubview:[self drawLine:CGRectMake(0, h+49.5+50*4, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [orderScrollView addSubview:bottomView];
    
    
    bottomView.frame=CGRectMake(0, 80, WIDTH,  h+49.5+50*4);
    bottomView.backgroundColor=[UIColor whiteColor];
    orderScrollView.contentSize=CGSizeMake(WIDTH,  h+49.5+50*4+80 +80);
    [pmView removeFromSuperview];
    
    pmView=[self customView:CGRectMake(60, h+49.5+50*4+80 +25, 200, 40) labelTitle:@"在线预约" buttonTag:1];
    [orderScrollView addSubview:pmView];
    
    /*
    if (orderArray)
    {
        pmView=[self customView:CGRectMake(30, h+49.5+50*4+80 +25, 120, 40) labelTitle:@"到店支付" buttonTag:1];
        [orderScrollView addSubview:pmView];
        
        [orderScrollView addSubview:[self customView:CGRectMake(170, h+49.5+50*4+80 +25, 120, 40) labelTitle:@"在线支付" buttonTag:12]];
    }
    else
    {
        pmView=[self customView:CGRectMake(60, h+49.5+50*4+80 +25, 200, 40) labelTitle:@"在线预约" buttonTag:15];
        [orderScrollView addSubview:pmView];
    }
   */
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];

    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0,NavigationBar, WIDTH,480+(iPhone5?88:0)-NavigationBar )];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    //初始化
    fillInArray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",[userDic objectForKey:@"mobile"], nil];
    
    orderScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height)];
    
    //显示车型
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 50)];
    subView.backgroundColor=[UIColor whiteColor];
    [subView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    carID=[carDic objectForKey:@"carid"];
    carTypeLabel=[self customLabel:CGRectMake(20, 15, 275, 20) color:[UIColor darkGrayColor] text:[NSString stringWithFormat:@"%@ %@",[carDic objectForKey:@"carname"],[carDic objectForKey:@"carseries"]] alignment:-1 font:15.0];
    [subView addSubview:carTypeLabel];
    
    //按钮更换车型号
    [subView addSubview:[self customImageView:CGRectMake(285, 10, 30, 30) image:IMAGE(@"ill_pull")]];
    [subView addSubview:[self customButton:CGRectMake(0, 0, WIDTH, 50) tag:0 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [subView addSubview:[self drawLine:CGRectMake(0, 49, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [orderScrollView addSubview:subView];
    
    [self customUI:nil];//初始化视图
    
    [mainView addSubview:orderScrollView];
    [self.view addSubview:mainView];
                                                              
    
    calendar= [[CKCalendarView alloc] initWithStartDay:startMonday];
    calendar.frame = CGRectMake(10, 480+(iPhone5?88:0), 300, 470);
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    
    //维修种类
    //sectionArray=[[NSArray alloc] initWithObjects:@"美容",@"保养",@"维修",nil];
    
    listTableView=[[UITableView alloc]initWithFrame:CGRectMake(15, 5, 290, 260)];
    listTableView.delegate=self;
    listTableView.dataSource=self;
    listTableView.tag=1;
    listTableView.backgroundView=nil;
    listTableView.backgroundColor=[UIColor clearColor];
    
    [ToolLen ShowWaitingView:YES];
    requestTimes=0;
    //[[self JsonFactory] getServiceList:[[carArray objectAtIndex:0] objectForKey:@"carid"] action:@"getServiceList"];
    
    [[self JsonFactory] getCarList:@"getCarList"];//获取车辆列表
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        dataPickerView= [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 0, 280, 216)];//显示数据面板
        dataPickerView.datePickerMode=UIDatePickerModeTime;//显示日期格式
        
        [dataPickerView addTarget:self action:@selector(ChangeDate:) forControlEvents:UIControlEventValueChanged];//更改选择日期
        
        alertController=[UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        alertController.view.backgroundColor=[UIColor clearColor];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       
                                       {
                                           
                                           ////todo
                                           
                                       }];
        
        [alertController.view addSubview:dataPickerView];
        [alertController addAction:cancelAction];
        
    }
    else
    {
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
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==0)
    {
        //车辆列表
        ListArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"carlist"]];
        [listTableView reloadData];
    
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        //进入我的订单列表
        MyOrderViewController *myorder=[[MyOrderViewController alloc] init];
        myorder.title=@"我的订单";
        myorder.state=0;
        myorder.selected=0;
        [self.navigationController pushViewController:myorder animated:YES];
        
    }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
}

-(void)customEvent:(UIButton *)sender
{
    pt=(int)sender.tag;
    if (sender.tag==0)
    {
        [dataPickerView removeFromSuperview];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            
            [alertController.view addSubview:listTableView];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        else
        {
            //创建PickerView的信息
            [actionSheet addSubview:listTableView];//显示数据面板
            [actionSheet showInView:[self.view  window]];//显示picker；
        }

    }
    else if (sender.tag==1)
    {
        //预约
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        for (int i=0; i<[orderArray count]; i++)
        {
            [temp addObject:[[orderArray objectAtIndex:i] objectForKey:@"code"]];
        }
        
        //NSLog(@"fillInArray::%@",fillInArray);

        if (orderArray.count==0)
        {
            [self alertOnly:@"您未选择预约项目"];
            return;
        }
        else if([[fillInArray objectAtIndex:1] length]==0 ||  [[fillInArray objectAtIndex:2] length]==0)
        {
            [self alertOnly:@"您未选择预约时间"];
            return;
        }
        else if([[fillInArray objectAtIndex:3] length]==0)
        {
            [self alertOnly:@"您未填写联系人"];
            return;
        }
        else if([[fillInArray objectAtIndex:4] length]==0 )
        {
            [self alertOnly:@"您未填写联系方式"];
            return;
        }
    
        [ToolLen ShowWaitingView:YES];
        requestTimes=1;
        [[self JsonFactory] addRequest:orderContact.text mobile:[fillInArray objectAtIndex:3] startTime:[NSString stringWithFormat:@"%@ %@",[fillInArray objectAtIndex:1],[fillInArray objectAtIndex:2]] serviceList:[temp componentsJoinedByString:@","] station:stationId car:carID  description:ewaiTextField.text  token:nil action:@"addRequest"];
        
    }
    else if (sender.tag==2)
    {
        //预约日期
        [self orderDate];
    }
    else if (sender.tag==3)
    {
        [listTableView removeFromSuperview];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [alertController.view addSubview:dataPickerView];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            //预约时间
            [actionSheet addSubview:dataPickerView];
            [actionSheet showInView:[self.view window]];
        }
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
    /*
    else if(sender.tag==12)
    {
       //预约
        NSMutableArray *temp=[[NSMutableArray alloc] init];
        for (int i=0; i<[orderArray count]; i++)
        {
            [temp addObject:[[orderArray objectAtIndex:i] objectForKey:@"code"]];
        }
        
        NSLog(@"fillInArray::%@",fillInArray);
        
        if (orderArray.count==0)
        {
            [self alertOnly:@"您未选择预约项目"];
            return;
        }
        else if([[fillInArray objectAtIndex:1] length]==0 ||  [[fillInArray objectAtIndex:2] length]==0)
        {
            [self alertOnly:@"您未选择预约时间"];
            return;
        }
        else if([[fillInArray objectAtIndex:3] length]==0)
        {
            [self alertOnly:@"您未填写联系人"];
            return;
        }
        else if([[fillInArray objectAtIndex:4] length]==0 )
        {
            [self alertOnly:@"您未填写联系方式"];
            return;
        }
        
        [ToolLen ShowWaitingView:YES];
        requestTimes=1;
        [[self JsonFactory] addRequest:orderContact.text mobile:[fillInArray objectAtIndex:3] startTime:[NSString stringWithFormat:@"%@ %@",[fillInArray objectAtIndex:1],[fillInArray objectAtIndex:2]] serviceIds:[temp componentsJoinedByString:@","] station:stationId car:carID  description:ewaiTextField.text  token:nil action:@"addRequest"];

    }
     */
    
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
            [fillInArray removeObjectAtIndex:3];
            [fillInArray insertObject:orderContact.text atIndex:3];
            
        }
        else if (pt==5)
        {
            orderPhone.text=tf.text;
            [fillInArray removeObjectAtIndex:4];
            [fillInArray insertObject:orderPhone.text atIndex:4];
            
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
        
        [fillInArray removeObjectAtIndex:1];
        [fillInArray insertObject:orderDate.text atIndex:1];
        
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
    
    [fillInArray removeObjectAtIndex:2];
    [fillInArray insertObject:orderTime.text atIndex:2];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [fillInArray removeObjectAtIndex:0];
    [fillInArray insertObject:ewaiTextField.text atIndex:0];
    
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ListArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiner];
        
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",[[ListArray objectAtIndex:indexPath.row]  objectForKey:@"carname"],[[ListArray objectAtIndex:indexPath.row]  objectForKey:@"carseries"]];
    
    return cell;

}


//点击选取
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    carID=[[ListArray objectAtIndex:indexPath.row] objectForKey:@"carid"];
    
    carTypeLabel.text=[NSString stringWithFormat:@"%@ %@",[[ListArray objectAtIndex:indexPath.row]  objectForKey:@"carname"],[[ListArray objectAtIndex:indexPath.row]  objectForKey:@"carseries"]];
    
    
    [listTableView reloadData];
    
}








@end
