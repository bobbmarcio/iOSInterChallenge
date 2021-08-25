import UIKit

class TitleAndDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configurePost(with viewModel: PostModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.body
    }
    
    func configureComment(with viewModel: CommentModel) {
        selectionStyle = .none
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.body
    }
}
