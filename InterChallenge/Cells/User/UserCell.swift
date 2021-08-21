//
//  UserCell.swift
//  InterChallenge
//
//  Created by Márcio Flores on 20/08/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    var initialsLabel = UILabel()
    var nameLabel = UILabel()
    var userNameLabel = UILabel()
    var emailLabel = UILabel()
    var phoneLabel = UILabel()
    var albunsButton = UIButton()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(initialsLabel)
        addSubview(nameLabel)
        addSubview(userNameLabel)
        addSubview(emailLabel)
        addSubview(phoneLabel)
        addSubview(albunsButton)
        
        configureInitialsLabels()
        configureNameLabel()
        configureUserNameLabel()
        configureEmailLabel()
        configurePhoneLabel()
        configureAlbunsButton()
        
//        setInitialsLabels()
//        setNameLabel()
        setAlbunsButton()
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(user: User) {
        initialsLabel.text = String(user.name.prefix(2))
        nameLabel.text = user.name
        userNameLabel.text = user.username
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        albunsButton.setTitle("ÁLBUM \(user.username)", for: .normal)
    }
    
    func configureInitialsLabels() {
        initialsLabel.numberOfLines = 0
        initialsLabel.clipsToBounds = true
    }
    
    func configureNameLabel() {
        initialsLabel.numberOfLines = 0
        initialsLabel.clipsToBounds = true
    }
    
    func configureUserNameLabel() {
        
    }
    
    func configureEmailLabel() {
        
    }
    
    func configurePhoneLabel() {
        
    }
    
    func configureAlbunsButton() {
//        albunsButton.clipsToBounds = true
//        albunsButton.addTarget(self, action: #selector(ChallengeVC.albunsClicked), for: .allTouchEvents)
        albunsButton.backgroundColor = .black
        albunsButton.setTitleColor(.white, for: .normal)
        albunsButton.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        albunsButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
    }
    
    @objc private func clicked() {
        print("Funcao click")
    }
    
    func setInitialsLabels() {
//        initialsLabel.translatesAutoresizingMaskIntoConstraints = false
//        initialsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        initialsLabel.leadingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: 20).isActive = true
//        initialsLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        initialsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        initialsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        initialsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setAlbunsButton() {
        albunsButton.translatesAutoresizingMaskIntoConstraints = false
        albunsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        albunsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    }
