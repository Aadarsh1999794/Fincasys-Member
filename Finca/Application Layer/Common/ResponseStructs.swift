//
//  ResponseStructs.swift
//  Finca
//
//  Created by harsh panchal on 12/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import Foundation
struct SliderResponse: Codable {
    let status: String!
    let slider: [Slider]!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case slider = "slider"
        case message = "message"
    }
}

// MARK: - Slider
struct Slider: Codable {
    let sliderImageName: String!
    let sliderStatus: String!
    let societyID: String!
    let appSliderID: String!
    
    enum CodingKeys: String, CodingKey {
        case sliderImageName = "slider_image_name"
        case sliderStatus = "slider_status"
        case societyID = "society_id"
        case appSliderID = "app_slider_id"
    }
}
struct BillResponse: Codable {
    let bill: [Bill_Model]!
    let message: String!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case bill = "bill"
        case message = "message"
        case status = "status"
    }
}

// MARK: - Bill
struct Bill_Model: Codable {
    let receiveBillStatus: String!
    let billMasterID: String!
    let billGenrateDate: String!
    let billAmount: String!
    let unitPrice: String!
    let autoBillNumber: String!
    let receiveBillID: String!
    let billPaymentType: String!
    let billName: String!
    let billDescription: String!
    let billEndDate: String!
    let unitPhoto: String!
    let receiveBillReceiptPhoto: String!
    let noOfUnit: String!
    let billPaymentDate: String!
    let balancesheetID: String!
    
    enum CodingKeys: String, CodingKey {
        case receiveBillStatus = "receive_bill_status"
        case billMasterID = "bill_master_id"
        case billGenrateDate = "bill_genrate_date"
        case billAmount = "bill_amount"
        case unitPrice = "unit_price"
        case autoBillNumber = "auto_bill_number"
        case receiveBillID = "receive_bill_id"
        case billPaymentType = "bill_payment_type"
        case billName = "bill_name"
        case billDescription = "bill_description"
        case billEndDate = "bill_end_date"
        case unitPhoto = "unit_photo"
        case receiveBillReceiptPhoto = "receive_bill_receipt_photo"
        case noOfUnit = "no_of_unit"
        case billPaymentDate = "bill_payment_date"
        case balancesheetID = "balancesheet_id"
    }
}
struct MaintainanceResponse: Codable {
    let message: String!
    let maintenance: [Maintenance_Model]!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case maintenance = "maintenance"
        case status = "status"
    }
}

// MARK: - Maintenance
struct Maintenance_Model: Codable {
    let receiveMaintenanceDate: String!
    let balancesheetID: String!
    let createdDate: String!
    let endDate: String!
    let receiveMaintenanceID: String!
    let maintenanceDescription: String!
    let maintenanceName: String!
    let receiveMaintenanceStatus: String!
    let maintenceAmount: String!
    
    enum CodingKeys: String, CodingKey {
        case receiveMaintenanceDate = "receive_maintenance_date"
        case balancesheetID = "balancesheet_id"
        case createdDate = "created_date"
        case endDate = "end_date"
        case receiveMaintenanceID = "receive_maintenance_id"
        case maintenanceDescription = "maintenance_description"
        case maintenanceName = "maintenance_name"
        case receiveMaintenanceStatus = "receive_maintenance_status"
        case maintenceAmount = "maintence_amount"
    }
}

struct VisitorResponse: Codable {
    let status: String!
    let visitor: [Visitor_Model]!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case visitor = "visitor"
        case message = "message"
    }
}
struct Visitor_Model: Codable {
    let visitorType: String!
    let vistorNumber: String!
    let visitorMobile: String!
    let exitTime: String!
    let visitorStatus: String!
    let visitorID: String!
    let visitorName: String!
    let visitorProfile: String!
    let visitTime: String!
    let userID: String!
    let unitID: String!
    let visitDate: String!
    let societyID: String!
    let exitDate: String!
    
