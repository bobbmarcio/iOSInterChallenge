import Alamofire
import UIKit

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fotos de \(userName)"
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        fillPhotos(from: albumId)
    }
    
    init(userName: String, albumId: Int) {
        self.userName = userName
        self.albumId = albumId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillPhotos(from albumId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Photo].self, from: data)
                    self.photos = models
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

        let photo = Photo.PhotoBuilder().build(photo: photos[indexPath.row])
        cell.configure(with: PhotoViewModel(with: photo))

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
