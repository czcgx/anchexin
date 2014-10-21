//
//  IllegalListViewController.m
//  AnCheXin
//
//  Created by cgx on 14-6-12.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "IllegalListViewController.h"

@interface IllegalListViewController ()

@end

@implementation IllegalListViewController
@synthesize strdic;

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
    //self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
   // NSString *str=@"{\"resultcode\":\"200\",\"reason\":\"查询成功\",\"result\":{\"province\":\"SH\",\"city\":\"SH\",\"hphm\":\"沪A520F9\",\"hpzl\":\"02\",\"lists\":[{\"date\":\"2014-05-07 08:08:00\",\"area\":\"杨高北路\\/庭安路\",\"act\":\"机动车通过有灯控路口时，不按所需行进方向驶入导向车道的\",\"code\":\"\",\"fen\":\"2\",\"money\":\"100\",\"handled\":\"0\"},{\"date\":\"2013-12-25 19:19:00\",\"area\":\"广兰路紫薇路南约20米\",\"act\":\"机动车违反规定停放、临时停车且驾驶人不在现场，妨碍其它车辆、行人通行的\",\"code\":\"\",\"fen\":\"0\",\"money\":\"200\",\"handled\":\"0\"},{\"date\":\"2014-01-16 14:53:00\",\"area\":\"张杨北路大同路北约150米\",\"act\":\"机动车违反规定停放、临时停车且驾驶人不在现场，妨碍其它车辆、行人通行的\",\"code\":\"\",\"fen\":\"0\",\"money\":\"200\",\"handled\":\"0\"}]},\"error_code\":0}";
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:[strdic dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    //NSLog(@"dic::%@",dic1);
    
    if ([[dic1 objectForKey:@"resultcode"] intValue]==200)
    {
        resultDic=[[NSDictionary alloc]initWithDictionary:[dic1 objectForKey:@"result"]];
        listFlags=[[NSMutableArray alloc] initWithCapacity:0];
        if ([[resultDic objectForKey:@"lists"] count]>0)
        {
            for (int i=0; i<[[resultDic objectForKey:@"lists"] count]; i++)
            {
                [listFlags addObject:@"1"];
            }
            
            illegalTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH,mainView.frame.size.height)];
            illegalTableView.delegate=self;
            illegalTableView.dataSource=self;
            illegalTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            [mainView addSubview:illegalTableView];

        }
        else
        {
            [self alertOnly:@"无任何违规行为,驾驶行为良好"];
        }
       
    }
    else
    {
        [self alertOnly:[dic1 objectForKey:@"reason"]];
    }
    
    [self.view addSubview:mainView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[resultDic objectForKey:@"lists"] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[listFlags objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        return 50.0;
    }
    else
    {
        return 200.0;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    IllegalCell *cell=(IllegalCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"IllegalCell" owner:self options:nil];
        
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

    
    cell.carNumberLabel.text=[resultDic objectForKey:@"hphm"];
    
    if ([[listFlags objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        cell.carDownView.hidden=YES;
    }
    else
    {
        cell.carDownView.hidden=NO;
        
        cell.carTimeLabel.text=[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"date"];
        cell.carAreaLabel.text=[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"area"];
        cell.carResaonLabel.text=[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"act"];
        if ([[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"fen"] intValue]==0)
        {
             cell.carFenLabel.text=@"无扣分";
        }
        else
        {
             cell.carFenLabel.text=[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"fen"];
        }
       
        cell.carMoneyLabel.text=[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"money"];
        
        if ([[[[resultDic objectForKey:@"lists"] objectAtIndex:indexPath.row] objectForKey:@"handled"] intValue]==0)
        {
             cell.carHandleLabel.text=@"未处理";
        }
        else
        {
            cell.carHandleLabel.text=@"已处理";
        }
        
    }
    
    cell.carClickButton.tag=indexPath.row;
    [cell.carClickButton addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)change:(UIButton *)sender
{
    //NSLog(@"sne::%d。。。listFlags：：%@",[sender tag],listFlags);
    
    if ([[listFlags objectAtIndex:[sender tag]] isEqualToString:@"0"])
    {
        [listFlags removeObjectAtIndex:[sender tag]];
        [listFlags insertObject:@"1" atIndex:[sender tag]];
    }
    else
    {
        [listFlags removeObjectAtIndex:[sender tag]];
        [listFlags insertObject:@"0" atIndex:[sender tag]];
    }
    
    NSIndexPath *path=[NSIndexPath indexPathForRow:[sender tag] inSection:0];
    [illegalTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
