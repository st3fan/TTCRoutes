// StopsTableViewController.m

#import "StopsTableViewController.h"
#import "Route.h"
#import "Direction.h"
#import "Stop.h"
#import "StopViewController.h"

@implementation StopsTableViewController

- (id)initWithRoute: (Route*) route direction: (Direction*) direction
{
    if ((self = [super initWithStyle: UITableViewStylePlain]) != nil) {
		_route = [route retain];
		_direction = [direction retain];
    }
    return self;
}

- (void)dealloc
{
	[_route release];
	[_direction release];
    [super dealloc];
}

#pragma mark -

- (void) viewDidLoad
{
	[super viewDidLoad];
	self.title = _direction.title;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_direction.stops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Stop* stop = [_direction.stops objectAtIndex: indexPath.row];
    cell.textLabel.text = stop.title;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Stop* stop = [_direction.stops objectAtIndex: indexPath.row];
	StopViewController* vc = [[[StopViewController alloc] initWithStop: stop] autorelease];
    [self.navigationController pushViewController: vc animated:YES];
}

@end
