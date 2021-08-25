import Alamofire
import UIKit

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    var cellIdentifier = "PhotoCell"
    var photos = [Photo]()
    private var viewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fotos de \(userName)"
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        Bus.shared.subscribeOnPhoto(.photoFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let photos):
                self?.viewModel.photos = photos
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
    }
        
        viewModel.fillPhotos(from: albumId)
    }
    
    init(userName: String, albumId: Int) {
        self.userName = userName
        self.albumId = albumId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = Photo.PhotoBuilder().build(photo: viewModel.photos[indexPath.row])
        cell.configure(with: PhotoModel(with: photo))

        AF.download(photo.thumbnailUrl).responseData { response in
            switch response.result {
            case .success(let data):
                cell.photoImageView.image = UIImage(data: data)
            default:
                break
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        AF.download(photo.url).responseData { response in
            switch response.result {
            case .success(let data):
                let detailVC = DetailsViewController(photo: (UIImage(data: data)!), name: photo.title)
                self.navigationController?.pushViewController(detailVC, animated: true)
            default:
                break
            }
        }
    }

}
