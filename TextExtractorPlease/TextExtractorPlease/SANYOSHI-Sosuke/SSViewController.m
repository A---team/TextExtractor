//
//  SSViewController.m
//  TextExtractorPlease
//
//  Created by Isao HARA on 2014/04/13.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ssTextView;
//@property (weak, nonatomic) IBOutlet UITextView *ssSampleView;
@property (weak, nonatomic) IBOutlet UISwitch *ssSwitch;
- (IBAction)ssChangeSwitch:(UISwitch *)sender;
- (IBAction)tapScreen:(id)sender;

@end

@implementation SSViewController

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
    
    //改行時に先頭がアルファベットのときに大文字になるのを抑制
    _ssTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    _ssSampleView.text = @"郵便番号：731-3168\n電話番号：0828492648\n参考URL：\nhttps://www.google.co.jp/\nhttps://www.apple.com/jp/";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)ssChangeSwitch:(UISwitch *)sender {
    [_ssTextView setEditable:sender.on];
    if (sender.on) {
        _ssTextView.textColor = [UIColor blackColor];
        _ssTextView.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1];
    }else{
        _ssTextView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_ssTextView reloadInputViews];

    }
}

- (IBAction)tapScreen:(id)sender {
    [self.view endEditing:YES];    
}
@end
