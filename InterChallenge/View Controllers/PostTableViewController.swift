import Alamofire
import UIKit

class PostTableViewController: UITableViewController {
    
    var userId = Int()
    var userName = String()
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Postagens de \(userName)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TitleAndDescriptionCell")
        fillPosts(from: userId)
    }
    
    init(userId: Int, userName: String) {
        self.userId = userId
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillPosts(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Post].self, from: data)
                    self.posts = models
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let post = Post.PostBuilder().build(post: posts[indexPath.row])
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].id
//        performSegue(withIdentifier: "postToComment", sender: postId)
        let commentVC = CommentTableViewController(postId: postId, userName: userName)
        navigationController?.pushViewController(commentVC, animated: true)
    }

}
