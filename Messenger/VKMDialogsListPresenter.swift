//
//  VKMDialogsListPresenter.swift
//  Messanger
//
//  Created by Admin on 28.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import CoreData

class VKMDialogsListPresenter:NSObject, BasePresenter
{
    internal func resfreshData()
    {
        
    }

    weak var view : BaseView?
    
    private var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>!
    
    private func setUpFRC ()
    {
        
        let managedObjectContext = VKMCoreDataManager.sharedInstance.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VKMChatRoomCoreData", in: managedObjectContext)
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        let req = NSFetchRequest<NSFetchRequestResult>()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        _ = try? fetchedResultsController.performFetch()
    }
    
    func viewLoaded() -> Void
    {
        setUpFRC()
        loadModels(withOffset: 0, count: 10)
    }
    
    func assignView ( view : BaseView) -> Void
    {
        self.view = view
    }
    
    func getModel( atIndexPath indexPath : NSIndexPath) -> Any
    {
        return fetchedResultsController.object(at: indexPath as IndexPath)
    }
    
    func getModelsCount() -> Int
    {
        if let objects = fetchedResultsController.fetchedObjects
        {
            return objects.count
        }
        
        return 0
        
    }
    
    func loadModels (withOffset offset : Int, count : Int) -> Void
    {
        VKMDialogsManager.getDialogs(count: count, offset: offset, success: { [weak self](data) in
            
            
            
        }) { [weak self](errorCode) in
            
        }
        view?.reloadData()
    }
}

//MARK: процедуры FRC Delegate
extension VKMDialogsListPresenter: NSFetchedResultsControllerDelegate
{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        print("начали обновление ")
        view?.beginUIUpdates?()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        print("закончили обновление ")
        view?.endUIUpdates?()

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                      didChange anObject: Any,
                      at indexPath: IndexPath?,
                      for type: NSFetchedResultsChangeType,
                      newIndexPath: IndexPath?)
    {
        switch type
        {
        
        case .insert: view?.insertRows?(atIndexPath: [indexPath!])
            
        case .delete: view?.deleteRows?(atIndexPath: [indexPath!])
            
        case .move: view?.moveRow?(at: indexPath!, to: newIndexPath!)
            
        case .update: view?.updateRow?(at: indexPath!)
            
        }
    }
    
}









