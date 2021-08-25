import Alamofire
import UIKit

class AlbumTableViewController: UITableViewController {

    var userId = Int()
    var userName = String()
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Álbuns de \(userName)"
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        fillAlbums(from: userId)
    }
    
    init(userId: Int, userName: String) {
        self.userId = userId
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fillAlbums(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(userId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Album].self, from: data)
                    self.albums = models
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        let album = Album.AlbumBuilder().build(album: albums[indexPath.row])
        cell.configure(with: AlbumViewModel(with: album))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = albums[indexPath.row].id
        let photoVC = PhotoTableViewController(userName: userName, albumId: albumId)
        navigationController?.pushViewController(photoVC, animated: true)
    }

}
