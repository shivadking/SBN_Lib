//
//  AutocompleteDemoViewController.m
//  AutocompleteDemo
//
//  Created by Radu on 9/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AutocompleteDemoViewController.h"

@implementation AutocompleteDemoViewController

@synthesize demoField, suggestionTable;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	autocomplete = [[Autocomplete alloc] initWithArray:[NSArray arrayWithObjects:@"apples", @"oranges", @"bananas", @"peaches", @"grapes", @"blackberries", @"strawberies", @"watermelons", @"mangos", @"pears", @"lemons", nil]];
	demoField.autocorrectionType = UITextAutocorrectionTypeNo;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[suggestions release];
	[autocomplete release];
	
    [super dealloc];
}


- (IBAction)textEditBegin:(id)textField
{
	[self.view addSubview:suggestionTable];
}

- (IBAction)textDidChange:(id)textField
{
	[suggestions release];
	suggestions = [[NSArray alloc] initWithArray:[autocomplete GetSuggestions:((UITextField*)textField).text]];
	
	[self.view addSubview:suggestionTable];
	[suggestionTable reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (suggestions)
	{
		return [suggestions count];
	}
	
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell.
	cell.textLabel.text = [suggestions objectAtIndex:indexPath.row];	
	
    return cell;
}



// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	demoField.text = [suggestions objectAtIndex:indexPath.row];
	[suggestionTable removeFromSuperview];
}

@end