    enum CodingKeys: String, CodingKey {
        case visitorType = "visitor_type"
        case vistorNumber = "vistor_number"
        case visitorMobile = "visitor_mobile"
        case exitTime = "exit_time"
        case visitorStatus = "visitor_status"
        case visitorID = "visitor_id"
        case visitorName = "visitor_name"
        case visitorProfile = "visitor_profile"
        case visitTime = "visit_time"
        case userID = "user_id"
        case unitID = "unit_id"
        case visitDate = "visit_date"
        case societyID = "society_id"
        case exitDate = "exit_date"
    }
}
struct ExpectedVisitorResponse: Codable {
    let status: String!
    let visitor: [Exp_Visitor_Model]!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case visitor = "visitor"
        case message = "message"
    }
}
struct CommonResponse: Codable {
    let status: String!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
}
// MARK: - Visitor
struct Exp_Visitor_Model: Codable {
    let visitorType: String!
    let exitTime: String!
    let exitDate: String!
    let visitDate: String!
    let visitorStatus: String!
    let societyID: String!
    let vistorNumber: String!
    let visitorID: String!
    let visitorProfile: String!
    let userID: String!
    let visitorName: String!
    let unitID: String!
    let visitingReason: String!
    let visitorMobile: String!
    let visitTime: String!
    
    enum CodingKeys: String, CodingKey {
        case visitorType = "visitor_type"
        case exitTime = "exit_time"
        case exitDate = "exit_date"
        case visitDate = "visit_date"
        case visitorStatus = "visitor_status"
        case societyID = "society_id"
        case vistorNumber = "vistor_number"
        case visitorID = "visitor_id"
        case visitorProfile = "visitor_profile"
        case userID = "user_id"
        case visitorName = "visitor_name"
        case unitID = "unit_id"
        case visitingReason = "visiting_reason"
        case visitorMobile = "visitor_mobile"
        case visitTime = "visit_time"
    }
}
struct GalleryResponse: Codable {
    let status: String!
    let event: [EventModel]!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case event = "event"
        case message = "message"
    }
}

// MARK: - Event
struct EventModel: Codable {
    let eventTitle: String!
    let gallery: [GalleryModel]!
    
    enum CodingKeys: String, CodingKey {
        case eventTitle = "event_title"
        case gallery = "gallery"
    }
}

// MARK: - Gallery
struct GalleryModel: Codable {
    let galleryID: String!
    let galleryPhoto: String!
    let galleryTitle: String!
    let uploadDateTime: String!
    let societyID: String!
    let eventID: String!
    
    enum CodingKeys: String, CodingKey {
        case galleryID = "gallery_id"
        case galleryPhoto = "gallery_photo"
        case galleryTitle = "gallery_title"
        case uploadDateTime = "upload_date_time"
        case societyID = "society_id"
        case eventID = "event_id"
    }
}
struct DocumentResponse: Codable {
    let list: [DocumentModel]!
    let message: String!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
        case message = "message"
        case status = "status"
    }
}

// MARK: - List
struct DocumentModel: Codable {
    let shareWith: String!
    let documentID: String!
    let ducumentName: String!
    let documentTypeID: String!
    let ducumentDescription: String!
    let uploadeDate: String!
    let documentFile: String!
    
    enum CodingKeys: String, CodingKey {
        case shareWith = "share_with"
        case documentID = "document_id"
        case ducumentName = "ducument_name"
        case documentTypeID = "document_type_id"
        case ducumentDescription = "ducument_description"
        case uploadeDate = "uploade_date"
        case documentFile = "document_file"
    }
}
struct ElectionResponse: Codable {
    let election: [ElectionModel]!
    let status: String!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case election = "election"
        case status = "status"
        case message = "message"
    }
}

// MARK: - Election
struct ElectionModel: Codable {
    let electionDate: String!
    let electionName: String!
    let electionID: String!
    let electionStatus: String!
    let electionDescription: String!
    
    enum CodingKeys: String, CodingKey {
        case electionDate = "election_date"
        case electionName = "election_name"
        case electionID = "election_id"
        case electionStatus = "election_status"
        case electionDescription = "election_description"
    }
}
struct ElectionResultResponse: Codable {
    let result: [ResultModel]!
    let message: String!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }
}
struct ResultModel: Codable {
    let optionName: String!
    let givenVote: String!
    
