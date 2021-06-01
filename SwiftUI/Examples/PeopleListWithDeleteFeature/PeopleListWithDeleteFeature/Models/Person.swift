//
//  Person.swift
//  PeopleListWithDeleteFeature
//
//  Created by Dannian Park on 2021/05/20.
//

import UIKit

struct Person: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let image: UIImage
    let jobTitle: String
}
