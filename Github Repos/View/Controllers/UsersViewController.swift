//
//  UsersViewController.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit
import SkeletonView

class UsersViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var usersCollection: UICollectionView!
    @IBOutlet var userEmptyState: UIView!
    
    var users = [UserViewModel]()
    var didShowSkeleton = false
    var lastUserId = 1
    var shouldShowLoadingCell = false
    var isSearching = false
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Repos"
        
        getUsers()
        
        searchTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didShowSkeleton {
            usersCollection.prepareSkeleton { (done) in
                let visibleCells = self.usersCollection.visibleCells
                if self.users.isEmpty {
                    for cell in visibleCells {
                        cell.contentView.layoutIfNeeded()
                        cell.contentView.showAnimatedGradientSkeleton()
                    }
                } else {
                    self.usersCollection.reloadData()
                }
            }
            didShowSkeleton = true
        }
//        usersCollection.collectionViewLayout.invalidateLayout()
    }
    
    func getUsers() {
        APIServices.shared.getUsers(since: self.lastUserId) { (users) in
            self.users.append(contentsOf: users.map{ UserViewModel(user: $0) })
            self.usersCollection.hideSkeleton()
            self.usersCollection.reloadData()
            self.shouldShowLoadingCell = true
        }
        
    }
    
    func searchUser(query: String) {
        self.users.removeAll()
        APIServices.shared.searchUser(query: query) { (users) in
            self.users.append(contentsOf: users.map{ UserViewModel(user: $0) })
            self.usersCollection.reloadData()
            self.usersCollection.hideSkeleton()
            self.shouldShowLoadingCell = false
        }
    }
    
    @objc func editingChanged() {
        if let text = searchTextField.text {
            if text.isEmpty {
                lastUserId = 1
                self.users.removeAll()
                isSearching = false
                getUsers()
            }
        }
        
    }
}

// MARK: - UICollectionView
extension UsersViewController: UICollectionViewDelegate, SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.isEmpty ? (usersCollection.backgroundView = userEmptyState) : (usersCollection.backgroundView = nil)
        return  shouldShowLoadingCell ? users.count + 1 : users.count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UserCell.typeName
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingIndexPath(indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityIndicatorCell.typeName, for: indexPath) as! ActivityIndicatorCell
            cell.activityIndicator.startAnimating()
            cell.hideSkeleton()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.typeName, for: indexPath) as! UserCell
            cell.userViewModel = users[indexPath.row]
            cell.hideSkeleton()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        guard let lastUser = users.last else { return }
        
        self.lastUserId = lastUser.id
        if !isSearching {
            getUsers()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !usersCollection.isSkeletonActive {
            let dest = UserDetailsViewController.instantiateFromStoryboard(storyboard: .Main)
            dest.user = users[indexPath.row]
            self.selectedIndexPath = indexPath
            navigationController?.show(dest, sender: nil)
        }
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.users.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellwidth = (collectionView.frame.width / 3) - 10
        let cellHeight: CGFloat = 160
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }
}

extension UsersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            searchUser(query: textField.text!)
        }
        return true
    }
}

extension UsersViewController: ZoomingViewController {
    func zoomingBackgroudView(for transition: ZoomTransitionDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitionDelegate) -> UIImageView? {
        if let indexPath = selectedIndexPath {
            let cell = usersCollection.cellForItem(at: indexPath) as! UserCell
            return cell.avatarImageView
        }
        
        return nil
    }
}
