//
//  SmsCodeInteractor.swift
//  aimoon-main
//

final class SmsCodeInteractor: SmsCodeInteractorInputProtocol {

    weak var presenter: SmsCodeInteractorOutputProtocol?
    
    var phoneNumber: String
    var formattedPhoneNumber: String
    
    var localStorage = LocaleStorage()
    
    // MARK: - Life Cycle
    
    init(phoneNumber: String, formattedPhoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.formattedPhoneNumber = formattedPhoneNumber
    }
    
    // MARK: - Functions
    
    func auth(code: String) {
        guard let code = Int(code) else {
            print("Couldn't cast string to int")
            return
        }
        
        API.shared.auth(phoneNumber: phoneNumber, code: code).then { [weak self] result in
            self?.saveToken(result.accessToken)
            self?.getUserInfo()
        }.catch { [weak self] error in
            self?.presenter?.authDidFail(error)
        }
    }
    
    func getUserInfo() {
        API.shared.getUserInfo().then { [weak self] result in
            self?.saveUserInfo(result)
            self?.presenter?.userInfoDidReceived()
        }.catch { [weak self] error in
            self?.presenter?.userInfoRecevingDidFail(error)
        }
    }
    
    func saveToken(_ token: String) {
        localStorage.accessToken = token
    }
    
    func saveUserInfo(_ userInfo: UserInfo) {
        localStorage.userInfo = userInfo
    }

}
