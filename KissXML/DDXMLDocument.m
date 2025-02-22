#import "DDXMLPrivate.h"
#import "NSString+DDXML.h"
#import <libxml/parser.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

/**
 * Welcome to KissXML.
 * 
 * The project page has documentation if you have questions.
 * https://github.com/robbiehanson/KissXML
 * 
 * If you're new to the project you may wish to read the "Getting Started" wiki.
 * https://github.com/robbiehanson/KissXML/wiki/GettingStarted
 * 
 * KissXML provides a drop-in replacement for Apple's NSXML class cluster.
 * The goal is to get the exact same behavior as the NSXML classes.
 * 
 * For API Reference, see Apple's excellent documentation,
 * either via Xcode's Mac OS X documentation, or via the web:
 * 
 * https://github.com/robbiehanson/KissXML/wiki/Reference
**/

@implementation DDXMLDocument

/**
 * Returns a DDXML wrapper object for the given primitive node.
 * The given node MUST be non-NULL and of the proper type.
**/
+ (instancetype)nodeWithDocPrimitive:(xmlDocPtr)doc owner:(DDXMLNode *)owner
{
	return [[DDXMLDocument alloc] initWithDocPrimitive:doc owner:owner];
}

- (instancetype)initWithDocPrimitive:(xmlDocPtr)doc owner:(DDXMLNode *)inOwner
{
	self = [super initWithPrimitive:(xmlKindPtr)doc owner:inOwner];
	return self;
}

+ (instancetype)nodeWithPrimitive:(xmlKindPtr)kindPtr owner:(DDXMLNode *)owner
{
	// Promote initializers which use proper parameter types to enable compiler to catch more mistakes
	NSAssert(NO, @"Use nodeWithDocPrimitive:owner:");
	
	return nil;
}

- (instancetype)initWithPrimitive:(xmlKindPtr)kindPtr owner:(DDXMLNode *)inOwner
{
	// Promote initializers which use proper parameter types to enable compiler to catch more mistakes.
	NSAssert(NO, @"Use initWithDocPrimitive:owner:");
	
	return nil;
}

/**
 * Initializes and returns a DDXMLDocument object created from an NSData object.
 * 
 * Returns an initialized DDXMLDocument object, or nil if initialization fails
 * because of parsing errors or other reasons.
**/
- (instancetype)initWithXMLString:(NSString *)string options:(DDXMLNodeOptions)mask error:(NSError **)error
{
	return [self initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
	                  options:mask
	                    error:error];
}

/**
 * Initializes and returns a DDXMLDocument object created from an NSData object.
 * 
 * Returns an initialized DDXMLDocument object, or nil if initialization fails
 * because of parsing errors or other reasons.
**/
- (instancetype)initWithData:(NSData *)data options:(DDXMLNodeOptions)mask error:(NSError **)error
{
	if (data == nil || [data length] == 0)
	{
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:0 userInfo:nil];
		
		return nil;
	}
	
	// Even though xmlKeepBlanksDefault(0) is called in DDXMLNode's initialize method,
	// it has been documented that this call seems to get reset on the iPhone:
	// http://code.google.com/p/kissxml/issues/detail?id=8
	// 
	// Therefore, we call it again here just to be safe.
	xmlKeepBlanksDefault(0);
	
	xmlDocPtr doc = xmlParseMemory([data bytes], (int)[data length]);
	if (doc == NULL)
	{
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:1 userInfo:nil];
		
		return nil;
	}
	
	return [self initWithDocPrimitive:doc owner:nil];
}

- (id)initWithRootElement:(DDXMLElement *)element
{
	unsigned char version[] = "1.0";
	xmlDocPtr doc = xmlNewDoc(version);
	
	// NSXMLDocument always includes the standalone attribute, so DDXMLDocument needs to include it as well.
	doc->standalone = 1;
	
	self = [self initWithDocPrimitive:doc owner:nil];
	if (self) {
		[self setRootElement: element];
	}
	
	return self;
}

- (instancetype)initWithHTMLString:(NSString *)string options:(NSInteger)options error:(NSError **)error
{
	return [self initWithHTMLData:[string dataUsingEncoding:NSUTF8StringEncoding] options:options error:error];
}

- (instancetype)initWithHTMLData:(NSData *)data options:(NSInteger)options error:(NSError **)error
{
	if (!data.length) {
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:0 userInfo:nil];
		return nil;
	}
	
	xmlKeepBlanksDefault(0);
	
	xmlDocPtr doc = htmlReadMemory(data.bytes, (int)data.length, "", NULL, (int)options | HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
	if (!doc) {
		if (error) *error = [NSError errorWithDomain:@"DDXMLErrorDomain" code:1 userInfo:nil];
		return nil;
	}
	
	return [self initWithDocPrimitive:doc owner:nil];
}


- (void)setRootElement:(DDXMLNode *)root
{
	// NSXML version uses these same assertions
	DDXMLAssert([root _hasParent] == NO, @"Cannot add a child that has a parent; detach or copy first");
	DDXMLAssert(IsXmlNodePtr(root->genericPtr),
	            @"Elements can only have text, elements, processing instructions, and comments as children");
	
	xmlDocSetRootElement((xmlDocPtr)genericPtr, (xmlNodePtr)root->genericPtr);
	
	// The node is now part of the xml tree heirarchy
	root->owner = self;
}

/**
 * Returns the root element of the receiver.
**/
- (DDXMLElement *)rootElement
{
#if DDXML_DEBUG_MEMORY_ISSUES
	DDXMLNotZombieAssert();
#endif
	
	xmlDocPtr doc = (xmlDocPtr)self->genericPtr;
	
	// doc->children is a list containing possibly comments, DTDs, etc...
	
	xmlNodePtr rootNode = xmlDocGetRootElement(doc);
	
	if (rootNode != NULL)
		return [DDXMLElement nodeWithElementPrimitive:rootNode owner:self];
	else
		return nil;
}

- (NSData *)XMLData
{
	// Zombie test occurs in XMLString
	
	return [[self XMLString] dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)XMLDataWithOptions:(DDXMLNodeOptions)options
{
	// Zombie test occurs in XMLString
	
	return [[self XMLStringWithOptions:options] dataUsingEncoding:NSUTF8StringEncoding];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Equality
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (BOOL)isEqual:(id)object
{
	if (![super isEqual: object])
		return NO;
	
	DDXMLDocument *other = (DDXMLDocument *)object;
	return (self.rootElement == other.rootElement || [self.rootElement isEqual: other.rootElement]);
}

@end
