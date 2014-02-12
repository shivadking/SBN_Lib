//
//  AutocompleteDemoViewController.h
//  AutocompleteDemo
//
//  Created by Radu on 9/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Autocomplete.h"

@interface AutocompleteDemoViewController : UIViewController
{
	UITextField		*demoField;
	UITableView		*suggestionTable;
	
	Autocomplete	*autocomplete;
	
	NSArray			*suggestions;
}

@property (nonatomic, retain) IBOutlet UITextField *demoField;
@property (nonatomic, retain) IBOutlet UITableView *suggestionTable;

- (IBAction)textDidChange:(id)textField;
- (IBAction)textEditBegin:(id)textField;

@end

