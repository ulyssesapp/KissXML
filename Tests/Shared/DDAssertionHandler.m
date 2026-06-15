//
//  DDAssertionHandler.m
//  KissXMLTests
//
//  Shared assertion handler used to suppress assertion logging while testing
//  that the library throws the expected exceptions on bad input.
//

#import "DDAssertionHandler.h"

@implementation DDAssertionHandler

@synthesize shouldLogAssertionFailure;

- (instancetype)init
{
    if ((self = [super init]))
    {
        shouldLogAssertionFailure = YES;
    }
    return self;
}

- (void)logFailureIn:(NSString *)place
                file:(NSString *)fileName
          lineNumber:(NSInteger)line
{
    // How Apple's default assertion handler does it (all on one line):
    //
    // *** Assertion failure in -[NSXMLElement insertChild:atIndex:],
    // /SourceCache/Foundation/Foundation-751.53/XML.subproj/XMLTypes.subproj/NSXMLElement.m:823

    NSLog(@"*** Assertion failure in %@, %@:%li", place, fileName, (long int)line);
}

- (void)handleFailureInFunction:(NSString *)functionName
                           file:(NSString *)fileName
                     lineNumber:(NSInteger)line
                    description:(NSString *)format, ...
{
    if (shouldLogAssertionFailure)
    {
        [self logFailureIn:functionName file:fileName lineNumber:line];
    }

    va_list args;
    va_start(args, format);

    NSString *reason = [[NSString alloc] initWithFormat:format arguments:args];

    va_end(args);

    [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
}

- (void)handleFailureInMethod:(SEL)selector
                       object:(id)object
                         file:(NSString *)fileName
                   lineNumber:(NSInteger)line
                  description:(NSString *)format, ...
{
    if (shouldLogAssertionFailure)
    {
        Class objectClass = [object class];

        NSString *type;
        if (objectClass == object)
            type = @"+";
        else
            type = @"-";

        NSString *place = [NSString stringWithFormat:@"%@[%@ %@]",
                           type, NSStringFromClass(objectClass), NSStringFromSelector(selector)];

        [self logFailureIn:place file:fileName lineNumber:line];
    }

    va_list args;
    va_start(args, format);

    NSString *reason = [[NSString alloc] initWithFormat:format arguments:args];

    va_end(args);

    [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise];
}

@end
