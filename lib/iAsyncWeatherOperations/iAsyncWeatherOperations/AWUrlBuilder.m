//
//  AWUrlBuilder.m
//  iAsyncWeatherOperations
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "AWUrlBuilder.h"

@implementation AWUrlBuilder

+(NSString*)urlEscapeAddress:( NSString* )address
{
   NSString* result = [ address stringByReplacingOccurrencesOfString: @" "
                                                          withString: @"+" ];
   return result;
}

+(NSString*)locationGetterForAddress:( NSString* )address
{
   NSString* escapedAddress = [ self urlEscapeAddress: address ];
   static NSString* const requestUrlBase = @"http://maps.googleapis.com/maps/api/geocode/json?sensor=true&address=";
   
   NSString* result = [ requestUrlBase stringByAppendingString: escapedAddress ];
   return result;
}

+(NSString*)weatherGetterForCoordinates:( AWCoordinates* )coordinates
{
   // TODO : fix locale issues with float formatting
   
   NSString* urlFormat = @"http://api.openweathermap.org/data/2.5/weather?lat=%1.2f&lon=%1.2f";
   NSString* result = [ NSString stringWithFormat: urlFormat, coordinates.latitude, coordinates.longitude ];
   
   return result;
}

@end
