//
//  UserProfile.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 11/06/26.
//

import Foundation

struct UserProfile {//escopo dos dados
    var name: String
    var email: String
    var age: String
}

class UserProfileManager {

    private enum Keys { //chaves estruturadas
        static let name = "profile_name"
        static let email = "profile_email"
        static let age = "profile_age"
    }
    
    static func saveProfile(_ profile: UserProfile) {//organiza as informacoes pra salvar individualmente
        let defaults = UserDefaults.standard
        defaults.set(profile.name, forKey: Keys.name)
        defaults.set(profile.email, forKey: Keys.email)
        defaults.set(profile.age, forKey: Keys.age)
    }
    
    static func getProfile() -> UserProfile { //busca no banco de dados, passa pelas chaves e cria um objeot
        let defaults = UserDefaults.standard
        return UserProfile(
            name: defaults.string(forKey: Keys.name) ?? "",
            email: defaults.string(forKey: Keys.email) ?? "",
            age: defaults.string(forKey: Keys.age) ?? "",
        )
    }
}
