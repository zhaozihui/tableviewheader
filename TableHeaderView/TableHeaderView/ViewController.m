//
//  ViewController.m
//  TableHeaderView
//
//  Created by 赵子辉 on 15/11/18.
//  Copyright © 2015年 zhaozihui. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define Screenheight [[UIScreen mainScreen] bounds].size.height
#define kImageOriginHight 220
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
{
    UIImageView *headerBg;
    UIVisualEffectView *visualEffectView;
}
@synthesize tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableview.delegate = self;
    tableview.dataSource = self;
    headerBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    headerBg.frame = CGRectMake(0, 0, ScreenWidth, kImageOriginHight);
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = headerBg.bounds;
    [headerBg addSubview:visualEffectView];
    [tableview addSubview:headerBg];
    tableview.showsVerticalScrollIndicator = NO;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"zhaozihui@gmail.com";
    [tableview addSubview:title];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:showUserInfoCellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text=@"Test";
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;

    if (yOffset < 0) {
        CGRect f = headerBg.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset + kImageOriginHight;
        f.origin.x = -(f.size.height*ScreenWidth/kImageOriginHight -  ScreenWidth)/2;
        f.size.width = f.size.height*ScreenWidth/kImageOriginHight;
        headerBg.frame = f;
        visualEffectView.frame = headerBg.bounds;
    }
}
@end
