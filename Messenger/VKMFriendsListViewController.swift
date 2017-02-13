//
//  VKMFriendsListViewController.swift
//  Messenger
//
//  Created by MacAdmin on 22.01.17.
//  Copyright © 2017 Beet Lab. All rights reserved.
//

import UIKit

//MARK: жизненный цикл
class VKMFriendsListViewController: UIViewController
{
    let kUserListCellNib = UINib(nibName: "VKMFriendsListTableViewCell", bundle: nil)
    let kUserListCellReuseIdentifier = "kUserListCellReuseIdentifier"

    @IBOutlet weak var tableView: UITableView!
    var presenter : BasePresenter?
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.register(kUserListCellNib, forCellReuseIdentifier: kUserListCellReuseIdentifier)
        tableView.tableFooterView = UIView()
        
        if ( presenter == nil )
        {
            VKMDependencyInjector.assignPresenter(forView: self)
        }
        else
        {
            presenter?.resfreshData()
        }
    }
}

//MARK: процедуры BaseView
extension VKMFriendsListViewController : BaseView
{
    func assignPresenter ( presenter : BasePresenter ) -> Void
    {
        self.presenter = presenter
        presenter.viewLoaded()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData () -> Void
    {
        tableView.reloadData()
    }
}

//MARK: процедуры UITableViewDataSource , UITableViewDelegate
extension VKMFriendsListViewController : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = presenter!.getModel( atIndexPath: indexPath as NSIndexPath ) as! VKMFriend
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserListCellReuseIdentifier, for: indexPath) as! VKMFriendsListTableViewCell
        cell.configureSelf ( withDataModel : model )
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter!.getModelsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
}

