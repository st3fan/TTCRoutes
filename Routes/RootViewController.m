//  RootViewController.m

#import "RootViewController.h"
#import "RoutesParser.h"
#import "Route.h"
#import "DirectionsTableViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = @"Routes";

	NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString* archiveFile = [documentsDirectory stringByAppendingPathComponent: @"Routes.archive"];
	
	_routes = [[NSKeyedUnarchiver unarchiveObjectWithFile: archiveFile] retain];
	if (_routes == nil) {
		_routes = [[RoutesParser parseRoutesFromFile: [[NSBundle mainBundle] pathForResource: @"Routes" ofType: @"xml"]] retain];
		[NSKeyedArchiver archiveRootObject: _routes toFile: archiveFile];
	}
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	Route* route = [_routes objectAtIndex: indexPath.row];
	cell.textLabel.text = route.title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Route* route = [_routes objectAtIndex: indexPath.row];
	DirectionsTableViewController* vc = [[[DirectionsTableViewController alloc] initWithRoute: route] autorelease];
    [self.navigationController pushViewController: vc animated:YES];
}

@end
