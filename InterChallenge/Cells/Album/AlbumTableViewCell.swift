import UIKit

protocol AlbumTableViewCellDelegate: AnyObject {
    func didTapAlbum(with userName: String, by albumId: Int)
}

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
