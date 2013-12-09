//
//  AWWeatherJsonParser.m
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "AWWeatherJsonParser.h"

#import "AWWeatherInfo.h"

@implementation AWWeatherJsonParser

-(AWWeatherInfo*)parseData:( NSData* )rawData
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
   
   AWWeatherInfo* result = [ AWWeatherInfo new ];
   {
      NSDictionary* weatherDict = jsonResult[@"weather"][0];
      result.weatherName        = weatherDict[@"main"];
      result.weatherDescription = weatherDict[@"description"];
   }
   
   return result;
}


@end
