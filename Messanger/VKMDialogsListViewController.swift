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
   
    let kDialogListCellNib = UINib(nibName: "VKMDialogListTableViewCell", bundle: nil)
    let kDialogListReuseIdentifier = "kDialogListReuseIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: BasePresenter?
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.register(kDialogListCellNib, forCellReuseIdentifier: kDialogListReuseIdentifier)
        tableView.tableFooterView = UIView()
        
        super.viewWillAppear(animated)
        
        if (presenter == nil)
        {
            VKMDependencyInjector.assignPresenter(forView: self)
        }
    }
}

//MARK: процедуры BaseView
extension VKMDialogsListViewController: BaseView
{
    func assignPresenter(presenter: BasePresenter)
    {
        self.presenter = presenter
        presenter.viewLoaded()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData()
    {
        tableView.reloadData()
    }
}

//MARK: процедуры UITableViewDataSOURCE Delegate
extension VKMDialogsListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = presenter!.getModel(atIndexPath: indexPath as NSIndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: kDialogListReuseIdentifier, for: indexPath) as! VKMDialogListTableViewCell
        cell.configureSelf(withDataModel: model as! VKMDialog)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter!.getModelsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
}

