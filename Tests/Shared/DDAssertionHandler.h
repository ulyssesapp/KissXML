//
//  DDAssertionHandler.h
//  KissXMLTests
//
//  Shared assertion handler used to suppress assertion logging while testing
//  that the library throws the expected exceptions on bad input.
//

#import <Foundation/Foundation.h>

@interface DDAssertionHandler : NSAssertionHandler
{
    BOOL shouldLogAssertionFailure;
}

@property (nonatomic, readwrite, assign) BOOL shouldLogAssertionFailure;

@end
