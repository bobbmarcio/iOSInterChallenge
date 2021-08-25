import Alamofire
import UIKit

class AlbumTableViewController: UITableViewController {

    var userId = Int()
    var userName = String()
    var cellIdentifier = "AlbumCell"
    var albums = [Album]()
    private var viewModel = AlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Álbuns de \(userName)"
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        Bus.shared.subscribeOnAlbum(.albumFetch) { [weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let albums):
                self?.viewModel.albums = albums
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
    }
        
        viewModel.fillAlbums(from: userId)
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
        return viewModel.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        let album = Album.AlbumBuilder().build(album: viewModel.albums[indexPath.row])
        cell.configure(with: AlbumModel(with: album))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = viewModel.albums[indexPath.row].id
        let photoVC = PhotoTableViewController(userName: userName, albumId: albumId)
        navigationController?.pushViewController(photoVC, animated: true)
    }

}
