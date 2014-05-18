//
//  TableViewController.m
//  TextExtractorWith
//
//  Created by 石井賢二 on 2014/05/14.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "TableViewController.h"
#import <AFNetworking.h>
#import "CellView.h"
#import "TableViewCell.h"

@interface TableViewController ()
{
    NSArray *urlArray;
    NSMutableArray *cellList;
    int random;;
}
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    // ナビゲーションバーの左側にEditボタンを設定する
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // ＋ボタンを作る
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    // ナビゲーションバーの右側に＋ボタンを設定する
    self.navigationItem.rightBarButtonItem = addButton;
    
    // 配列
    urlArray = [NSArray array];
    urlArray = @[@"https://www.apple.com/jp/iphone-5s/home/images/hero_hero_mba_11.png",
                 @"https://www.apple.com/jp/iphone-5s/home/images/routing_hero.png",
                 @"https://www.apple.com/jp/iphone-5s/home/images/ilife_hero.jpg"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!cellList) {
        cellList = [[NSMutableArray alloc] init];
    }
    //[cellList insertObject:[NSDate date] atIndex:0];
    [cellList insertObject:urlArray[random%3] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    random++;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return cellList.count;
}

// 選ばれたシーンへ移動する
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *contents = cellList[indexPath.row];
    
    // 下記の処理も全部カスタムクラスでやればよい気がする
    // イメージの取得＆表示
    [cell downloadThumbnail:contents];
    
    // ラベルのセット
    cell.textLabel.text = contents;
    cell.titleLabel.text = @"custom string...";

    // セルのアクセサリタイプ( > を表示する)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
