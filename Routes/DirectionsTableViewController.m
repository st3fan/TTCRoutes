// DirectionsTableViewController.m

#import "DirectionsTableViewController.h"
#import "Route.h"
#import "Direction.h"
#import "StopsTableViewController.h"

@implementation DirectionsTableViewController

- (id)initWithRoute: (Route*) route;
{
    if ((self = [super initWithStyle: UITableViewStylePlain]) != nil) {
		_route = [route retain];
    }
    return self;
}

- (void)dealloc
{
	[_route release];
    [super dealloc];
}

#pragma mark -

- (void) viewDidLoad
{
	[super viewDidLoad];
	self.title = _route.title;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_route.directions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Direction* direction = [_route.directions objectAtIndex: indexPath.row];
    cell.textLabel.text = direction.title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Direction* direction = [_route.directions objectAtIndex: indexPath.row];
	StopsTableViewController* vc = [[[StopsTableViewController alloc] initWithRoute: _route direction: direction] autorelease];
    [self.navigationController pushViewController: vc animated:YES];
}

@end
