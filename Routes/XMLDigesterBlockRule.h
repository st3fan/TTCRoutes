//  XMLDigesterBlockRule.h

#import <Foundation/Foundation.h>
#import "XMLDigesterRule.h"

#if 1
typedef void (^XMLDigesterStartElementBlock)(XMLDigester* digester, NSDictionary* attributes);
typedef void (^XMLDigesterBodyBlock)(XMLDigester* digester, NSString* body);
typedef void (^XMLDigesterEndElementBlock)(XMLDigester* digester);
#endif

@interface XMLDigesterBlockRule : XMLDigesterRule {
    XMLDigesterStartElementBlock _startElementBlock;
	XMLDigesterBodyBlock _bodyBlock;
    XMLDigesterEndElementBlock _endElementBlock;
}

- (id) initWithStartElementBlock: (XMLDigesterStartElementBlock) startElementBlock bodyBlock: (XMLDigesterBodyBlock) bodyBlock endElementBlock: (XMLDigesterEndElementBlock) endElementBlock;

+ (id) blockRuleWithStartElementBlock: (XMLDigesterStartElementBlock) startElementBlock;
+ (id) blockRuleWithBodyBlock: (XMLDigesterBodyBlock) bodyBlock;
+ (id) blockRuleWithEndElementBlock: (XMLDigesterEndElementBlock) endElementBlock;

@end
