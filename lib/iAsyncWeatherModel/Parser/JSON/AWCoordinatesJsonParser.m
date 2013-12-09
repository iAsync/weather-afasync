//
//  AWCoordinatesJsonParser.m
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "AWCoordinatesJsonParser.h"

#import "AWCoordinates.h"

@implementation AWCoordinatesJsonParser

-(AWCoordinates*)parseData:( NSData* )rawData
                     error:(NSError *__autoreleasing *)outError
{
   NSError* parseError = nil;
   
   NSDictionary* jsonResult = [ NSJSONSerialization JSONObjectWithData: rawData
                                                               options: 0
                                                                 error: &parseError ];
   if ( nil == jsonResult )
   {
      [ parseError setToPointer: outError ];
      return nil;
   }
   NSParameterAssert( [ jsonResult isKindOfClass: [ NSDictionary class ] ] );
   
   AWCoordinates* result = [ AWCoordinates new ];
   {
      NSDictionary* addressItem = jsonResult[ @"results" ][0];
      
      NSDictionary* location = addressItem[@"geometry"][@"location"];
      result.latitude  = [ location[@"lat"] floatValue ];
      result.longitude = [ location[@"lng"] floatValue ];
      
      result.formattedAddress = addressItem[@"formatted_address"];
   }
   
   return result;
}

@end
