import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    var users = [User]()
    var cellIdentifier = "UserCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Desafio"
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fillUsers()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = User.UserBuilder().build(user: users[indexPath.row])
        cell.configure(with: ChallengeViewModel(with: user))
        cell.delegate = self
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
        return cell
    }
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        let albumVC = AlbumTableViewController(userId: userId, userName: name)
        navigationController?.pushViewController(albumVC, animated: true)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        let postVC = PostTableViewController(userId: userId, userName: name)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
