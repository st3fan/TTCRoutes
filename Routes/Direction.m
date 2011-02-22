//  Direction.m

#import "Direction.h"

@implementation Direction

@synthesize tag = _tag;
@synthesize title = _title;
@synthesize stops = _stops;

- (id) init
{
	if ((self = [super init]) != nil) {
		_stops = [NSMutableArray new];
	}
	return self;
}

- (void) dealloc
{
	[_tag release];
	[_title release];
	[_stops release];
	[super dealloc];
}

#pragma mark -

- (void) encodeWithCoder:(NSCoder*) coder
{
	[coder encodeObject: _tag forKey: @"tag"];
	[coder encodeObject: _title forKey: @"title"];
	[coder encodeObject: _stops forKey: @"stops"];
}


- (id) initWithCoder: (NSCoder*) coder
{
	if ((self = [super init]) != nil) {
		self.tag = [coder decodeObjectForKey: @"tag"];
		self.title = [coder decodeObjectForKey: @"title"];
		_stops = [[coder decodeObjectForKey: @"stops"] retain];
	}
	return self;
}

@end
