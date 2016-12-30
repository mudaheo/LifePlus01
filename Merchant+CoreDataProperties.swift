//
//  Merchant+CoreDataProperties.swift
//  LifePlus
//
//  Created by Nhân Phùng on 12/29/16.
//  Copyright © 2016 Javu. All rights reserved.
//

import Foundation
import CoreData


extension Merchant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Merchant> {
        return NSFetchRequest<Merchant>(entityName: "Merchant");
    }

    @NSManaged public var address: String?
    @NSManaged public var branch: NSData?
    @NSManaged public var close: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: NSData?
    @NSManaged public var isCustomer: Bool
    @NSManaged public var keyWord: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var location: String?
    @NSManaged public var merchantDescription: String?
    @NSManaged public var merchantEmail: String?
    @NSManaged public var merchantLogo: String?
    @NSManaged public var merchantName: String?
    @NSManaged public var merchantType: String?
    @NSManaged public var open: String?
    @NSManaged public var phone: String?
    @NSManaged public var totalCampaign: Int32
    @NSManaged public var totalCampaignCoupon: Int32
    @NSManaged public var totalCompaignGift: Int32
    @NSManaged public var totalCustomer: Int32
    @NSManaged public var website: String?

}
