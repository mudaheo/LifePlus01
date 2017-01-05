//
//  Gift+CoreDataProperties.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/5/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import Foundation
import CoreData


extension Gift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gift> {
        return NSFetchRequest<Gift>(entityName: "Gift");
    }

    @NSManaged public var descriptionGift: String?
    @NSManaged public var idGift: Int32
    @NSManaged public var imageGift: String?
    @NSManaged public var nameGift: String?
    @NSManaged public var pointPerAddGift: Int64
    @NSManaged public var rewardAmountGift: Int64
    @NSManaged public var totalAmountGift: Int64
    @NSManaged public var campaign: Campaign?

}