    enum CodingKeys: String, CodingKey {
        case optionName = "option_name"
        case givenVote = "given_vote"
    }
}
// MARK: - VotingOptionResponse
struct VotingOptionResponse: Codable {
    let message: String!
    let votingSubmitted: String!
    let status: String!
    let option: [OptionModel]!
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case votingSubmitted = "voting_submitted"
        case status = "status"
        case option = "option"
    }
}

// MARK: - Option
struct OptionModel: Codable {
    let votingID: String!
    let optionName: String!
    let votingOptionID: String!
    let societyID: String!
    
    enum CodingKeys: String, CodingKey {
        case votingID = "voting_id"
        case optionName = "option_name"
        case votingOptionID = "voting_option_id"
        case societyID = "society_id"
    }
}
struct ComplainResponse: Codable {
    let message: String!
    let status: String!
    let complain: [ComplainModel]!
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case complain = "complain"
    }
}
// MARK: - Complain
struct ComplainModel: Codable {
    let complainReviewMsg: String!
    let complainStatus: String!
    let societyID: String!
    let complainDate: String!
    let complainAssingTo: String!
    let compalainTitle: String!
    let complainDescription: String!
    let complainID: String!
    let complainPhoto: String!
    
    enum CodingKeys: String, CodingKey {
        case complainReviewMsg = "complain_review_msg"
        case complainStatus = "complain_status"
        case societyID = "society_id"
        case complainDate = "complain_date"
        case complainAssingTo = "complain_assing_to"
        case compalainTitle = "compalain_title"
        case complainDescription = "complain_description"
        case complainID = "complain_id"
        case complainPhoto = "complain_photo"
    }
}
struct PollingResponse: Codable {
    let message: String!
    let voting: [PollingModel]!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case voting = "voting"
        case status = "status"
    }
}

// MARK: - Voting
struct PollingModel: Codable {
    let votingStatus: String!
    let votingQuestion: String!
    let votingStartDate: String!
    let votingEndDate: String!
    let societyID: String!
    let votingDescription: String!
    let votingID: String!
    
    enum CodingKeys: String, CodingKey {
        case votingStatus = "voting_status"
        case votingQuestion = "voting_question"
        case votingStartDate = "voting_start_date"
        case votingEndDate = "voting_end_date"
        case societyID = "society_id"
        case votingDescription = "voting_description"
        case votingID = "voting_id"
    }
}
struct PollingOptionResponse: Codable {
    let option: [PollingOptionModel]!
    let status: String!
    let votingSubmitted: String!
    let message: String!
    enum CodingKeys: String, CodingKey {
        case option = "option"
        case status = "status"
        case votingSubmitted = "voting_submitted"
        case message = "message"
    }
}
struct PollingOptionModel: Codable {
    let votingOptionID: String!
    let societyID: String!
    let optionName: String!
    let votingPer: String!
    let votingID: String!
    
    enum CodingKeys: String, CodingKey {
        case votingOptionID = "voting_option_id"
        case societyID = "society_id"
        case optionName = "option_name"
        case votingPer = "votingPer"
        case votingID = "voting_id"
    }
}
struct PollingResultResponse: Codable {
    let status: String!
    let message: String!
    let votingSubmitted: String!
    let result: [PollingResultModel]!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case votingSubmitted = "voting_submitted"
        case result = "result"
    }
}
struct PollingResultModel: Codable {
    let optionName: String!
    let givenVote: String!
    
    enum CodingKeys: String, CodingKey {
        case optionName = "option_name"
        case givenVote = "given_vote"
    }
}
struct BuildingDetailResponse: Codable {
    let builderName: String!
    let trialDays: String!
    let message: String!
    let builderAddress: String!
    let socieatyLogo: String!
    let noOfStaff: Int!
    let noOfPopulation: Int!
    let status: String!
    let noOfUnits: Int!
    let carCapcity: String!
    let societyAddress: String!
    let noOfBlocks: Int!
    let secretaryEmail: String!
    let secretaryMobile: String!
    let bikeCapcity: String!
    let carAllocate: String!
    let builderMobile: String!
    let societyName: String!
    let bikeAllocate: String!
    
