//
//  ProfileCell.swift
//  OnParSwift
//
//  Created by William Lewis on 4/13/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            switchControl.isHidden = !sectionType.containsSwitch
        }
    }
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = .black
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        
        return  switchControl
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(switchControl)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSwitchAction))
        switchControl.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.isOn {
            print("Turned on")
        } else {
            print("Turned off")
        }
    }
    
    
}
