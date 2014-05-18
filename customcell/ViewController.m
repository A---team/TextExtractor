//
//  ViewController.m
//  cellcustom
//
//  Created by necst on 2014/05/17.
//  Copyright (c) 2014年 necst. All rights reserved.
//

#import "ViewController.h"
#import "TableViewConst.h"
#import "CustomTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
- (IBAction)clickButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *outputTableView;
- (IBAction)tapScreen:(id)sender;

@property NSMutableArray *cells;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // カスタマイズしたセルをテーブルビューにセット
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [_outputTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    //TableViewの再描画
    _outputTableView.delegate = self;
    _outputTableView.dataSource = self;
    self.cells = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//テーブルのセクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//セクションのタイトル
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Sample";
}
//各セクションのセル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cells count];
}
//各セルの表示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *tablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tablecell == nil) {
        tablecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    tablecell.cellImage.image = [UIImage imageNamed:@"inu.jpg"];
    tablecell.celltextview.text = [self.cells objectAtIndex:indexPath.row];
    
    return tablecell;
}

//各セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *tablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tablecell == nil) {
        tablecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //入力された文字の仮想のフィールドに展開して、必要な高さの算出
    UIFont* font = [UIFont systemFontOfSize:14.0];
    CGSize size = CGSizeMake(tablecell.celltextview.frame.size.width, 900);
    CGSize textSize = [[self.cells objectAtIndex:indexPath.row] sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
    
    
    float height = 50.0f; // セルの最低限の高さ
    //TextViewの余白の関係上必要な算出したheightに+20してから、必要なheightの計算
    float h = textSize.height + 20 - height;
    if (h > 0) {
        height += h;
    }
    
    NSLog(@"---------------------");
    NSLog(@"%@:%f -%f",[self.cells objectAtIndex:indexPath.row],textSize.height,height);
    return (int)height
    ;
}

- (IBAction)tapScreen:(id)sender {
    //keyboradのクローズ
    [self.view endEditing:YES];
}

- (IBAction)clickButton:(id)sender {
    //tableViewの更新
    [self.cells addObject:_inputTextView.text];
    [_outputTableView reloadData];
}

@end
