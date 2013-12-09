//
//  AWOperationsFactory.m
//  iAsyncWeatherOperations
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "AWOperationsFactory.h"

#import "AWUrlBuilder.h"

@implementation AWOperationsFactory

//dataURLResponseLoader

+(JFFAsyncOperation)asyncWeatherForAddress:( NSString* )userInput
{
   return bindSequenceOfAsyncOperationsArray
   (
      [ self asyncLocationForAddress: userInput ],
     @[
         [ self parseRawAddressBinder ],
         [ self getWeatherBinder      ],
         [ self parseWeatherBinder    ]
      ]
   );
}


#pragma mark -
#pragma mark private
+(NSError*)badUrlError
{
   NSDictionary* userInfo = @{ NSLocalizedDescriptionKey : @"bad url" };
   NSError* badUrlError = [ [ NSError alloc ] initWithDomain: @"iAsync demo"
                                                        code: 1
                                                    userInfo: userInfo ];
   
   return badUrlError;
}

+(JFFAsyncOperation)asyncLocationForAddress:( NSString* )userInput
{
   NSString* requestUrlString = [ AWUrlBuilder locationGetterForAddress: userInput ];
   NSURL* requestUrl = [ NSURL URLWithString: requestUrlString ];

   if ( nil == requestUrl )
   {
      return asyncOperationWithError( [ self badUrlError ] );
   }
   
   NSData*       postData = nil;
   NSDictionary* headers  = nil;
   JFFAsyncOperation result = dataURLResponseLoader( requestUrl, postData, headers );
   
   return [ result copy ];
}

+(JFFAsyncOperationBinder)parseRawAddressBinder
{
   JFFAsyncOperationBinder result = ^JFFAsyncOperation( NSData* jsonLocation )
   {
      JFFSyncOperation parser = ^AWCoordinates*( NSError** parseError )
      {
         id<AWCoordinatesParser> parser = [ AWParserFactory jsonCoordinatesParser ];
         return [ parser parseData: jsonLocation
                             error: parseError ];
      };
      
      JFFAsyncOperation asyncParse = asyncOperationWithSyncOperation( parser );
      return [ asyncParse copy ];
   };

   return [ result copy ];
}

+(JFFAsyncOperationBinder)getWeatherBinder
{
   JFFAsyncOperationBinder result = ^JFFAsyncOperation( id rawCoordinates )
   {
      AWCoordinates* coordinates = objc_member_of_cast<AWCoordinates>( rawCoordinates );
      
      NSString* urlString = [ AWUrlBuilder weatherGetterForCoordinates: coordinates ];
      NSURL* requestUrl = [ NSURL URLWithString: urlString ];
      if ( nil == requestUrl )
      {
         return asyncOperationWithError( [ self badUrlError ] );
      }
      
      
      NSData*       postData = nil;
      NSDictionary* headers  = nil;
      JFFAsyncOperation loader = dataURLResponseLoader( requestUrl, postData, headers );
      
      
      JFFChangedResultBuilder resultHook = ^NSDictionary*(NSData* weatherJson)
      {
         return @{ @"location" : coordinates, @"rawWeather" : weatherJson };
      };

      JFFAsyncOperation hookedLoader = asyncOperationWithChangedResult( loader, resultHook );
      
      return [ hookedLoader copy ];
   };
   
   return [ result copy ];
}

+(JFFAsyncOperationBinder)parseWeatherBinder
{
   JFFAsyncOperationBinder result = ^JFFAsyncOperation( NSDictionary* rawWeatherInfo )
   {
      AWCoordinates* location = rawWeatherInfo[ @"location" ];
      NSData* weatherJson = rawWeatherInfo[ @"rawWeather" ];
      id<AWWeatherParser> parser = [ AWParserFactory jsonWeatherParser ];
      
      JFFSyncOperation parseWeather = ^AWWeatherInLocation*( NSError** parseError )
      {
         AWWeatherInfo* weather = [ parser parseData: weatherJson
                                               error: parseError ];
         if ( nil == weather )
         {
            return nil;
         }
         
         
         AWWeatherInLocation* parseResult = [ AWWeatherInLocation new ];
         {
            parseResult.weather  = weather;
            parseResult.location = location;
         }
         
         return parseResult;
      };
      
      JFFAsyncOperation asyncParse = asyncOperationWithSyncOperation( parseWeather );
      return [ asyncParse copy ];
   };
   
   return [ result copy ];
}

@end
