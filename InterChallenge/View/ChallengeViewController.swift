import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    var users = [User]()
    var cellIdentifier = "UserCell"
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Desafio"
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        Bus.shared.subscribeOnMain(.userFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let users):
                self?.viewModel.users = users
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
    }
        
        viewModel.fillUsers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = User.UserBuilder().build(user: viewModel.users[indexPath.row])
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
