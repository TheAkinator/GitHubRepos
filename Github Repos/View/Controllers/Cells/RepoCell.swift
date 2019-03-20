//
//  RepoCell.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoWatchesLabel: UILabel!
    @IBOutlet weak var repoStarsLabel: UILabel!
    @IBOutlet weak var repoForksLabel: UILabel!
    
    var repoViewModel: RepoViewModel! {
        didSet{
            repoNameLabel.text = repoViewModel.name
            repoDescriptionLabel.text = repoViewModel.description
            repoWatchesLabel.text = repoViewModel.watchers
            repoStarsLabel.text = repoViewModel.stars
            repoForksLabel.text = repoViewModel.forks
        }
    }

}