    enum CodingKeys: String, CodingKey {
        case builderName = "builder_name"
        case trialDays = "trial_days"
        case message = "message"
        case builderAddress = "builder_address"
        case socieatyLogo = "socieaty_logo"
        case noOfStaff = "no_of_staff"
        case noOfPopulation = "no_of_population"
        case status = "status"
        case noOfUnits = "no_of_units"
        case carCapcity = "car_capcity"
        case societyAddress = "society_address"
        case noOfBlocks = "no_of_blocks"
        case secretaryEmail = "secretary_email"
        case secretaryMobile = "secretary_mobile"
        case bikeCapcity = "bike_capcity"
        case carAllocate = "car_allocate"
        case builderMobile = "builder_mobile"
        case societyName = "society_name"
        case bikeAllocate = "bike_allocate"
    }
}
// MARK: - EmergencyResponse
struct EmergencyResponse: Codable {
    let message: String!
    let status: String!
    let emergencyNumber: [EmergencyNumberModel]!
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case emergencyNumber = "emergencyNumber"
    }
}

// MARK: - EmergencyNumber
struct EmergencyNumberModel: Codable {
    let name: String!
    let designation: String!
    let mobile: String!
    let image: String!
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case designation = "designation"
        case mobile = "mobile"
        case image = "image"
    }
}
struct BalanceSheetResponse: Codable {
    let status: String!
    let balancesheet: [BalancesheetModel]!
    let cashOnHand: String!
    let message: String!
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case balancesheet = "balancesheet"
        case cashOnHand = "cash_on_hand"
        case message = "message"
    }
}

// MARK: - Balancesheet
struct BalancesheetModel: Codable {
    let balancesheetName: String!
    let balancesheetID: String!
    let currentBalance: String!
    
    enum CodingKeys: String, CodingKey {
        case balancesheetName = "balancesheet_name"
        case balancesheetID = "balancesheet_id"
        case currentBalance = "current_balance"
    }
}
struct MemberDetailResponse: Codable {
    let userId: String!
    let societyId: String!
    let userFullName: String!
    let userFirstName: String!
    let userLastName: String!
    let userMobile: String!
    let userEmail: String!
    let userIdProof: String!
    let userType: String!
    let blockId: String!
    let publicMobile: String!
    let memberDateOfBirth: String!
    let blockName: String!
    let floorName: String!
    let unitName: String!
    let unitStatus: String!
    let floorId: String!
    let unitId: String!
    let userStatus: String!
    let userProfilePic: String!
    let member: [MemberDetailModal]!
    let emergency: [MemberEmergencyModal]!
    let employmentStatus: String!
    let employmentId: String!
    let userPhone: String!
    let employmentType: String!
    let employmentDescription: String!
    let companyName: String!
    let designation: String!
    let companyAddress: String!
    let companyContactNumber: String!
    let myParking: [MyParkingModal]!
    let message: String!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case societyId = "society_id"
        case userFullName = "user_full_name"
        case userFirstName = "user_first_name"
        case userLastName = "user_last_name"
        case userMobile = "user_mobile"
        case userEmail = "user_email"
        case userIdProof = "user_id_proof"
        case userType = "user_type"
        case blockId = "block_id"
        case publicMobile = "public_mobile"
        case memberDateOfBirth = "member_date_of_birth"
        case blockName = "block_name"
        case floorName = "floor_name"
        case unitName = "unit_name"
        case unitStatus = "unit_status"
        case floorId = "floor_id"
        case unitId = "unit_id"
        case userStatus = "user_status"
        case userProfilePic = "user_profile_pic"
        case member = "member"
        case emergency = "emergency"
        case employmentStatus = "employment_status"
        case employmentId = "employment_id"
        case userPhone = "user_phone"
        case employmentType = "employment_type"
        case employmentDescription = "employment_description"
        case companyName = "company_name"
        case designation = "designation"
        case companyAddress = "company_address"
        case companyContactNumber = "company_contact_number"
        case myParking = "myParking"
        case message = "message"
        case status = "status"
    }
}

