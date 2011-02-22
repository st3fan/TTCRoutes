//  RoutesParser.m

#import "XMLDigester.h"
#import "Route.h"
#import "Stop.h"
#import "Direction.h"
#import "RoutesParser.h"

@implementation RoutesParser

+ (NSArray*) parseRoutesFromFile: (NSString*) file;
{
	XMLDigester* digester = [XMLDigester digesterWithData: [NSData dataWithContentsOfFile: file]];
	[digester pushObject: [NSMutableArray array]];
	
	// Parse Routes
	
	[digester addRule: [XMLDigesterObjectCreateRule objectCreateRuleWithClass: [Route class]]
		forPattern: @"body/route"];
		
	[digester addRule: [XMLDigesterSetPropertiesRule setPropertiesRuleWithMappings: [NSDictionary dictionaryWithObjectsAndKeys: @"title",@"title", @"tag", @"tag", nil]]
		forPattern: @"body/route"];

		// Parse Stops

		[digester addRule: [XMLDigesterObjectCreateRule objectCreateRuleWithClass: [Stop class]]
			forPattern: @"body/route/stop"];

		[digester addRule: [XMLDigesterSetPropertiesRule setPropertiesRuleWithMappings: [NSDictionary dictionaryWithObjectsAndKeys: @"stopId",@"stopId", @"title",@"title", @"tag", @"tag", nil]]
			forPattern: @"body/route/stop"];

		XMLDigesterStartElementBlock setStopLocationBlock = ^(XMLDigester* digester, NSDictionary* attributes) {
			Stop* stop = [digester peekObject];
			stop.location = CLLocationCoordinate2DMake([[attributes objectForKey: @"lat"] doubleValue], [[attributes objectForKey: @"lon"] doubleValue]);
		};
			
		[digester addRule: [XMLDigesterBlockRule blockRuleWithStartElementBlock: setStopLocationBlock]
			forPattern: @"body/route/stop"];

		[digester addRule: [XMLDigesterSetNextRule setNextRuleWithSelector: @selector(addStop:)]
			forPattern: @"body/route/stop"];
			
		// Parse Directions

		[digester addRule: [XMLDigesterObjectCreateRule objectCreateRuleWithClass: [Direction class]]
			forPattern: @"body/route/direction"];

		[digester addRule: [XMLDigesterSetPropertiesRule setPropertiesRuleWithMappings: [NSDictionary dictionaryWithObjectsAndKeys: @"title",@"title", @"tag", @"tag", nil]]
			forPattern: @"body/route/direction"];

		[digester addRule: [XMLDigesterSetNextRule setNextRuleWithSelector: @selector(addDirection:)]
			forPattern: @"body/route/direction"];
			
		// Parse Stop Directions
		
		XMLDigesterStartElementBlock addStopToDirectionBlock = ^(XMLDigester* digester, NSDictionary* attributes) {
			Direction* direction = [digester peekObjectAtIndex: 0];
			Route* route = [digester peekObjectAtIndex: 1];			
			[direction.stops addObject: [route.stopsByTag objectForKey: [attributes objectForKey: @"tag"]]];
		};
		
		[digester addRule: [XMLDigesterBlockRule blockRuleWithStartElementBlock: addStopToDirectionBlock]
			forPattern: @"body/route/direction/stop"];
	
	[digester addRule: [XMLDigesterSetNextRule setNextRuleWithSelector: @selector(addObject:)]
		forPattern: @"body/route"];
	
	NSMutableArray* routes = [digester digest];
	
	return routes;
}

@end
