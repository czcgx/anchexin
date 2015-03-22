//
//  ProductPackageViewController.m
//  anchexin
//
//  Created by cgx on 14-12-11.
//
//

#import "ProductPackageViewController.h"

@interface ProductPackageViewController ()

@end

@implementation ProductPackageViewController
@synthesize stationInfo;
@synthesize chooseArray;
@synthesize serviceListArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //NSLog(@"chooseArray::%@",chooseArray);
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    
    
    productMutableArray=[[NSArray alloc] initWithArray:serviceListArray];
    //NSLog(@"productMutableArray::%@",productMutableArray);
    selectedArray=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<productMutableArray.count; i++)
    {
        if (chooseArray)
        {
            int p=0;
            for (int j=0; j<chooseArray.count; j++)
            {
                if ([[[productMutableArray objectAtIndex:i] objectForKey:@"code"] isEqualToString:[[chooseArray objectAtIndex:j] objectForKey:@"code"]])
                {
                    
                    p=1;
                    break;
                    
                }
            }
            
            if (p==0)
            {
                [selectedArray addObject:@"0"];
            }
            else
            {
                [selectedArray addObject:@"1"];
            }
        }
        else
        {
            [selectedArray addObject:@"0"];
        }
    }
    
    //NSLog(@"selectedArray::%@",selectedArray);
    
    productTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height)];
    //productTableView.tag=1;
    productTableView.delegate=self;
    productTableView.dataSource=self;
    productTableView.backgroundView=nil;
    productTableView.backgroundColor=[UIColor clearColor];
    productTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //shopTableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [mainView addSubview:productTableView];
    
    [self.view addSubview:mainView];

    //[productTableView reloadData];
    
    
    /*
    [ToolLen ShowWaitingView:YES];
    [[self JsonFactory] getNewServiceListByStation:[stationInfo objectForKey:@"repairstationid"]  action:@"getNewServiceListByStation"];
     */
    
    
}

