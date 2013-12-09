//
//  iAsyncWeatherModelTests.m
//  iAsyncWeatherModelTests
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "iAsyncWeatherModel.h"
#import "AWCoordinatesJsonParser.h"
#import "AWWeatherJsonParser.h"

#import <XCTest/XCTest.h>

static const float LOCATION_ACCURACY = 0.00001f;

@interface iAsyncWeatherModelTests : XCTestCase

@end

@implementation iAsyncWeatherModelTests
{
   NSBundle* _testBundle;
}


-(void)setUp
{
    [super setUp];

   self->_testBundle = [ NSBundle bundleForClass: [ self class ] ];
}

-(void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(NSData*)getJsonFromFile:( NSString* )fileName
{
   NSString* jsonPath = [ self->_testBundle pathForResource: fileName
                                                     ofType: @"json" ];
   return [ NSData dataWithContentsOfFile: jsonPath ];
}

-(void)testValidLocationParser_JSON
{
   NSData* jsonData = [ self getJsonFromFile: @"1-location-valid" ];
   XCTAssertNotNil( jsonData, @"resourse not loaded" );
   
   AWCoordinates* result = nil;
   AWCoordinatesJsonParser* parser = [ AWCoordinatesJsonParser new ];
   NSError* parseError = nil;
   
   result = [ parser parseData: jsonData
                         error: &parseError ];
   
   XCTAssertNil( parseError, @"unexpected error" );
   XCTAssertNotNil( result, @"unable to parse json" );
   
   XCTAssertEqualWithAccuracy( result.latitude, 48.464717f, LOCATION_ACCURACY, @"latitude mismatch" );
   XCTAssertEqualWithAccuracy( result.longitude, 35.046183, LOCATION_ACCURACY, @"latitude mismatch" );
   
   XCTAssertEqualObjects(result.formattedAddress, @"Dnipropetrovs'k, Dnipropetrovsk Oblast, Ukraine", @"address mismatch" );
}

-(void)testValidWeahterInfoParser_JSON
{
   NSData* jsonData = [ self getJsonFromFile: @"2-weather-valid" ];
   XCTAssertNotNil( jsonData, @"resourse not loaded" );
   
   AWWeatherInfo* result = nil;
   AWWeatherJsonParser* parser = [ AWWeatherJsonParser new ];
   NSError* parseError = nil;
   
   result = [ parser parseData: jsonData
                         error: &parseError ];
   
   XCTAssertNil( parseError, @"unexpected error" );
   XCTAssertNotNil( result, @"unable to parse json" );
   
   
   XCTAssertEqualObjects(result.weatherName, @"Rain", @"weather name mismatch" );
   XCTAssertEqualObjects(result.weatherDescription, @"light rain", @"weather details mismatch" );
}


@end
