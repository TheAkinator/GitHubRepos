//
//  UserDetailsViewController.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit
import SkeletonView

class UserDetailsViewController: BaseViewController {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var reposTableView: UITableView!
    
    @IBOutlet weak var blurUserAvatar: UIImageView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    
    var user: UserViewModel!
    var repos = [RepoViewModel]()
    var didShowSkeleton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = user.name
        reposTableView.tableHeaderView = headerView
        reposTableView.estimatedRowHeight = 120
        reposTableView.rowHeight = UITableView.automaticDimension
        
        populateData()
        callServices()
        
    }
    
    override func viewDidLayoutSubviews() {
        if !didShowSkeleton {
            reposTableView.layoutIfNeeded()
            headerView.layoutIfNeeded()
            headerView.showAnimatedGradientSkeleton()
            reposTableView.showAnimatedGradientSkeleton()
            didShowSkeleton = true
        }
    }
    
    func callServices() {
        APIServices.shared.getUserDetails(user: user.name) { (user) in
            self.user = UserViewModel(user: user)
            self.populateData()
            self.headerView.hideSkeleton()
        }
        
        APIServices.shared.getRepos(user: user.name) { (repos) in
            self.repos = repos.map{ RepoViewModel(repo: $0) }
            self.reposTableView.reloadData()
            self.reposTableView.hideSkeleton()
        }
    }
    
    func populateData() {
        blurUserAvatar.downloaded(from: user.avatarUrl)
        blurUserAvatar.addBlur()
        userAvatar.downloaded(from: user.avatarUrl)
        userNameLabel.text = user.name
        memberSinceLabel.text = user.memberSince
        followersLabel.text = user.followers
        reposLabel.text = user.reposNumber
    }
}

extension UserDetailsViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return RepoCell.typeName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.typeName, for: indexPath) as! RepoCell
        cell.repoViewModel = repos[indexPath.row]
        return cell
    }
}


extension UserDetailsViewController: ZoomingViewController {
    func zoomingBackgroudView(for transition: ZoomTransitionDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitionDelegate) -> UIImageView? {
        return userAvatar
    }
}