// MARK: - Emergency
struct MemberEmergencyModal: Codable {
    let emergencyContactId: String!
    let personName: String!
    let personMobile: String!
    let relationId: String!
    let relation: String!
    
    enum CodingKeys: String, CodingKey {
        case emergencyContactId = "emergencyContact_id"
        case personName = "person_name"
        case personMobile = "person_mobile"
        case relationId = "relation_id"
        case relation = "relation"
    }
}

// MARK: - Member
struct MemberDetailModal: Codable {
    let userId: String!
    let userFirstName: String!
    let userLastName: String!
    let userMobile: String!
    let userProfilePic: String!
    let memberDateOfBirth: String!
    let memberAge: String!
    let memberRelationName: String!
    let userStatus: String!
    let memberStatus: String!
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userFirstName = "user_first_name"
        case userLastName = "user_last_name"
        case userMobile = "user_mobile"
        case userProfilePic = "user_profile_pic"
        case memberDateOfBirth = "member_date_of_birth"
        case memberAge = "member_age"
        case memberRelationName = "member_relation_name"
        case userStatus = "user_status"
        case memberStatus = "member_status"
    }
}

// MARK: - MyParking
struct MyParkingModal: Codable {
    let parkingId: String!
    let societyParkingId: String!
    let blockId: String!
    let floorId: String!
    let unitId: String!
    let parkingName: String!
    let parkingType: String!
    let parkingStatus: String!
    let vehicleNo: String!
    
    enum CodingKeys: String, CodingKey {
        case parkingId = "parking_id"
        case societyParkingId = "society_parking_id"
        case blockId = "block_id"
        case floorId = "floor_id"
        case unitId = "unit_id"
        case parkingName = "parking_name"
        case parkingType = "parking_type"
        case parkingStatus = "parking_status"
        case vehicleNo = "vehicle_no"
    }
}
struct FeedResponse: Codable {
    let feed: [FeedModel]!
    let message: String!
    let status: String!
    
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
        case message = "message"
        case status = "status"
    }
}

// MARK: - Feed
struct FeedModel: Codable {
    let feedId: String!
    let societyId: String!
    let feedMsg: String!
    let userName: String!
    let blockName: String!
    let userId: String!
    let userProfilePic: String!
    let feedImg: [FeedImgModel]!
    let feedType: String!
    let modifyDate: String!
    let like: [LikeModel]!
    let likeStatus: String!
    let comment: [CommentModel]!
    let commentStatus: String!
    
    enum CodingKeys: String, CodingKey {
        case feedId = "feed_id"
        case societyId = "society_id"
        case feedMsg = "feed_msg"
        case userName = "user_name"
        case blockName = "block_name"
        case userId = "user_id"
        case userProfilePic = "user_profile_pic"
        case feedImg = "feed_img"
        case feedType = "feed_type"
        case modifyDate = "modify_date"
        case like = "like"
        case likeStatus = "like_status"
        case comment = "comment"
        case commentStatus = "comment_status"
    }
}

// MARK: - Comment
struct CommentModel: Codable {
    let commentsId: String!
    let feedId: String!
    let msg: String!
    let userName: String!
    let blockName: String!
    let userId: String!
    let modifyDate: String!
    
    enum CodingKeys: String, CodingKey {
        case commentsId = "comments_id"
        case feedId = "feed_id"
        case msg = "msg"
        case userName = "user_name"
        case blockName = "block_name"
        case userId = "user_id"
        case modifyDate = "modify_date"
    }
}

// MARK: - FeedImg
struct FeedImgModel: Codable {
    let feedImg: String!
    
    enum CodingKeys: String, CodingKey {
        case feedImg = "feed_img"
    }
}

// MARK: - Like
struct LikeModel: Codable {
    let likeId: String!
    let feedId: String!
    let userId: String!
    let userName: String!
    let blockName: String!
    let modifyDate: String!
    
    enum CodingKeys: String, CodingKey {
        case likeId = "like_id"
        case feedId = "feed_id"
        case userId = "user_id"
        case userName = "user_name"
        case blockName = "block_name"
        case modifyDate = "modify_date"
    }
}
