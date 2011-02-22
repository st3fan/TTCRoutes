// StopsTableViewController.h

#import <UIKit/UIKit.h>

@class Route;
@class Direction;

@interface StopsTableViewController : UITableViewController {
    Route* _route;
	Direction* _direction;
}

- (id)initWithRoute: (Route*) route direction: (Direction*) direction;

@end
