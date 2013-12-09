#import <JFFAsyncOperations/JFFAsyncOperations.h>
#import <Foundation/Foundation.h>

@interface AWOperationsFactory : NSObject

+(JFFAsyncOperation)asyncWeatherForAddress:( NSString* )userInput;

@end
