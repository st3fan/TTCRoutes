//  XMLDigesterBlockRule.m

#import "XMLDigesterBlockRule.h"

@implementation XMLDigesterBlockRule

- (id) initWithStartElementBlock: (XMLDigesterStartElementBlock) startElementBlock bodyBlock: (XMLDigesterBodyBlock) bodyBlock endElementBlock: (XMLDigesterEndElementBlock) endElementBlock;
{
	if ((self = [super init]) != nil) {
		_startElementBlock = [startElementBlock retain];
		_bodyBlock = [bodyBlock retain];
		_endElementBlock = [endElementBlock retain];
	}
	return self;
}

- (void) dealloc
{
	[_startElementBlock release];
	[_bodyBlock release];
	[_endElementBlock release];
	[super dealloc];
}

+ (id) blockRuleWithStartElementBlock: (XMLDigesterStartElementBlock) startElementBlock
{
	return [[[self alloc] initWithStartElementBlock: startElementBlock bodyBlock: nil endElementBlock: nil] autorelease];
}

+ (id) blockRuleWithBodyBlock: (XMLDigesterBodyBlock) bodyBlock
{
	return [[[self alloc] initWithStartElementBlock: nil bodyBlock: bodyBlock endElementBlock: nil] autorelease];
}

+ (id) blockRuleWithEndElementBlock: (XMLDigesterEndElementBlock) endElementBlock
{
	return [[[self alloc] initWithStartElementBlock: nil bodyBlock: nil endElementBlock: endElementBlock] autorelease];
}

- (void) didStartElement: (NSString*) elementName attributes: (NSDictionary*) attributeDict
{
	if (_startElementBlock != nil) {
		_startElementBlock([self digester], attributeDict);
	}
}

- (void) didBody:(NSString *)body
{
	if (_bodyBlock != nil) {
		_bodyBlock([self digester], body);
	}
}

- (void) didEndElement:(NSString *)elementName
{
	if (_endElementBlock != nil) {
		_endElementBlock([self digester]);
	}
}

@end
