//
//  Branch+CoreDataProperties.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import Foundation
import CoreData


extension Branch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Branch> {
        return NSFetchRequest<Branch>(entityName: "Branch");
    }

    @NSManaged public var addressBranch: String?
    @NSManaged public var idBranch: Int32
    @NSManaged public var latBranch: Double
    @NSManaged public var lngBranch: Double
    @NSManaged public var nameBranch: String?
    @NSManaged public var merchant: Merchant?
    @NSManaged public var campaign: Campaign?

}
