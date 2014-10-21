//
//  CreateHealthyCarViewController.m
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import "CreateHealthyCarViewController.h"

#define colorCircle [UIColor colorWithRed:153/255.0 green:200/255.0 blue:130/255.0 alpha:1.0]

@interface CreateHealthyCarViewController ()

@end

@implementation CreateHealthyCarViewController
@synthesize blindcarID;
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
  
}

//画圆
-(UILabel *)customCircle:(CGRect)frame titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor title:(NSString *)title
{
    UILabel *circle=[[UILabel alloc] initWithFrame:frame];
    circle.textAlignment=NSTextAlignmentCenter;
    circle.text=title;
    circle.font=[UIFont systemFontOfSize:18.0];
    circle.textColor=titleColor;
    circle.backgroundColor=backgroundColor;
    circle.layer.cornerRadius = 15;//(值越大，角就越圆)
    circle.layer.masksToBounds = YES;
    circle.layer.borderWidth=1.0;
    circle.layer.borderColor=[colorCircle CGColor];
    
    return circle;
}

//左边问题
-(UIView *)customQuestionView:(CGRect)frame title:(NSString *)title index:(int)index
{
    UIView *customView=[[UIView alloc] initWithFrame:frame];
    customView.backgroundColor=[UIColor clearColor];
    [customView addSubview:[self customImageView:customView.bounds image:IMAGE(@"healthy_left")]];
    UILabel *lbl=[self customLabel:CGRectMake(5, 10, 120, 50) color:[UIColor darkGrayColor] text:title alignment:-1 font:16.0];
    [lbl setLineBreakMode:NSLineBreakByCharWrapping];
    [lbl setNumberOfLines:0];
    [customView addSubview:lbl];
    
    [customView addSubview:[self customCircle:CGRectMake(90, 40, 30, 30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"答"]];
    
    [customView addSubview:[self customButton:customView.bounds tag:index title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    return customView;
}

-(void)customEvent:(UIButton *)sender
{
    pt=(int)sender.tag;
    showLabel.text=@"";
    if (sender.tag==0)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请输入当前行驶里程"
                                                          message:@"单位是(KM)"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
            
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];
            
        }
        else
        {
            kiloMutableArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            kiloArray=[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
            
            [dataPickerView removeFromSuperview];
            [picker reloadAllComponents];
            
            [actionSheet addSubview:picker];//显示数据面板
            [actionSheet showInView:[self.view window]];
        }
    }
    else if (sender.tag==1)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请输入上路时间"
                                                          message:@"例如:2014-08"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
            
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];
        }
        else
        {
            [picker removeFromSuperview];
            
            [actionSheet addSubview:dataPickerView];//显示数据面板
            [actionSheet showInView:[self.view  window]];//显示picker

        }
    }
    else if (sender.tag==2)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请输入您的车牌号"
                                                          message:@"例如:沪A12345"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
            
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];
        }
        else
        {
            kiloMutableArray=[[NSMutableArray alloc] initWithObjects:@"京",@"A",@"0",@"0",@"0",@"0",@"0", nil];
            
            cityArray=[[NSArray alloc]initWithObjects:@"京",@"沪",@"苏",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"黔",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台",nil];
            
            secArray=[[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
            otherArray=[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
            
            [dataPickerView removeFromSuperview];
            [picker reloadAllComponents];
            
            [actionSheet addSubview:picker];//显示数据面板
            [actionSheet showInView:[self.view window]];
            
        }
    }
    else if (sender.tag==4)
    {
        //NSLog(@"anwserArray::%@",anwserArray);
        
        [ToolLen ShowWaitingView:YES];
        
        [[self JsonFactory] set_addHealthCard:blindcarID currentMileage:[anwserArray objectAtIndex:0] buyTime:[anwserArray objectAtIndex:1] lastMaintainTime:@"" lastCurrentMileage:@"" checkItemList:@"" licenseNumber:[anwserArray objectAtIndex:2] action:@"addHealthCard"];
        
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //得到输入框
        UITextField *tf=[alertView textFieldAtIndex:0];
        // NSLog(@"tf::%@",tf.text);
        
        if (tf.text.length>0)
        {
            // 使用NSString *strUrl = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
            //NSString *tempString=[NSString stringWithFormat:@"%@-%@-%@",[[tf.text substringFromIndex:0] substringToIndex:4],[[tf.text substringFromIndex:5] substringToIndex:2],[[tf.text substringFromIndex:8] substringToIndex:2]];
            
            //tf.text=[tf.text stringByReplacingOccurrencesOfString:@"——" withString:@"-"];
            
            //NSLog(@"tempString::%@",tempString);
    
            if (pt==0)
            {
                [anwserArray insertObject:tf.text atIndex:pt];
                
                [UIView animateWithDuration:0.2 animations:^{
                    [mainView addSubview:[self customCircle:CGRectMake(145, 20, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"1"]];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        [mainView addSubview:[self drawLine:CGRectMake(159, 50, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
                        
                        [mainView addSubview:[self customAnwsterView:CGRectMake(170, 100, 140, 50) title:[NSString stringWithFormat:@"答:%@",tf.text]]];
                        
                        
                    } completion:^(BOOL finished) {
                        [mainView addSubview:[self customQuestionView:CGRectMake(10, 170, 130, 80) title:[questionArray objectAtIndex:1] index:1]];
                        
                        [mainView addSubview:[self customCircle:CGRectMake(145, 170, 30,30) titleColor:colorCircle backgroundColor:[UIColor whiteColor] title:@"2"]];
                    }];
                }];
            }
            else if (pt==1)
            {
                if (pt==1 && tf.text.length==7)
                {
                    NSString *tempString=[NSString stringWithFormat:@"%@-%@",[[tf.text substringFromIndex:0] substringToIndex:4],[[tf.text substringFromIndex:5] substringToIndex:2]];
                    
                    [anwserArray insertObject:tempString atIndex:pt];
                    
                }
                else
                {
                    [self alertOnly:@"请参照例子输入内容"];
                    return;
                }
                
                [UIView animateWithDuration:0.2 animations:^{
                    [mainView addSubview:[self customCircle:CGRectMake(145, 170, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"2"]];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        [mainView addSubview:[self drawLine:CGRectMake(159, 200, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
                        
                        [mainView addSubview:[self customAnwsterView:CGRectMake(170, 250, 140, 50) title:[NSString stringWithFormat:@"答:%@",tf.text]]];
                        
                    } completion:^(BOOL finished) {
                        [mainView addSubview:[self customQuestionView:CGRectMake(10, 320, 130, 80) title:[questionArray objectAtIndex:2] index:2]];
                        
                        [mainView addSubview:[self customCircle:CGRectMake(145, 320, 30,30) titleColor:colorCircle backgroundColor:[UIColor whiteColor] title:@"3"]];
                    }];
                }];
                
            }
            else
            {
                if (pt==2 && tf.text.length==7)
                {
                    [anwserArray insertObject:tf.text atIndex:pt];
                    
                }
                else
                {
                    [self alertOnly:@"请参照例子输入内容"];
                    return;
                }
                
                [UIView animateWithDuration:0.2 animations:^{
                    [mainView addSubview:[self customCircle:CGRectMake(145, 320, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"3"]];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        [mainView addSubview:[self drawLine:CGRectMake(159, 350, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
                        
                        [mainView addSubview:[self customAnwsterView:CGRectMake(170, 400, 140, 50) title:[NSString stringWithFormat:@"答:%@",tf.text]]];
                    } completion:^(BOOL finished) {
                        [mainView addSubview:[self customView:CGRectMake(60, 470, 200, 40) labelTitle:@"创建健康卡" buttonTag:4]];
                    }];
                }];
                
            }
            
        }
        else
        {
            [self alertOnly:@"请参照格式输入"];
        }
    }
}


-(UIView *)customAnwsterView:(CGRect)frame title:(NSString *)title
{
    UIView *customView=[[UIView alloc] initWithFrame:frame];
    customView.backgroundColor=[UIColor clearColor];
    [customView addSubview:[self customImageView:customView.bounds image:IMAGE(@"healthy_right")]];
    
    [customView addSubview:[self customLabel:CGRectMake(10, 15, 150, 20) color:[UIColor darkGrayColor] text:title alignment:-1 font:16.0] ];
    
    return customView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self skinOfBackground];
    self.title=@"创建健康卡";

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
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    subView.backgroundColor=kUIColorFromRGB(Commonbg);
    [self.view addSubview:subView];
    
    healthyScrollView=[[UIScrollView alloc] initWithFrame:subView.bounds];
   
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 520)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    questionArray=[[NSArray alloc] initWithObjects:@"您的爱车当前行驶里程是？",@"您的爱车上路时间是？",@"请输入您的车牌号？", nil];

    anwserArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    
    [mainView addSubview:[self customQuestionView:CGRectMake(10, 20, 130, 80) title:[questionArray objectAtIndex:0] index:0]];
    [mainView addSubview:[self customCircle:CGRectMake(145, 20, 30,30) titleColor:colorCircle backgroundColor:[UIColor whiteColor] title:@"1"]];
    [healthyScrollView addSubview:mainView];
    
    
    healthyScrollView.contentSize=CGSizeMake(WIDTH, 520);
    [subView addSubview:healthyScrollView];
    
    
    
    /*
    n=1;
    
    anwserArray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",nil];
    
    createCardTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height)];
    createCardTableView.delegate=self;
    createCardTableView.dataSource=self;
    createCardTableView.tag=1;
    createCardTableView.backgroundView=nil;
    createCardTableView.backgroundView.backgroundColor=[UIColor clearColor];
    createCardTableView.backgroundColor=[UIColor clearColor];
    createCardTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [mainView addSubview:createCardTableView];
 */

    showLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    showLabel.backgroundColor=kUIColorFromRGB(Commonbg);
    showLabel.font=[UIFont systemFontOfSize:20.0];
    showLabel.textAlignment=NSTextAlignmentCenter;
    showLabel.textColor=[UIColor blackColor];
    
    //创建PickerView的信息
    picker= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];//显示数据面板
    picker.delegate=self;//显示数据
    picker.dataSource=self;
    picker.showsSelectionIndicator = YES;//选中得显示杠
    picker.backgroundColor=[UIColor whiteColor];
    
    //弹出日期
    dataPickerView= [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 216)];//显示数据面板
    dataPickerView.datePickerMode=UIDatePickerModeDate;//显示日期格式
    [dataPickerView addTarget:self action:@selector(ChangeDate:) forControlEvents:UIControlEventValueChanged];//更改选择日期
    
    actionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                            delegate:self
                                   cancelButtonTitle:@"完成"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:nil];
    actionSheet.backgroundColor=[UIColor clearColor];
    
    [actionSheet addSubview:showLabel];
    
    //创建PickerView的信息
    //[actionSheet addSubview:picker];//显示数据面板
    //[actionSheet addSubview:dataPickerView];//显示数据面板
}

//改变日期
-(void)ChangeDate:(id)sender
{
    UIDatePicker *control=(UIDatePicker *)sender;
    NSDate *selectedDate=control.date;
    
    NSString *dateStr=[NSString stringWithFormat:@"%@-%@",[[selectedDate.description substringFromIndex:0] substringToIndex:4],[[selectedDate.description substringFromIndex:5] substringToIndex:2]];
    
    showLabel.text=dateStr;
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject  && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        //创建健康卡成功
        ChangeStateServiceViewController *change=[[ChangeStateServiceViewController alloc] init];
        change.carid=blindcarID;
        
        [self.navigationController pushViewController:change animated:YES];
        
    }
}



/*
//使页面滑动到最下面
-(void)scrollToBottom
{
	//UITableView *tableView = (UITableView *)[self.view viewWithTag:300];
	NSUInteger sectionCount = [createCardTableView numberOfSections];//获取section数
	if (sectionCount)
    {
		NSUInteger rowCount = [createCardTableView numberOfRowsInSection:0];//获取row数
		if (rowCount)
        {
			NSUInteger ii[2] = {0,rowCount-1};
			NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:ii length:2];
			[createCardTableView scrollToRowAtIndexPath:indexPath
                             atScrollPosition:UITableViewScrollPositionTop
                                     animated:YES];
		}
	}
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return n;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==1)
    {
        if (indexPath.row==2*[questionArray count])
        {
            return 50.0;
        }
        
        if (indexPath.row%2==0)
        {
            if (indexPath.row==0)
            {
                return 150.0;
            }
            else
            {
                return 130.0;
            }
            
        }
        return 50.0;
    }
    else
    {
        return 40.0;
    }
  
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
  
    //显示创建健康卡按钮cell
    if (indexPath.row==2*[questionArray count])
    {
        CreateCell *cell=(CreateCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CreateCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
                
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
            
        [cell.createButton addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
            
        return cell;
            
    }
        
    if (indexPath.row%2==0)
    {
        CreateCardCell *cell=(CreateCardCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CreateCardCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        //问题
        cell.titleLabel.text=[NSString stringWithFormat:@"%@?",[questionArray objectAtIndex:indexPath.row/2] ];
            
            
        cell.textField.delegate=self;
        cell.textField.tag=indexPath.row;
        if (indexPath.row==2)
        {
            cell.pLabel.hidden=NO;//单位
        }
        else
        {
            cell.pLabel.hidden=YES;//单位
        }
        if (indexPath.row==0)
        {
            cell.helloLabel.hidden=NO;//问候语
            cell.textField.placeholder=@"如:2014-01";
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=cell.textField.bounds;
            button.tag=indexPath.row;
            [button addTarget:self action:@selector(cilickDateView:) forControlEvents:UIControlEventTouchUpInside];
                
            [cell.textField addSubview:button];
                
        }
        else
        {
            
            cell.helloLabel.hidden=YES;
            cell.mainView.frame=CGRectMake(80, 20, 220, 100);
            cell.cellBg.frame=CGRectMake(63, 10, 251, 115);
            if (indexPath.row==2)
            {
                cell.textField.placeholder=@"请输入整数";
                cell.textField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            }
            else
            {
                cell.textField.placeholder=@"如:沪A12345";
                cell.textField.keyboardType=UIKeyboardTypeNamePhonePad;
            }
        }
        
        if (anwserArray.count>0)
        {
            cell.textField.text=[anwserArray objectAtIndex:indexPath.row/2];
        }
        else
        {
            cell.textField.text=@"";
            cell.okButton.enabled=YES;
            cell.okButton.enabled=YES;
        }
        
        cell.okButton.tag=indexPath.row;
        [cell.okButton addTarget:self action:@selector(clickOK:) forControlEvents:UIControlEventTouchUpInside];
            
        return cell;
            
    }
    else
    {
        CreateAnswerCardCell *cell=(CreateAnswerCardCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CreateAnswerCardCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
                
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
            
        cell.anwerLabel.textAlignment=NSTextAlignmentLeft;
     
        if (indexPath.row==3)
        {
            cell.anwerLabel.text=[NSString stringWithFormat:@"%@:%@km",@"您的回答是",[anwserArray objectAtIndex: indexPath.row/2]];
        }
        else
        {
            cell.anwerLabel.text=[NSString stringWithFormat:@"%@:%@",@"您的回答是",[anwserArray objectAtIndex: indexPath.row/2]];
        }
        
        
        return cell;
    }
   
}



//是否是纯数字
- (BOOL)CheckInput:(NSString *)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}


//点击确定按钮
-(void)clickOK:(id)sender
{
    if ([sender tag]==2 || [sender tag]==4)
    {
        createCardTableView.center=CGPointMake(WIDTH/2, createCardTableView.frame.size.height/2+NavigationBar);
    }
   
    NSIndexPath *ip = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    CreateCardCell *cell = (CreateCardCell *)[createCardTableView cellForRowAtIndexPath:ip];
    
    if (cell.textField.text.length>0)
    {
        if ([sender tag]==4)
        {
            if (cell.textField.text.length==7)
            {
            }
            else
            {
                [self alertOnly:@"请检查您输入的车牌号是否有误"];
                return;
            }

        }
    }
    else
    {
        [self alertOnly:@"请输入相应信息"];
        return;
    }
    
    
    //NSLog(@"sender.tag::%d===n::%d",[sender tag],n);
    if ([sender tag]/2==n/2)
    {
        if (n==2*[questionArray count])
        {
            n=n+1;
        }
        else
        {
            n=n+2;
        }
    }
   
    //[anwserArray addObject:cell.textField.text];
    [anwserArray removeObjectAtIndex:[sender tag]/2];
    [anwserArray insertObject:cell.textField.text atIndex:[sender tag]/2];
    
    [createCardTableView reloadData];
    [self scrollToBottom];//滑动到最底部
}

//弹出日期选择视图
-(void)cilickDateView:(id)sender
{
   
    
}







//点击return健返回
-(BOOL)textFieldShouldReturn:(CreateCardCell *)textField
{
    [textField resignFirstResponder];
    if (textField.tag==2 || textField.tag==4)
    {
        createCardTableView.center=CGPointMake(WIDTH/2, createCardTableView.frame.size.height/2+NavigationBar);
    }
    return YES;

   
}

//开始编辑内容
-(BOOL)textFieldShouldBeginEditing:(CreateCardCell *)textField
{
    if(textField.tag==2)
    {
        createCardTableView.center=CGPointMake(WIDTH/2, 120);
    }
    else if(textField.tag==4)
    {
        createCardTableView.center=CGPointMake(WIDTH/2, 120-80);
        
    }
    
 
    return YES;
    
}


//创建健康卡
-(void)create
{
   // NSLog(@"创建健康卡");

    requestFlag=2;//创建健康卡
    [ToolLen ShowWaitingView:YES];
    
    [[self JsonFactory] set_addHealthCard:blindcarID currentMileage:[anwserArray objectAtIndex:1] buyTime:[anwserArray objectAtIndex:0] lastMaintainTime:@"" lastCurrentMileage:@"" checkItemList:@"" licenseNumber:[anwserArray objectAtIndex:2] action:@"addHealthCard"];
    
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 7;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pt==0)
    {
         return 10;
    }
    else
    {
        if (component==0)
        {
            return cityArray.count;
        }
        else if (component==1)
        {
            return secArray.count;
        }
        else
        {
            return otherArray.count;
        }
    }

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
 
    if (pt==0)
    {
        return [kiloArray objectAtIndex:row];
    }
    else
    {
        if (component==0)
        {
            return [cityArray objectAtIndex:row];
        }
        else if (component==1)
        {
            return [secArray objectAtIndex:row];
        }
        else
        {
            return [otherArray objectAtIndex:row];
        }
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pt==0)
    {
        [kiloMutableArray removeObjectAtIndex:component];
        [kiloMutableArray insertObject:[kiloArray objectAtIndex:row] atIndex:component];
       
        int m=0;
        for (int i=0; i<kiloMutableArray.count; i++)
        {
            if ([[kiloMutableArray objectAtIndex:i]isEqualToString:@"0"])
            {
                
            }
            else
            {
                m=i;
                break;
            }
        }
        showLabel.text=[NSString stringWithFormat:@"%@ Km",[[kiloMutableArray componentsJoinedByString:@""] substringFromIndex:m]];
        
    }
    else
    {
        if (component==0)
        {
            [kiloMutableArray removeObjectAtIndex:component];
            [kiloMutableArray insertObject:[cityArray objectAtIndex:row] atIndex:component];
        }
        else if (component==1)
        {
            [kiloMutableArray removeObjectAtIndex:component];
            [kiloMutableArray insertObject:[secArray objectAtIndex:row] atIndex:component];
        }
        else
        {
        
            [kiloMutableArray removeObjectAtIndex:component];
            [kiloMutableArray insertObject:[otherArray objectAtIndex:row] atIndex:component];
        }
        
        
        showLabel.text=[NSString stringWithFormat:@"%@",[kiloMutableArray componentsJoinedByString:@""] ];
        
    }
    
}

//点击完成取消弹出框
-(void)actionSheet:(UIActionSheet *)actionSheet1 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [actionSheet1 dismissWithClickedButtonIndex:1 animated:YES];
        [anwserArray removeObjectAtIndex:pt];
        if (pt==0)
        {
            [anwserArray insertObject:[showLabel.text substringToIndex:showLabel.text.length-3] atIndex:pt];
        }
        else
        {
            [anwserArray insertObject:showLabel.text atIndex:pt];
        }
        
        
        if (pt==0)
        {
             [UIView animateWithDuration:0.2 animations:^{
             [mainView addSubview:[self customCircle:CGRectMake(145, 20, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"1"]];
             } completion:^(BOOL finished) {
             [UIView animateWithDuration:0.3 animations:^{
             [mainView addSubview:[self drawLine:CGRectMake(159, 50, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
             
             [mainView addSubview:[self customAnwsterView:CGRectMake(170, 100, 140, 50) title:[NSString stringWithFormat:@"答:%@",showLabel.text]]];
                 
                 
             } completion:^(BOOL finished) {
             [mainView addSubview:[self customQuestionView:CGRectMake(10, 170, 130, 80) title:[questionArray objectAtIndex:1] index:1]];
             
             [mainView addSubview:[self customCircle:CGRectMake(145, 170, 30,30) titleColor:colorCircle backgroundColor:[UIColor whiteColor] title:@"2"]];
             }];
             }];
        }
        else if (pt==1)
        {
            [UIView animateWithDuration:0.2 animations:^{
                [mainView addSubview:[self customCircle:CGRectMake(145, 170, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"2"]];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    [mainView addSubview:[self drawLine:CGRectMake(159, 200, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
                    
                    [mainView addSubview:[self customAnwsterView:CGRectMake(170, 250, 140, 50) title:[NSString stringWithFormat:@"答:%@",showLabel.text]]];
                    
                } completion:^(BOOL finished) {
                    [mainView addSubview:[self customQuestionView:CGRectMake(10, 320, 130, 80) title:[questionArray objectAtIndex:2] index:2]];
                    
                    [mainView addSubview:[self customCircle:CGRectMake(145, 320, 30,30) titleColor:colorCircle backgroundColor:[UIColor whiteColor] title:@"3"]];
                }];
            }];

        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                [mainView addSubview:[self customCircle:CGRectMake(145, 320, 30,30) titleColor:[UIColor whiteColor] backgroundColor:colorCircle title:@"3"]];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    [mainView addSubview:[self drawLine:CGRectMake(159, 350, 1, 120) drawColor:kUIColorFromRGB(CommonLinebg)]];
                    
                    [mainView addSubview:[self customAnwsterView:CGRectMake(170, 400, 140, 50) title:[NSString stringWithFormat:@"答:%@",showLabel.text]]];
                } completion:^(BOOL finished) {
                    [mainView addSubview:[self customView:CGRectMake(60, 470, 200, 40) labelTitle:@"创建健康卡" buttonTag:4]];
                }];
            }];

        }
        
       
    }
}


@end
