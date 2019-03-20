//
//  UserCell.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    
    var userViewModel: UserViewModel! {
        didSet{
            avatarImageView.image = nil
            avatarImageView.downloaded(from: userViewModel.avatarUrl)
            nameLabel.text = userViewModel.name

        }
    }

}
