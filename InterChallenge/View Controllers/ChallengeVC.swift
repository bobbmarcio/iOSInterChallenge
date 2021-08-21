//
//  ChallengeVC.swift
//  InterChallenge
//
//  Created by Márcio Flores on 20/08/21.
//

import UIKit
import Alamofire

class ChallengeVC: UIViewController {
    var tableView = UITableView()
    var users: [User] = []
    
    struct Cells {
        static let userCell = "UserCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Desafio"
        fillUsers()
        configureTableView()
    }
    
    private func fillUsers() {
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            guard response.error == nil else {
                let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([User].self, from: data)
                    self.users = models
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 233
        tableView.register(UserCell.self, forCellReuseIdentifier: Cells.userCell)
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ChallengeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.userCell, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        let user = User.UserBuilder().build(user: users[indexPath.row])
        cell.set(user: user)
        cell.selectionStyle = .none
//        cell.id = user.id
//        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
        
        return cell
    }
    
    @objc func albunsClicked() {
        print("Clicked")
        let albunsVC = VideoListVC()
        navigationController?.pushViewController(albunsVC, animated: true)
    }
}
