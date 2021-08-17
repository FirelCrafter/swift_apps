//
//  ContactModel.swift
//  myContacts
//
//  Created by Михаил Щербаков on 04/08/2021.
//

import SwiftUI
import Contacts

struct Contact: Identifiable {
    
    var id: String { contact.identifier }
    var firstName: String { contact.givenName }
    var lastName: String { contact.familyName }
    var phoneNumber: String? { contact.phoneNumbers.map(\.value).first?.stringValue }
    
    
    let contact: CNContact
    
    static func fetchData(_ completion: @escaping(Result<[Contact], Error>) -> Void) {
        let itemID = CNContactStore().defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: itemID)
        let descriptor = [
            CNContactIdentifierKey,
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey
        ] as [CNKeyDescriptor]
        
        do {
            let rawContacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: descriptor)
            completion(.success(rawContacts.map{.init(contact: $0)}))
        } catch {
            completion(.failure(error))
        }
    }
}

enum PermissionsError: Identifiable {
    var id: String { UUID().uuidString }
    case userError
    case fetchError(_: Error)
    var description: String {
        switch self {
        case .userError:
            return "Для работы приложения пожалуйста, предоставьте доступ к контактам"
        case .fetchError(let error):
            return error.localizedDescription
        }
    }
}
