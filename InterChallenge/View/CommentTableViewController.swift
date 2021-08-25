import Alamofire
import UIKit

class CommentTableViewController: UITableViewController {
    
    var postId = Int()
    var userName = String()
    var cellIdentifier = "TitleAndDescriptionCell"
    var comments = [Comment]()
    private var viewModel = CommentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comentários de \(userName)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        
        Bus.shared.subscribeOnComment(.commentFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let comments):
                self?.viewModel.comments = comments
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
    }
        
        viewModel.fillComments(from: postId)
        
    }
    
    init(postId: Int, userName: String) {
        self.postId = postId
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
   }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }
    
        let comment = Comment.CommentBuilder().build(comment: viewModel.comments[indexPath.row])
        cell.configureComment(with: CommentModel(with: comment))

        return cell
    }
}