/*
-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        //receiveDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        
        productMutableArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"serviceList"]];
        NSLog(@"productMutableArray::%@",productMutableArray);
        selectedArray=[[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<productMutableArray.count; i++)
        {
            if (chooseArray)
            {
                int p=0;
                for (int j=0; j<chooseArray.count; j++)
                {
                    if ([[[productMutableArray objectAtIndex:i] objectForKey:@"code"] isEqualToString:[[chooseArray objectAtIndex:j] objectForKey:@"code"]])
                    {
                        
                        p=1;
                        break;
                        
                    }
                }
                
                if (p==0)
                {
                    [selectedArray addObject:@"0"];
                }
                else
                {
                    [selectedArray addObject:@"1"];
                }
            }
            else
            {
                [selectedArray addObject:@"0"];
            }
        }
        
        [productTableView reloadData];
        
    }

}
 */



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productMutableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger n=[[[productMutableArray objectAtIndex:indexPath.row]objectForKey:@"partList"] count];
    
    return  n*100+50;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    subView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    UILabel *line1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    line1.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [subView addSubview:line1];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.text=@"价格";
    nameLabel.font=[UIFont systemFontOfSize:14.0];
    nameLabel.textColor=[UIColor blackColor];
    [subView addSubview:nameLabel];
    
    totalLabel=[[UILabel alloc] initWithFrame:CGRectMake(200, 15, 100, 20)];
    totalLabel.backgroundColor=[UIColor clearColor];
    totalLabel.textAlignment=NSTextAlignmentRight;
    if (chooseArray)
    {
        int total=0;
        for (int i=0; i<[chooseArray count]; i++)
        {
            //计算总价格
            total=total+[[[chooseArray objectAtIndex:i]objectForKey:@"price"]intValue];
        }
        
        totalLabel.text=[NSString stringWithFormat:@"%d 元",total];
    }
    else
    {
        totalLabel.text=@"";
    }
    totalLabel.font=[UIFont systemFontOfSize:14.0];
    totalLabel.textColor=[UIColor blackColor];
    [subView addSubview:totalLabel];
    /*
    UILabel *line2=[[UILabel alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
    line2.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [subView addSubview:line2];
    */
    
    return subView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIndefiner=@"cellProduct";
    ProductPackageCell *cell=(ProductPackageCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ProductPackageCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    //cell.contentView.backgroundColor=[UIColor greenColor];
    //是否选择套餐
    if ([[selectedArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        cell.selectedImg.image=IMAGE(@"unselected");
    }
    else
    {
        cell.selectedImg.image=IMAGE(@"selected");
    }
    
    //产品名称
    cell.productNameLabel.text=[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    if ([[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"nameExtend"] length]>0)
    {
        cell.detailLabel.hidden=NO;
        cell.detailLabel.text=[NSString stringWithFormat:@"(%@)",[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"nameExtend"] ];
    }
    else
    {
        cell.detailLabel.hidden=YES;
    }
    

    cell.desLabel.text=[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    /*
    if ([[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"经济套餐"])
    {
        cell.desLabel.text=@"高性价比，推荐15万以下家用车型使用";
    }
    else if ([[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"高级套餐"])
    {
        cell.desLabel.text=@"合成机油技术，推荐10-25万中高档车型使用";
    }
    else if ([[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"豪华套餐"])
    {
        cell.desLabel.text=@"全合成机油技术，推荐20万以上高档车型使用";
    }
    else
    {
        cell.desLabel.text=@"由于车型不同，价格有所差异，请事先致电与店家沟通确认";

    }
     */
    //产品价格
    cell.productPriceLabel.text=[NSString stringWithFormat:@"%@ %@",[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"price"],[[productMutableArray objectAtIndex:indexPath.row] objectForKey:@"unit"]];;
    

    NSArray *temp=[[productMutableArray objectAtIndex:indexPath.row]objectForKey:@"partList"];
    
    NSInteger n=[temp count];

    if (n==0)
    {
       cell.downLineLabel.hidden=YES;
    }
    else
    {
        cell.downView.frame=CGRectMake(0, 50,WIDTH,100*n);
        for (int i=0; i<n; i++)
        {
            UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, i*100, WIDTH, 100)];
            subView.backgroundColor=[UIColor clearColor];
            
            UIImageView *cusImg=[self customImageView:CGRectMake(20, 10, 100, 60) image:nil];
            //[cusImg setImageWithURL:[NSURL URLWithString:[[temp objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
            [cusImg sd_setImageWithURL:[NSURL URLWithString:[[temp objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
            //[cusImg setImage:[UIImage imageNamed:@"huang.jpg"]];
            [subView addSubview:cusImg];
            
            UILabel *nameLabel=[self customLabel:CGRectMake(20, 75, 100, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"name"] alignment:0 font:11.0];
            nameLabel.numberOfLines=0;
            [subView addSubview:nameLabel];
            
            
            UILabel *des1Label=[self customLabel:CGRectMake(130, 10, 180, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"brand"] alignment:-1 font:11.0];
            des1Label.numberOfLines=1;
            [subView addSubview:des1Label];
            
            UILabel *des2Label=[self customLabel:CGRectMake(130, 30, 180, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"descriptionPart01"] alignment:-1 font:11.0];
            des2Label.numberOfLines=1;
            [subView addSubview:des2Label];
            
            UILabel *des3Label=[self customLabel:CGRectMake(130, 40, 180, 60) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"descriptionPart02"] alignment:-1 font:11.0];
            des3Label.numberOfLines=3;
            [subView addSubview:des3Label];
            
            UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 99, WIDTH-40, 1)];
            lineLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
            [subView addSubview:lineLabel];
            
            if (i==n-1)
            {
                lineLabel.hidden=YES;
            }
            else
            {
                lineLabel.hidden=NO;
            }
            
            [cell.downView addSubview:subView];
        }

    }

    cell.selectedBtn.tag=indexPath.row;
    [cell.selectedBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


-(void)selectedBtn:(UIButton *)sender
{
    if ([[selectedArray objectAtIndex:sender.tag]isEqualToString:@"0"])
    {
        [selectedArray removeObjectAtIndex:sender.tag];
        [selectedArray insertObject:@"1" atIndex:sender.tag];
    }
    else
    {
        [selectedArray removeObjectAtIndex:sender.tag];
        [selectedArray insertObject:@"0" atIndex:sender.tag];
    }
    
    
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    [productTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSMutableArray *choose=[[NSMutableArray alloc] init];
    int total=0;
    for (int i=0; i<[selectedArray count]; i++)
    {
        if ([[selectedArray objectAtIndex:i] isEqualToString:@"1"])
        {
            [choose addObject:[productMutableArray objectAtIndex:i]];
            
            //计算总价格
            total=total+[[[productMutableArray objectAtIndex:i]objectForKey:@"price"]intValue];
            
            
        }
        
    }
    
    totalLabel.text=[NSString stringWithFormat:@"%d 元",total];
    //触发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProduct" object:choose];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
