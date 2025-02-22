#import <Foundation/Foundation.h>
#import "DDXMLElement.h"
#import "DDXMLNode.h"

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

enum {
	DDXMLDocumentXMLKind NS_SWIFT_NAME(XMLDocumentXMLKind) = 0,
	DDXMLDocumentXHTMLKind NS_SWIFT_NAME(XMLDocumentXHTMLKind),
	DDXMLDocumentHTMLKind NS_SWIFT_NAME(XMLDocumentHTMLKind),
	DDXMLDocumentTextKind NS_SWIFT_NAME(XMLDocumentTextKind)
};
typedef NSUInteger DDXMLDocumentContentKind NS_SWIFT_NAME(XMLDocumentContentKind);

NS_ASSUME_NONNULL_BEGIN
@interface DDXMLDocument : DDXMLNode
{
}

- (nullable instancetype)initWithXMLString:(NSString *)string options:(DDXMLNodeOptions)mask error:(NSError **)error;
//- (instancetype)initWithContentsOfURL:(NSURL *)url options:(DDXMLNodeOptions)mask error:(NSError **)error;
- (nullable instancetype)initWithData:(NSData *)data options:(DDXMLNodeOptions)mask error:(NSError **)error;
- (instancetype)initWithRootElement:(DDXMLElement *)element;

- (instancetype)initWithHTMLString:(NSString *)string options:(NSInteger)options error:(NSError **)error;

- (instancetype)initWithHTMLData:(NSData *)data options:(NSInteger)options error:(NSError **)error;

//+ (Class)replacementClassForClass:(Class)cls;

//- (void)setCharacterEncoding:(NSString *)encoding; //primitive
//- (NSString *)characterEncoding; //primitive

//- (void)setVersion:(NSString *)version;
//- (NSString *)version;

//- (void)setStandalone:(BOOL)standalone;
//- (BOOL)isStandalone;

//- (void)setDocumentContentKind:(DDXMLDocumentContentKind)kind;
//- (DDXMLDocumentContentKind)documentContentKind;

//- (void)setMIMEType:(NSString *)MIMEType;
//- (NSString *)MIMEType;

//- (void)setDTD:(DDXMLDTD *)documentTypeDeclaration;
//- (DDXMLDTD *)DTD;

- (void)setRootElement:(DDXMLNode *)root;
- (nullable DDXMLElement *)rootElement;

//- (void)insertChild:(DDXMLNode *)child atIndex:(NSUInteger)index;

//- (void)insertChildren:(NSArray *)children atIndex:(NSUInteger)index;

//- (void)removeChildAtIndex:(NSUInteger)index;

//- (void)setChildren:(NSArray *)children;

//- (void)addChild:(DDXMLNode *)child;

//- (void)replaceChildAtIndex:(NSUInteger)index withNode:(DDXMLNode *)node;

@property (readonly, copy) NSData *XMLData;
- (NSData *)XMLDataWithOptions:(DDXMLNodeOptions)options;

//- (instancetype)objectByApplyingXSLT:(NSData *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (instancetype)objectByApplyingXSLTString:(NSString *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (instancetype)objectByApplyingXSLTAtURL:(NSURL *)xsltURL arguments:(NSDictionary *)argument error:(NSError **)error;

//- (BOOL)validateAndReturnError:(NSError **)error;

@end
#if TARGET_OS_IPHONE || TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
@compatibility_alias XMLDocument DDXMLDocument;
#endif
NS_ASSUME_NONNULL_END
