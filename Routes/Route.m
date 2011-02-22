// Route.m

#import "Route.h"
#import "Stop.h"
#import "Direction.h"

@implementation Route

@synthesize tag = _tag;
@synthesize title = _title;
@synthesize stopsByTag = _stopsByTag;
@synthesize directionsByTag = _directionsByTag;

- (id) init
{
	if ((self = [super init]) != nil) {
		_stopsByTag = [NSMutableDictionary new];
		_directionsByTag = [NSMutableDictionary new];
	}
	return self;
}

- (void) dealloc
{
	[_tag release];
	[_title release];
	[_stopsByTag release];
	[_directionsByTag release];
	[super dealloc];
}

#pragma mark -

- (void) encodeWithCoder:(NSCoder*) coder
{
	[coder encodeObject: _tag forKey: @"tag"];
	[coder encodeObject: _title forKey: @"title"];
	[coder encodeObject: _stopsByTag forKey: @"stopsByTag"];
	[coder encodeObject: _directionsByTag forKey: @"directionsByTag"];
}


- (id) initWithCoder: (NSCoder*) coder
{
	if ((self = [super init]) != nil) {
		self.tag = [coder decodeObjectForKey: @"tag"];
		self.title = [coder decodeObjectForKey: @"title"];
		_stopsByTag = [[coder decodeObjectForKey: @"stopsByTag"] retain];
		_directionsByTag = [[coder decodeObjectForKey: @"directionsByTag"] retain];
	}
	return self;
}

#pragma mark -

- (NSArray*) directions
{
	return [_directionsByTag allValues];
}

#pragma mark -

- (void) addStop: (Stop*) stop
{
	[_stopsByTag setObject: stop forKey: stop.tag];
}

- (void) addDirection: (Direction*) direction
{
	[_directionsByTag setObject: direction forKey: direction.tag];
}

@end
