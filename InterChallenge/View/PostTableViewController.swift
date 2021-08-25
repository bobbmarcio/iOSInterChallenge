import Alamofire
import UIKit

class PostTableViewController: UITableViewController {
    
    var userId = Int()
    var userName = String()
    var posts = [Post]()
    var cellIdentifier = "TitleAndDescriptionCell"
    private var viewModel = PostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Postagens de \(userName)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        
        Bus.shared.subscribeOnPost(.postFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let posts):
                self?.viewModel.posts = posts
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
    }
        
        viewModel.fillPosts(from: userId)
        
    }
    
    init(userId: Int, userName: String) {
        self.userId = userId
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }
        
        let post = Post.PostBuilder().build(post: viewModel.posts[indexPath.row])
        cell.configurePost(with: PostModel(with: post))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = viewModel.posts[indexPath.row].id
        let commentVC = CommentTableViewController(postId: postId, userName: userName)
        navigationController?.pushViewController(commentVC, animated: true)
    }

}
