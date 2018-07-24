//
//  ListTableViewController.m
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import "ListTableViewController.h"
#import "DreamItem+CoreDataProperties.h"
#import "AppDelegate.h"
#import "DreamCell.h"
#import "DreamViewController.h"

@interface ListTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController<DreamItem *> *fetchController;

@end

@implementation ListTableViewController

#pragma mark - UIViewController overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self attemptFetch];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

#pragma mark - private methods

- (void)attemptFetch {
    
    NSFetchRequest<DreamItem *> *fetchRequest = [DreamItem fetchRequest];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationTime" ascending:NO];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    self.fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:AppDelegate.managedContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchController.delegate = self;
    
    @try {
        [self.fetchController performFetch:nil];
    }
    @catch(NSError *e) {
        printf("Could not load data\n");
    }
    
}

- (void)configureCellWithCell:(DreamCell *)cell at:(NSIndexPath *)indexPath {
    
    [cell configureCellWithItem:[self.fetchController objectAtIndexPath:indexPath]];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSArray *sections = self.fetchController.sections;
    
    if (sections) {
        return sections.count;
    }
    
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = self.fetchController.sections;
    
    if (sections) {
        return self.fetchController.sections[section].numberOfObjects;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DreamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DreamCell" forIndexPath:indexPath];
    
    if (cell) {
        [self configureCellWithCell:cell at:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [AppDelegate.managedContext deleteObject:[self.fetchController objectAtIndexPath:indexPath]];
        [AppDelegate.sharedDelegate saveContext];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SegueDreamViewController" sender:[self.fetchController objectAtIndexPath:indexPath]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DreamItem *dreamItem = (DreamItem *)sender;
    
    if ([segue.identifier isEqualToString:@"SegueDreamViewController"]) {
        DreamViewController *dreamVC = (DreamViewController *)segue.destinationViewController;
        dreamVC.dreamItem = dreamItem;
        dreamVC.isEditing = YES;
    }
}

#pragma mark - NSFetchedResultsController Delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCellWithCell:(DreamCell *)[self.tableView cellForRowAtIndexPath:indexPath] at:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
    
}

@end


















