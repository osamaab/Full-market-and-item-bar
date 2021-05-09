//
//  UserDefaultsPreferencesManager.swift
//  talabyeh
//
//  Created by Hussein Work on 19/01/2021.
//  Copyright © 2021 Dominate. All rights reserved.
//

import Foundation

final class UserDefaultsPreferencesManager {
    
    static var shared: UserDefaultsPreferencesManager = UserDefaultsPreferencesManager()
    
    @ObjectStorage(key: .userType)
    var userType: UserType?
    
    @ObjectStorage(key: .didTappedSignUp)
    var didTappedSignUp: Bool?
    
    @ObjectStorage(key: .selectedCategories)
    var selectedCategories: [MainCategory]?
    
    @ObjectStorage(key: .selectedCategoryWithSelecctedSubCategory)
    var selectedCategoriesWithSelectedSubCategory: [MainCategory]?
    
    @ObjectStorage(key: .selectedSubCategories)
    var selectedSubCategories: [SubCategory]?
    
    @ObjectStorage(key: .currentCart)
    var currentCart: CartContents?
    
    @ObjectStorage(key: .language)
    var currentLanguages: Language?
}

extension UserDefaultsPreferencesManager: PreferencesManagerType {
    func set<T>(value: T, for key: PreferenceKey){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func value<T>(for key: PreferenceKey) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
}


