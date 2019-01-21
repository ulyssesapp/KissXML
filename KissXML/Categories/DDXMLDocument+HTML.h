#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
#import "DDXMLDocument.h"

@interface DDXMLDocument (HTML)

- (instancetype)initWithHTMLString:(NSString *)string options:(NSUInteger)options error:(NSError **)error;

- (instancetype)initWithHTMLData:(NSData *)data options:(NSUInteger)options error:(NSError **)error;

@end
