//
//  VKMFriendsListVC.swift
//  Messanger
//
//  Created by Gregory House on 22.01.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit


//MARK: жизненный цикл
class VKMFriendsListViewController: UIViewController
{
    
    let kUserListCellNib = UINib(nibName: "VKMFriendsListTableViewCell", bundle: nil)
    let kUserListReuseIdentifier = "kUserListReuseIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: BasePresenter?
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.register(kUserListCellNib, forCellReuseIdentifier: kUserListReuseIdentifier)
        
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
        
        if (presenter == nil)
        {
            VKMDependencyInjector.assignPresenter(forView: self)
        }
    }
    
}

//MARK: процедуры BaseView
extension VKMFriendsListViewController: BaseView
{
    func assignPresenter (presenter: BasePresenter) -> Void
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

//MARK: процедуры UITableViewDataSOURCE Delegate
extension VKMFriendsListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = presenter!.getModel(atIndexPath: indexPath as NSIndexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserListReuseIdentifier, for: indexPath) as! VKMFriendsListTableViewCell
        cell.congigureSelg(withDataModel: model as! VKMFriend)
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getModelsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

