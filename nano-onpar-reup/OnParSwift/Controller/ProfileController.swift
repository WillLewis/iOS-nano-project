//
//  ProfileController.swift
//  FriendlyChatSwift
//
//  Created by William Lewis on 4/8/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "ProfileCell"

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    var userID: String?
    var tableView: UITableView!
    var profileHeader: ProfileHeader!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        configureUI()
    }
    
    // MARK: Helper functions
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.rowHeight = 60
        tableView?.backgroundColor = .white
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.alwaysBounceVertical = false
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        profileHeader = ProfileHeader(frame: frame)
        tableView.tableHeaderView = profileHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    var user: User?
    fileprivate func fetchUser() {
        
        //let uid = userID ?? (Auth.auth().currentUser?.uid ?? "")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            
            self.tableView.tableHeaderView?.reloadInputViews()
            self.navigationItem.title = self.user?.username
            self.tableView?.reloadData()
            self.profileHeader.user = user
            
            print("fetched user id")
            print(self.user?.username ?? "trouble fetching user")

        
        }
    }

    func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else {return 0}
        
        switch section{
        case .linkedAccounts: return LinkedAccounts.allCases.count
        case .settings: return Settings.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 12)
        title.textColor = .gray
        title.text = ProfileSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints =  false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        guard let section = ProfileSection(rawValue: indexPath.section) else {return UITableViewCell()}
        
        switch section{
        case .linkedAccounts:
            let linkedAccounts = LinkedAccounts(rawValue: indexPath.row)
            cell.sectionType = linkedAccounts
        case .settings:
            let settings = Settings(rawValue: indexPath.row)
            cell.sectionType = settings
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = ProfileSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .linkedAccounts:
            print(LinkedAccounts(rawValue: indexPath.row)?.description ?? "error printing")
        case .settings:
            guard let setting = Settings(rawValue: indexPath.row) else {return}
            
            switch setting {
            case .notifications:
                print(Settings(rawValue: indexPath.row)?.description ?? "error printing")
            case .email:
                print(Settings(rawValue: indexPath.row)?.description ?? "error printing")
            case .name:
                print(Settings(rawValue: indexPath.row)?.description ?? "error printing")
            case .phoneNumber:
                print(Settings(rawValue: indexPath.row)?.description ?? "error printing")
            case .logOut:
                print(Settings(rawValue: indexPath.row)?.description ?? "error printing")
                handleLogOut()
           
            }
            
        }
    }
    
}
