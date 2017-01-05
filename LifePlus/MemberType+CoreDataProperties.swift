//
//  MemberType+CoreDataProperties.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import Foundation
import CoreData


extension MemberType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberType> {
        return NSFetchRequest<MemberType>(entityName: "MemberType");
    }

    @NSManaged public var colorHexMemberType: String?
    @NSManaged public var descriptionMemberType: String?
    @NSManaged public var idMemberType: Int32
    @NSManaged public var imageMemberType: String?
    @NSManaged public var nameMemberType: String?
    @NSManaged public var campaign: Campaign?

}
