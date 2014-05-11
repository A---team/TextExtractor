//
//  TextExtractorWithTests.m
//  TextExtractorWithTests
//
//  Created by Isao HARA on 2014/04/24.
//  Copyright (c) 2014年 NESW. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppUtility.h"

@interface TextExtractorWithTests : XCTestCase

@end

@implementation TextExtractorWithTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//****************************************************************
// for AppUtility - extractURLsFromText

//================================
// input: 空文字列
// output: 0個のURL文字列
- (void)testAppUtility_extractURLsFromText_00
{
    NSString *input = @"";
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 0);
}

//================================
// input: URLを含まない文字列
// output: 0個のURL文字列
- (void)testAppUtility_extractURLsFromText_01
{
    NSString *input = @"Hello, World";
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 0);
}

//================================
// input: URLだけを1つ含む文字列
// output: 指定したURL文字列(1つ)
- (void)testAppUtility_extractURLsFromText_02
{
    NSString *input = @"http://www.google.com";
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 1);
    XCTAssertEqual(output[0], input);
}

//================================
// input: URLだけを1つ含む文字列(スラッシュで終わる)
// output: 指定したURL文字列(1つ)
- (void)testAppUtility_extractURLsFromText_03
{
    NSString *input = @"https://www.google.co.jp/";
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 1);
    XCTAssertEqual(output[0], input);
}


//================================
// input: URLだけを1つ含む文字列(ファイル名で終わる)
// output: 指定したURL文字列(1つ)
- (void)testAppUtility_extractURLsFromText_04
{
    NSString *input = @"ftp://www.google.co.uk/index.html";
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 1);
    XCTAssertEqual(output[0], input);
}

//================================
// input: URLを1つ含む文字列
// output: 指定したURL文字列(1つ)
- (void)testAppUtility_extractURLsFromText_05
{
    NSString *url = @"http://www.google.com/directory/subdir/index";
    NSString *format = @"以下のURL「%@」を参照";
    NSString *input = [NSString stringWithFormat:format, url];
    NSArray *output = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(output.count, 1);
    XCTAssertEqualObjects(output[0], url);
}

//================================
// input: URLだけを複数含む文字列
// output: 指定した複数のURL文字列
- (void)testAppUtility_extractURLsFromText_06
{
    NSArray *urls = @[@"https://www.google.com/",
                      @"https://www.google.co.jp",
                      @"http://google.co.uk/index.html"];
    NSString *format = @"ここ%@か、あるいはこれ %@ か、それでも駄目なら\n%@を見ること";
    NSString *input = [NSString stringWithFormat:format, urls[0], urls[1], urls[2]];
    NSArray *outputs = [AppUtility extractURLsFromText:input];
    XCTAssertEqual(outputs.count, 3);
    XCTAssertEqualObjects(outputs[0], urls[0]);
    XCTAssertEqualObjects(outputs[1], urls[1]);
    XCTAssertEqualObjects(outputs[2], urls[2]);
}

//****************************************************************
// for AppUtility - extractURLsFromText

//================================
// input: 画像URLや画像以外のURLをいくつか含む文字列
// output: 0個の画像URL文字列
- (void)testAppUtility_extractImageURLsFromText_00
{
    NSArray *urls = @[@"http://www.google.com/dummy/strike.png",
                      @"https://google.jp/",
                      @"http://google.co.uk/dir/subdir/ball.tiff",
                      @"ftp://localhost/",
                      @"ftp://local/homerun.jpg"];
    NSString *format = @"%@か、あるいはこれ %@ か、それでも駄目なら\n%@を見ること¥nそして%@ %@";
    NSString *input = [NSString stringWithFormat:format, urls[0], urls[1], urls[2], urls[3], urls[4]];
    NSArray *outputs = [AppUtility extractImageURLsFromText:input];
    XCTAssertEqual(outputs.count, 3);
    XCTAssertEqualObjects(outputs[0], urls[0]);
    XCTAssertEqualObjects(outputs[1], urls[2]);
    XCTAssertEqualObjects(outputs[2], urls[4]);
}

@end
