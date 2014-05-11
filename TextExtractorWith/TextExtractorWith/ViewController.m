//
//  ViewController.m
//  TextExtractorWith
//
//  Created by Isao HARA on 2014/04/24.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "ViewController.h"
#import "AppUtility.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *source;        // 入力領域
@property (weak, nonatomic) IBOutlet UITextView *expression;    // 出力領域
- (IBAction)submit:(UIButton *)sender;                   // [Submit]ボタンをタップ
- (IBAction)bkgTapped:(UITapGestureRecognizer *)sender;  // 背景部分をタップ

- (NSArray *)extractURLfromExpression;  // 出力領域からURLを(文字列の配列で)抽出

@end

@implementation ViewController

//****************************************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//****************************************************************
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

//****************************************************************
// [Submit]ボタンをタップ
- (IBAction)submit:(UIButton *)sender
{
    // 入力領域の文字列を出力領域へ表示
    self.expression.text = self.source.text;
}

//****************************************************************
// 背景部分をタップ
- (IBAction)bkgTapped:(UITapGestureRecognizer *)sender
{
    // キーボードを引っ込める
    [self.view endEditing:YES];

    //
    NSArray *urls = [self extractURLfromExpression];
    for (NSString *url in urls) {
        NSLog(@"url[%@]", url);
    }
}

#pragma mark - Inner Method

//****************************************************************
// 出力領域からURLを(文字列の配列で)抽出
- (NSArray *)extractURLfromExpression
{
    NSString *text = self.expression.text;
    NSArray *urls = [AppUtility extractURLFromText:text];
    return urls;
}

@end
