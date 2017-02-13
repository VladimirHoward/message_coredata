//
//  VKMDialogTableViewCell.swift
//  vk_news
//
//  Created by Admin on 24.11.16.
//  Copyright © 2016 vvz. All rights reserved.
//

import UIKit

private let kCollectionViewCellXIBName = "ACAvatarChatCollectionViewCell"
private let kCollectionViewCellReuseIdentifier = "kPostsCellIdentifier"

class VKMDialogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var contentViewCell: UIView!
    
    
    
    var dataSource = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        Avatar.layer.cornerRadius = 35
        Avatar.clipsToBounds = true
        
        CollectionView.layer.cornerRadius = 35
        CollectionView.clipsToBounds = true
        
        CollectionView.register( UINib(nibName: kCollectionViewCellXIBName, bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellReuseIdentifier)
        self.CollectionView.dataSource = self
        self.CollectionView.delegate = self
    }
    
}

//MARK: настройка клетки
extension VKMDialogTableViewCell
{
    
    
    func configureSelf (withDataModel model: VKMChatRoomCoreData)
    {
        
        Message.text = model.body
        
        
                
        
        
        //Если не прочитано
        if (model.unread == 0) && (model.out == 0)
        {
           contentViewCell.backgroundColor = UIColor.groupTableViewBackground
        }
        
        //Если отправлено мной и еще не прочитали
        if (model.unread == 0) && (model.out == 1)
        {
            Message.backgroundColor = UIColor.groupTableViewBackground
        }
        
        self.CollectionView.reloadData()
    }
    
}


//MARK: настройка аватара
extension VKMDialogTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellReuseIdentifier, for: indexPath) as! ACAvatarChatCollectionViewCell
        
        cell.configureViewPhoto(photoURL: dataSource[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if dataSource.count == 1
        {
            return CGSize(width: 70, height: 70)
        }
        
        if dataSource.count == 2
        {
            return CGSize(width: 34.5, height: 70)
        }
        else
        {
            return CGSize(width: 34.5, height: 34.5)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
}
