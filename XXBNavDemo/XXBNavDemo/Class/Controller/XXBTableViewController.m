//
//  XXBTableViewController.m
//  XXBNavDemo
//
//  Created by xiaobing on 15/10/13.
//  Copyright © 2015年 xiaobing. All rights reserved.
//

#import "XXBTableViewController.h"
#import <XXBLibs.h>
#import "XXBViewController.h"

@interface XXBTableViewController ()

@end

@implementation XXBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor myRandomColor];
    cell.accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    cell.accessoryView.backgroundColor = [UIColor myRandomColor];
    cell.alpha = 0.3;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[XXBViewController new] animated:YES];
}
@end
