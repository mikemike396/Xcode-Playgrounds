import Foundation

protocol UserDefaultsManageable {
    func get(forKey key: String) -> Any?
    func set(as value: Any, forKey key: String)
    func remove(forKey key: String)
}

struct UserDefaultsManager: UserDefaultsManageable {
    let userDefaults = UserDefaults.standard
    
    func get(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
    
    func set(as value: Any, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

@propertyWrapper
struct UserDefaultsStorage<T> {
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaultsManageable
    
    init(key: String, defaultValue: T, storage: UserDefaultsManageable = UserDefaultsManager()) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    var wrappedValue: T {
        get {
            return storage.get(forKey: key) as? T ?? defaultValue
        }
        
        set {
            storage.set(as: newValue, forKey: key)
        }
    }
}

struct UserStorage {
    // MARK: UserDefaults Keys
    enum DefaultKeys: String {
        case username
    }
    
    // MARK: Private Variables
    private var userDefaultsManager: UserDefaultsManageable
    
    // MARK: Public Variables
    @UserDefaultsStorage(key: DefaultKeys.username.rawValue, defaultValue: ""/*, storage: userDefaultsManager*/)
    static var userName: String
    
    init(userDefaultsManager: UserDefaultsManageable = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: Public Functions
    func deleteKey(for key: String) {
        userDefaultsManager.remove(forKey: key)
    }
}

print("UserName: \(UserStorage.userName)")
UserStorage.userName = "123"
print("UserName: \(UserStorage.userName)")
UserStorage.userName = ""
print("UserName: \(UserStorage.userName)")
