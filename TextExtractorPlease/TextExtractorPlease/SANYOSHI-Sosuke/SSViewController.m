//
//  SSViewController.m
//  TextExtractorPlease
//
//  Created by Isao HARA on 2014/04/13.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController (){
    NSString *beforeString;
}
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
    beforeString =@"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ssChangeSwitch:(UISwitch *)sender {
    _ssTextView.editable = sender.on;
    
    if (sender.on) {
        _ssTextView.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1];
        //編集時に青文字にしないため(原因・解決理由不明)
        _ssTextView.text = _ssTextView.text;

    }else{
        _ssTextView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        //確定時に青文字にするため(原因・解決理由不明)
        if (![_ssTextView.text isEqualToString:beforeString]) {
            NSLog(@"test");
            beforeString = _ssTextView.text;
            _ssTextView.text = _ssTextView.text;
        }
    }
    
    
}

- (IBAction)tapScreen:(id)sender {
    [self.view endEditing:YES];    
}
@end
