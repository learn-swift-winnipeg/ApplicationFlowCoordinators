import UIKit

//MARK: -
protocol UpdateProfilePhotoVCDelegate: class {
    func didSuccessfullyUpdateProfilePhoto(from updateProfilePhotoVC: UpdateProfilePhotoVC)
}

//MARK: -
class UpdateProfilePhotoVC: UIViewController {

    // MARK: - Stored Properties
    
    weak var delegate: UpdateProfilePhotoVCDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Update Profile Photo"
    }
    
    // MARK: - Actions
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        delegate?.didSuccessfullyUpdateProfilePhoto(from: self)
    }
}
