// Stop.m

#import "Stop.h"

@implementation Stop

@synthesize tag = _tag;
@synthesize title = _title;
@synthesize stopId = _stopId;
@synthesize location = _location;

- (void) dealloc
{
	[_tag release];
	[_title release];
	[_stopId release];
	[super dealloc];
}

- (void) encodeWithCoder:(NSCoder*) coder
{
	[coder encodeObject: _tag forKey: @"tag"];
	[coder encodeObject: _title forKey: @"title"];
	[coder encodeObject: _stopId forKey: @"stopId"];
	[coder encodeDouble: _location.latitude forKey: @"locationLat"];
	[coder encodeDouble: _location.longitude forKey: @"locationLong"];
}


- (id) initWithCoder: (NSCoder*) coder
{
	if ((self = [super init]) != nil) {
		self.tag = [coder decodeObjectForKey: @"tag"];
		self.title = [coder decodeObjectForKey: @"title"];
		self.stopId = [coder decodeObjectForKey: @"stopId"];
		self.location = CLLocationCoordinate2DMake([coder decodeDoubleForKey: @"locationLat"], [coder decodeDoubleForKey: @"locationLong"]);
	}
	return self;
}

@end
