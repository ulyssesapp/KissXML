#import "DDXMLDocument+HTML.h"
#import "DDXMLPrivate.h"

@implementation DDXMLDocument (HTML)

- (instancetype)initWithHTMLString:(NSString *)string options:(NSUInteger)options error:(NSError **)error
{
    return [self initWithHTMLData:[string dataUsingEncoding:NSUTF8StringEncoding] options:options error:error];
}

- (instancetype)initWithHTMLData:(NSData *)data options:(NSUInteger)options error:(NSError **)error
{
	if (!data.length) {
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:0 userInfo:nil];
		return nil;
	}
	
	xmlKeepBlanksDefault(0);
	
	xmlDocPtr doc = htmlReadMemory(data.bytes, (int)data.length, "", NULL, (int)options);
	if (!doc) {
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:1 userInfo:nil];
		return nil;
	}
	
	return [self initWithDocPrimitive:doc owner:nil];
}

@end
