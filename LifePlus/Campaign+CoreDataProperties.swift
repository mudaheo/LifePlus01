//
//  Campaign+CoreDataProperties.swift
//  LifePlus
//
//  Created by Nhân Phùng on 1/8/17.
//  Copyright © 2017 Javu. All rights reserved.
//

import Foundation
import CoreData


extension Campaign {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Campaign> {
        return NSFetchRequest<Campaign>(entityName: "Campaign");
    }

    @NSManaged public var bannerCampaign: String?
    @NSManaged public var createAtCampaign: String?
    @NSManaged public var descriptionCampaign: String?
    @NSManaged public var distanceCampaign: Double
    @NSManaged public var endDateCampaign: String?
    @NSManaged public var groupCampaign: String?
    @NSManaged public var hasSurvey: Bool
    @NSManaged public var iDCampaign: Int32
    @NSManaged public var isLoginCampaign: Bool
    @NSManaged public var isReceiveCampaign: Bool
    @NSManaged public var nameCampaign: String?
    @NSManaged public var receiveCampaign: String?
    @NSManaged public var startDateCampaign: String?
    @NSManaged public var totalPointCampaign: Int32
    @NSManaged public var typeCampaign: String?
    @NSManaged public var byMerchant: Int32
    @NSManaged public var branchs: NSSet?
    @NSManaged public var gift: NSSet?
    @NSManaged public var memberType: NSSet?
    @NSManaged public var merchant: Merchant?

}

// MARK: Generated accessors for branchs
extension Campaign {

    @objc(addBranchsObject:)
    @NSManaged public func addToBranchs(_ value: Branch)

    @objc(removeBranchsObject:)
    @NSManaged public func removeFromBranchs(_ value: Branch)

    @objc(addBranchs:)
    @NSManaged public func addToBranchs(_ values: NSSet)

    @objc(removeBranchs:)
    @NSManaged public func removeFromBranchs(_ values: NSSet)

}

// MARK: Generated accessors for gift
extension Campaign {

    @objc(addGiftObject:)
    @NSManaged public func addToGift(_ value: Gift)

    @objc(removeGiftObject:)
    @NSManaged public func removeFromGift(_ value: Gift)

    @objc(addGift:)
    @NSManaged public func addToGift(_ values: NSSet)

    @objc(removeGift:)
    @NSManaged public func removeFromGift(_ values: NSSet)

}

// MARK: Generated accessors for memberType
extension Campaign {

    @objc(addMemberTypeObject:)
    @NSManaged public func addToMemberType(_ value: MemberType)

    @objc(removeMemberTypeObject:)
    @NSManaged public func removeFromMemberType(_ value: MemberType)

    @objc(addMemberType:)
    @NSManaged public func addToMemberType(_ values: NSSet)

    @objc(removeMemberType:)
    @NSManaged public func removeFromMemberType(_ values: NSSet)

}
