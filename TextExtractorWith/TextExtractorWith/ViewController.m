//
//  ViewController.m
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/04/24.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "ViewController.h"
#import "AppUtility.h"
#import "TableViewConst.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *source;        // 入力領域
@property (weak, nonatomic) IBOutlet UITableView *contentsTable; // 出力領域 CustomCell
@property NSMutableArray *cells; // TableViewのデータ格納用

- (IBAction)submit:(UIButton *)sender;                  // [Submit]ボタンをタップ
- (IBAction)bkgTapped:(UITapGestureRecognizer *)sender; // 背景部分をタップ


// プリセット文字列を入力領域にセット(デモ用)
- (IBAction)presetA:(UIButton *)sender;
- (IBAction)presetB:(UIButton *)sender;
- (IBAction)presetC:(UIButton *)sender;
- (IBAction)presetD:(UIButton *)sender;
- (IBAction)presetE:(UIButton *)sender;

@end

@implementation ViewController

//****************************************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // カスタマイズしたセルをテーブルビューにセット
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [_contentsTable registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    //TableViewの再描画
    _contentsTable.delegate = self;
    _contentsTable.dataSource = self;
    self.cells = [NSMutableArray array];
}

//****************************************************************
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

//****************************************************************
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
    NSLog(@"cellForRowAtIndexPath");

    // Cell の取得
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *tablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tablecell == nil) {
        tablecell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // アバター画像の設定
    tablecell.cellImage.image = [UIImage imageNamed:@"inu.jpg"];
    // テキスト設定
    tablecell.celltextview.text = [self.cells objectAtIndex:indexPath.row];
    
    return tablecell;
}

//各セルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"heightForRowAtIndexPath");
    
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *tablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tablecell == nil) {
        tablecell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //入力された文字の仮想のフィールドに展開して、必要な高さの算出
    UIFont* font = [UIFont systemFontOfSize:tablecell.celltextview.font.pointSize];
    CGSize size = CGSizeMake(tablecell.celltextview.frame.size.width, 900);
    CGSize textSize = [[self.cells objectAtIndex:indexPath.row] sizeWithFont:font constrainedToSize:size lineBreakMode: NSLineBreakByCharWrapping];

    float height = tablecell.getOriginalFrame.size.height; // セルの最低限の高さ
    //TextViewの余白の関係上必要な算出したheightに+20してから、必要なheightの計算
    float h = textSize.height + 20 - height;
    if (h > 0) {
        height += h;
    }

    // 表示する画像URLが1つ委譲あれば表示領域を確保する（取得に失敗した場合は後で縮めることができればよいがだめなら失敗した旨の通知）
    NSArray *imgUrl = [AppUtility extractImageURLsFromText:[self.cells objectAtIndex:indexPath.row]];
    height += ((imgUrl.count > 0) ? 50 : 0);
    
    return (int)height;
}

//****************************************************************
// [Submit]ボタンをタップ
- (IBAction)submit:(UIButton *)sender
{
    //UITableViewのデータに追加、再描画
    [self.cells addObject:_source.text];
    [_contentsTable reloadData];
}

//****************************************************************
// 背景部分をタップ
- (IBAction)bkgTapped:(UITapGestureRecognizer *)sender
{
    // キーボードを引っ込める
    [self.view endEditing:YES];
}

//****************************************************************
// プリセット文字列を入力領域にセット(デモ用)
- (IBAction)presetA:(UIButton *)sender
{
    self.source.text = @"Our company's URL is http://www.nec-solutioninnovators.co.jp and the phone number is 03-5534-2222";
}

- (IBAction)presetB:(UIButton *)sender
{
    self.source.text = @"つぎを参照してくださいhttp://www.apple.com/\n（画像：https://www.apple.com/jp/iphone-5s/home/images/ilife_hero.jpg）";
}

- (IBAction)presetC:(UIButton *)sender
{
    self.source.text = @"https://www.apple.com/jp/iphone-5s/home/images/routing_hero.png";
}

- (IBAction)presetD:(UIButton *)sender
{
    self.source.text = @"https://www.apple.com/jp/iphone-5s/home/images/hero_hero_mba_11.png";
}

- (IBAction)presetE:(UIButton *)sender
{
    self.source.text = @"";

}

@end
