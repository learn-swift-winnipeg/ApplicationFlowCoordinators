protocol UserAccountService {
    var isSignedIn: Bool { get }
    
    func validateSignInInputs(email: String?, password: String?) -> Bool
    func validatePasswordChangeInputs(previous: String?, new: String?, confirm: String?) -> Bool
}

class UserAccountController: UserAccountService {
    var isSignedIn: Bool = false
    
    func validateSignInInputs(email: String?, password: String?) -> Bool {
        guard
            let email = email, email.isEmpty == false,
            let password = password, password.isEmpty == false
        else {
            return false
        }
        
        return true
    }
    
    func validatePasswordChangeInputs(previous: String?, new: String?, confirm: String?) -> Bool {
        guard
            let previous = previous, previous.isEmpty == false,
            let new = new, new.isEmpty == false,
            let confirm = confirm, confirm.isEmpty == false
        else {
            return false
        }
        
        return true
    }
}

