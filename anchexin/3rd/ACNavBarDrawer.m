//
//  ACNavBarDrawer.m
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "ACNavBarDrawer.h"

#define ACNavBarDrawer_Height       300.f
#define ACNavBarDrawer_Duration     0.8f

#define Color [UIColor colorWithRed:0/256.0 green:155/256.0 blue:209/256.0 alpha:1.0]

@interface ACNavBarDrawer ()
{
    /** 背景遮罩 */
    UIControl    *_mask;
}

@end


@implementation ACNavBarDrawer


#pragma mark - Action Method
-(void)maskTapped
{
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
        
        self.frame=CGRectMake(0, 480+(iPhone5?88:0), WIDTH, 480+(iPhone5?88:0));
    }];
    
}




-(id)initView
{
    self = [super init];
    if (self)
    {
        self.frame=CGRectMake(0, 480+(iPhone5?88:0), WIDTH, 480+(iPhone5?88:0));
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:self.bounds];
        image.image=IMAGE(@"rootbg");
        [self addSubview:image];
        
        _mask = [[UIControl alloc] initWithFrame:self.bounds];
        [_mask setBackgroundColor:[UIColor clearColor]];
        [_mask addTarget:self action:@selector(maskTapped) forControlEvents:UIControlEventTouchUpInside];
        [_mask setAlpha:0.6f];
        [self addSubview:_mask];
    }
    
    return self;
}

-(void)initTableView:(NSString *)str
{
    if ([str isEqualToString:@"no"])
    {
        if (selectedIndex==3)
        {
            //通用标签
            ACNTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,300, WIDTH, 480+(iPhone5?88:0)-300)];
        }
        else
        {
            //通用标签
            ACNTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,200, WIDTH, 480+(iPhone5?88:0)-200)];
        }
       
    }
    else
    {
        //通用标签
        ACNTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,200, WIDTH, 480+(iPhone5?88:0)-200-48)];
    }
  
    ACNTableView.delegate=self;
    ACNTableView.dataSource=self;
    ACNTableView.backgroundView=nil;
    ACNTableView.backgroundColor=[UIColor clearColor];
    ACNTableView.separatorColor=[UIColor darkGrayColor];
    [self addSubview:ACNTableView];
    
}


- (void)openNavBarDrawer:(int)index Parameters:(id)Parameters defaultValue:(id)defaultValue
{
    selectedIndex=index;
    defaultStr=defaultValue;
    
    arr=[[NSArray alloc] initWithArray:Parameters];
    [ACNTableView removeFromSuperview];
    [self initTableView:defaultValue];
    
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
            self.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
    }];
}


- (void)closeNavBarDrawer
{
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
        self.frame=CGRectMake(0, 480+(iPhone5?88:0), WIDTH, 480+(iPhone5?88:0));
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiner];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
       
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (selectedIndex==3)
    {
        if([[arr objectAtIndex:indexPath.row]isEqualToString:defaultStr])
        {
            cell.backgroundColor=kUIColorFromRGB(0x1c1c1c);
        }
        else
        {
            cell.backgroundColor=kUIColorFromRGB(0x222222);
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.text=[arr objectAtIndex:indexPath.row];
    }
    else
    {
        if([[[arr objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:defaultStr])
        {
            cell.backgroundColor=kUIColorFromRGB(0x1c1c1c);
        }
        else
        {
            cell.backgroundColor=kUIColorFromRGB(0x222222);
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:15.0];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.text=[[arr objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    
    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(theBtnPressed:sort:)])
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.frame=CGRectMake(0, 480+(iPhone5?88:0), WIDTH, 480+(iPhone5?88:0));
        }completion:^(BOOL finished) {
            
            if (selectedIndex==1 || selectedIndex==2)
            {
                 [_delegate theBtnPressed:[[arr objectAtIndex:indexPath.row] objectForKey:@"name"] sort:selectedIndex];
            }
            else
            {
                [_delegate theBtnPressed:[arr objectAtIndex:indexPath.row] sort:selectedIndex];
            }

        }];
    }
    
    
}



@end
