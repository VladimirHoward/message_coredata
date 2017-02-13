//
//  VKMDialogsListViewController.swift
//  Messanger
//
//  Created by Admin on 15.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class VKMDialogsListViewController: UIViewController
{
    let kDialogListCellNib = UINib(nibName: "VKMDialogTableViewCell", bundle: nil)
    let kDialogListCellReuseIdentifier = "kDialogListCellReuseIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: BasePresenter?
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.register(kDialogListCellNib, forCellReuseIdentifier: kDialogListCellReuseIdentifier)
        tableView.tableFooterView = UIView()
        
        if (presenter == nil)
        {
            VKMDependencyInjector.assignPresenter(forView: self)
        }
        
    }
}

//MARK: процедуры BaseView
extension VKMDialogsListViewController: BaseView
{
    func assignPresenter(presenter: BasePresenter) -> Void
    {
        self.presenter = presenter
        presenter.viewLoaded()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData() -> Void
    {
        tableView.reloadData()
    }
}

//MARK: процедуры DataSourse Delegate
extension VKMDialogsListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = presenter!.getModel(atIndexPath: indexPath as NSIndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: kDialogListCellReuseIdentifier, for: indexPath) as! VKMDialogTableViewCell
        cell.configureSelf(withDataModel: model as! VKMChatRoomCoreData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter!.getModelsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
}
