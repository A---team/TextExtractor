//
//  HITextViewsViewController.m
//  TextExtractorPlease
//
//  Created by Isao HARA on 2014/04/21.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import "HITextViewsViewController.h"

@interface HITextViewsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputText;
- (IBAction)postMessage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *outputTextA;
@property (weak, nonatomic) IBOutlet UITextView *outputTextB;
@property (weak, nonatomic) IBOutlet UITextView *outputTextC;
@property (weak, nonatomic) IBOutlet UITextView *outputTextD;
- (IBAction)tapped:(UITapGestureRecognizer *)sender;

@end

@implementation HITextViewsViewController

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

- (IBAction)done:(UIButton *)sender {
    [self.delegate hiTextViewsViewControllerDidFinish:self];
}
- (IBAction)postMessage:(UIButton *)sender {
    _outputTextA.text = _inputText.text;
    _outputTextB.text = _inputText.text;
    _outputTextC.text = _inputText.text;
    _outputTextD.text = _inputText.text;
}
- (IBAction)tapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
@end
