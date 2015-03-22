//
//  NoticationsViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "NoticationsViewController.h"

@interface NoticationsViewController ()

@end

@implementation NoticationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
-(void)viewWillAppear:(BOOL)animated
{
    if (carArray.count==0)
    {
        CarTypeViewController *type=[[CarTypeViewController alloc] init];
        
        [self.navigationController pushViewController:type animated:YES];
    }
}
 */

-(void)refreshUI2
{
    [self customEvent:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    [self refreshAccount];
    //NSLog(@"carDic::%@",carDic);
    
    if (carDic.count==0)
    {
        [self alertOnly:@"您未选择车辆"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI2) name:@"refreshUI2" object:nil];
    
   
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    
    tabView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    tabView.backgroundColor=[UIColor clearColor];
    [tabView addSubview:[self customImageView:tabView.bounds image:IMAGE(@"rootbg")]];
    NSArray *tabArray=[NSArray arrayWithObjects:@"保养",@"年检",@"保险",@"故障", nil];
    for (int i=0; i<tabArray.count; i++)
    {
        if (i>0)
        {
            UILabel *label_=[[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 1, 30)];
            label_.backgroundColor=[UIColor whiteColor];
            [tabView addSubview:label_];
        }
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 30)];
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
    tabLine=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 80, 10)];
    tabLine.backgroundColor=[UIColor clearColor];
    [tabLine addSubview:[self customImageView:CGRectMake(32.5, 0, 15, 10) image:IMAGE(@"sanjiao")]];
    [tabView addSubview:tabLine];
    
    [mainView addSubview:tabView];
    
    
    //底部
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, mainView.frame.size.height-50-50)];
    subView.backgroundColor=[UIColor whiteColor];
    
    pt=100;
    remindTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, subView.frame.size.height)];
    remindTableView.delegate=self;
    remindTableView.dataSource=self;
    remindTableView.backgroundView=nil;
    remindTableView.backgroundColor=[UIColor clearColor];
    remindTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [subView addSubview:remindTableView];
    
    [mainView addSubview:subView];
    [self.view addSubview:mainView];
    
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"] type:@"0" action:@"getNoticeList"];//保养
    
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    [desLabel removeFromSuperview];
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && pt==100)
    {
        noticeList=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"noticeList"]];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==15)
    {
        [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"]  type:@"3" action:@"getNoticeList"];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==16)
    {
        [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"]  type:@"2" action:@"getNoticeList"];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && pt==101)
    {
        noticeDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        noticeList=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"noticeList"]];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && pt==102)
    {
        noticeDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        noticeList=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"noticeList"]];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && pt==103)
    {
        noticeList=[[NSArray alloc]initWithArray:[responseObject objectForKey:@"noticeList"]];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==-4 && pt==102)
    {
        //没有输入保险时间
        noticeDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        noticeList=[[NSArray alloc]init];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==-5 && pt==101)
    {
        //没有输入年检时间
        noticeDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        noticeList=[[NSArray alloc]init];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==-2)
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
    else
    {
        noticeList=[[NSArray alloc]init];
        
        //NSLog(@"message:%@",[responseObject objectForKey:@"message"]);
        if (pt==102 || pt==101)
        {
            noticeDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        }
        else
        {
            desLabel=[self customLabel:CGRectMake(0, NavigationBar+70, WIDTH, 20) color:[UIColor blackColor] text:[responseObject objectForKey:@"message"] alignment:-0 font:16.0];
            [self.view addSubview:desLabel];
        }
    }
    
    [remindTableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customEvent:(UIButton *)sender
{
    if (carDic.count==0)
    {
        [self alertOnly:@"您未选择车辆"];
        return;
        
    }
    
    if (sender==nil)
    {
        pt=100;
    }
    else
    {
        pt=(int)sender.tag;
    }
    
   
    if(pt>99)
    {
        for (UIView *subView in[tabView subviews])
        {
            if ([subView isKindOfClass:[UILabel class]])
            {
                UILabel *selectLabel = (UILabel *)[subView viewWithTag:subView.tag];
                if (subView.tag==pt)
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
        
        switch (pt)
        {
            case 100://保养
            {
                tabLine.frame = CGRectMake(0, 40, 80, 10);
                
                [ToolLen ShowWaitingView:YES];
                [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"]  type:@"0" action:@"getNoticeList"];
                
                break;
            }
            case 101://年检
            {
                tabLine.frame = CGRectMake(80, 40, 80, 10);
                
                [ToolLen ShowWaitingView:YES];
                [[self JsonFactory] getNoticeList:[carDic  objectForKey:@"carid"]  type:@"3" action:@"getNoticeList"];
                
                break;
            }
            case 102://保险
            {
                tabLine.frame = CGRectMake(80*2, 40, 80, 10);
                
                
                [ToolLen ShowWaitingView:YES];
                [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"]  type:@"2" action:@"getNoticeList"];
                
                break;
            }
            case 103://故障
            {
                tabLine.frame = CGRectMake(80*3, 40, 80, 10);
                
                [ToolLen ShowWaitingView:YES];
                [[self JsonFactory] getNoticeList:[carDic objectForKey:@"carid"]  type:@"1" action:@"getNoticeList"];
                
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
    if (pt==100 || pt==103)
    {
        return [noticeList count];
    }
    else
    {
        return [noticeList count]+1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (pt==100 || pt==103)
    {
        //动态返回信息高度
        NSString *LabelString=[NSString stringWithFormat:@"%@",[[noticeList objectAtIndex:indexPath.row] objectForKey:@"content"]];
        CGSize constraint = CGSizeMake(260.0f, 20000.0f);//自己设置的要显示的长度
        
        /*
        CGSize size = [LabelString  sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
         */
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
        CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        
        CGFloat height = MAX(size.height, 30.0f);//返回最大高度
        
        return 35+height+10;
    }
    else
    {
        if (indexPath.row==0)
        {
            return 60.0;
        }
        else
        {
            //动态返回信息高度
            NSString *LabelString=[NSString stringWithFormat:@"%@",[[noticeList objectAtIndex:indexPath.row-1] objectForKey:@"content"]];
            CGSize constraint = CGSizeMake(260.0f, 20000.0f);//自己设置的要显示的长度
            
            /*
            CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
             */
            
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
            CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            CGFloat height = MAX(size.height, 30.0f);//返回最大高度
            
            return 35+height+10;
        }
    }
   
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    if (pt==100 || pt==103)
    {
        NoticationCell *cell=(NoticationCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"NoticationCell" owner:self options:nil];
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
        
        cell.titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[noticeList objectAtIndex:indexPath.row] objectForKey:@"createTime"] substringToIndex:10],[[noticeList objectAtIndex:indexPath.row] objectForKey:@"title"]];
        
        NSString *LabelString=[NSString stringWithFormat:@"%@",[[noticeList objectAtIndex:indexPath.row] objectForKey:@"content"]];
        CGSize constraint = CGSizeMake(260.0, 20000.0f);
        /*
        CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
         */
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
        CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        CGFloat height = MAX(size.height, 30.0f);
        //NSLog(@"height::%f",height);
        cell.contentLabel.frame = CGRectMake(30,34, 260, height+10);//给label定位
        [cell.contentLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
        [cell.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
        [cell.contentLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
        [cell.contentLabel setTag:indexPath.row];
        cell.contentLabel.text=LabelString;
        
        return cell;

    }
    else
    {
        if (indexPath.row==0)
        {
            EditCell *cell=(EditCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"EditCell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            if (pt==101)
            {
                if ([[noticeDic objectForKey:@"errorcode"]intValue]==-5)
                {
                    cell.titleLabel.text=@"请输入您的车辆年检日期";
                }
                else
                {
                    cell.titleLabel.text=@"您的车辆年检到期日期";
                }
                
                cell.valueLabel.text=[noticeDic objectForKey:@"lastInspectDate"];
            }
            else
            {
                if ([[noticeDic objectForKey:@"errorcode"]intValue]==-4)
                {
                    cell.titleLabel.text=@"请输入您的车辆保险日期";
                }
                else
                {
                     cell.titleLabel.text=@"您的车辆保险到期日期";
                }
               
                cell.valueLabel.text=[noticeDic objectForKey:@"lastInsuranceDate"];
            }
            
            [cell.editButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;

        }
        else
        {
            NoticationCell *cell=(NoticationCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"NoticationCell" owner:self options:nil];
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
            
            cell.titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[noticeList objectAtIndex:indexPath.row-1] objectForKey:@"createTime"] substringToIndex:10],[[noticeList objectAtIndex:indexPath.row-1] objectForKey:@"title"]];
            
            NSString *LabelString=[NSString stringWithFormat:@"%@",[[noticeList objectAtIndex:indexPath.row-1] objectForKey:@"content"]];
            CGSize constraint = CGSizeMake(260.0, 20000.0f);
            /*
            CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
             */
            
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
            CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            CGFloat height = MAX(size.height, 30.0f);
            
            //NSLog(@"height::%f",height);
            cell.contentLabel.frame = CGRectMake(30,34, 260, height+10);//给label定位
            [cell.contentLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
            [cell.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
            [cell.contentLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
            [cell.contentLabel setTag:indexPath.row];
            cell.contentLabel.text=LabelString;
            
            return cell;

        }
        
    }
}

//编辑
-(void)edit
{
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        alertPt=0;
        [self alertNoValid];
    }
    else
    {
        alertPt=1;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请输入新的日期"
                                                      message:@"格式:2014-08-08"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert show];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertPt==1)
    {
        if (buttonIndex==1)
        {
            //得到输入框
            UITextField *tf=[alertView textFieldAtIndex:0];
            // NSLog(@"tf::%@",tf.text);
            
            if (tf.text.length==10)
            {
                // 使用NSString *strUrl = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString *tempString=[NSString stringWithFormat:@"%@-%@-%@",[[tf.text substringFromIndex:0] substringToIndex:4],[[tf.text substringFromIndex:5] substringToIndex:2],[[tf.text substringFromIndex:8] substringToIndex:2]];
                
                //tf.text=[tf.text stringByReplacingOccurrencesOfString:@"——" withString:@"-"];
                
                //NSLog(@"tempString::%@",tempString);
                
                if (tf.text.length>0 && pt==101)//年检
                {
                    
                    requestTimes=15;
                    [[self JsonFactory] changeInspectDate:tempString car:[[carDic objectForKey:@"carid"] stringValue] action:@"changeInspectDate"];
                }
                else if (tf.text.length>0 && pt==102)//保险
                {
                    requestTimes=16;
                    [[self JsonFactory]changeInsuranceDate:tempString car:[[carDic objectForKey:@"carid"] stringValue] action:@"changeInsuranceDate"];
                }
                else
                {
                    [self alertOnly:@"请输入相应日期"];
                }
                
            }
            else
            {
                [self alertOnly:@"请参照格式输入"];
            }
            
        }

    }
    else
    {
        if (buttonIndex==1)
        {
            //NSLog(@"登录");
            LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
            guide.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:guide animated:YES];
        }

    }
}

@end
