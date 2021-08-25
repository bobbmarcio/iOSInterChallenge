import UIKit

class DetailsViewController: UIViewController {
    
    var photo = UIImageView()
    var name = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detalhes"
        view.addSubview(photo)
        view.addSubview(name)
        configurePhoto()
        configureName()
        setPhotoConstraints()
        setNameConstraints()
    }
    
    init(photo: UIImage, name: String) {
        self.photo.image = photo
        self.name.text = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhoto() {
        photo.clipsToBounds = true
    }
    
    func configureName() {
        name.numberOfLines = 2
        name.adjustsFontSizeToFitWidth = true
    }
    
    func setPhotoConstraints() {
        photo.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(photo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75))
        constraints.append(photo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -75))
        constraints.append(photo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 310))
        constraints.append(photo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    func setNameConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15))
        constraints.append(name.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15))
//        constraints.append(name.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 310))
        constraints.append(name.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 10))
        
        NSLayoutConstraint.activate(constraints)
    }
}
