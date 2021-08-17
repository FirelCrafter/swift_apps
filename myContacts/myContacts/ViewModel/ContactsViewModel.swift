//
//  ContactsViewModel.swift
//  myContacts
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import SwiftUI
import Contacts

final class ContactsViewModel: ObservableObject {
    
    @Published var contactList: [Contact] = []
    @Published var permissionsError: PermissionsError? = .none
    
    init() {
        permissions()
    }
    
    func openSettings() {
        permissionsError = .none
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {UIApplication.shared.open(settingsURL)}
    }
    
    private func getContacts() {
        Contact.fetchData { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(let fetchedContacts): DispatchQueue.main.async {
                self.contactList = fetchedContacts.sorted(by: { $0.lastName < $1.lastName })
            }
            case .failure(let err):
                self.permissionsError = .fetchError(err)
            }
        }
    }
    
    private func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        
        case .authorized:
            getContacts()
        
        case .notDetermined, .restricted, .denied:
            CNContactStore().requestAccess(for: .contacts) { [weak self] granted, err in
                
                guard let self = self else { return }
                
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    DispatchQueue.main.async {
                        self.permissionsError = .userError
                    }
                }
            }
        default:
            fatalError("Что-то пошло не так...")
        }
    }
    
}
