//
//  ViewController.m
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/04/24.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "ViewController.h"
#import "AppUtility.h"
#import "CellView.h"
#import "TableViewConst.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *source;        // 入力領域
@property (weak, nonatomic) IBOutlet UIView *contents; // 出力領域 imageView と textView をセットにしたCellクラスを利用するためこちらを利用しています。
@property (weak, nonatomic) IBOutlet UITableView *contentsTable; // 出力領域 CustomCell
@property NSMutableArray *cells; // TableViewのデータ格納用

- (IBAction)submit:(UIButton *)sender;                  // [Submit]ボタンをタップ
- (IBAction)bkgTapped:(UITapGestureRecognizer *)sender; // 背景部分をタップ

- (NSArray *)extractImageURLs;  // 投稿内容から画像URLを(文字列の配列として)抽出

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
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *tablecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (tablecell == nil) {
        tablecell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    
    return (int)height
    ;
}

//****************************************************************
// [Submit]ボタンをタップ
- (IBAction)submit:(UIButton *)sender
{
    //入力領域をクリア
    for (UIView *view in [_contents subviews]) {
        [view removeFromSuperview];
    }
    
    //データ取得
    NSArray *imageArray = [self loadImageData];

    //出力コンテンツの生成
    CellView *cellView = [[CellView alloc] initWithFrame:CGRectMake(0, 0, 280, 150)
                                withImage:((imageArray.count > 0) ? [imageArray objectAtIndex:0] : nil)
                                withText:self.source.text displayType:YES];

    //出力領域に描画
    [_contents addSubview:cellView];
    
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

    //領域をクリア
    for (UIView *view in [_contents subviews]) {
        [view removeFromSuperview];
    }

    //出力コンテンツの生成
    CellView *cellView = [[CellView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)
                                               withImage:nil
                                                withText:self.source.text displayType:YES];

    //出力領域に描画
    [_contents addSubview:cellView];
}

#pragma mark - Inner Method

//****************************************************************
// 投稿内容から画像URLを(文字列の配列として)抽出
- (NSArray *)extractImageURLs
{
    NSString *text = self.source.text;
    NSArray *urls = [AppUtility extractImageURLsFromText:text];
    return urls;
}

//****************************************************************
// URLからデータを取得し、取得したデータ配列を返却する
// 今回の例では先頭の1つしか画像は利用しないため１つ詰めると終了する。
// 本当は複数個でたり、エラーが発生した場合は次のURL取得をし成功した最初の1つを返す、などの実装が必要
- (NSMutableArray *)loadImageData
{
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray *urlArray = [self extractImageURLs];
    for (int i=0; i < urlArray.count; i++) {
        NSData *dt = [NSData dataWithContentsOfURL: [NSURL URLWithString:[urlArray objectAtIndex:i]]];
        [muArray addObject:[[UIImage alloc] initWithData:dt]];
        break; // 現状は１つ詰めると抜ける
    }
    return muArray;
}

@end
