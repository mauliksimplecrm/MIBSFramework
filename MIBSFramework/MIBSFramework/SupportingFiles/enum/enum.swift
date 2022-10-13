//
//  enum.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/01/22.
//

import Foundation

enum AccountType : String {
    case saving //High_yield
    case current //Current_Ac
    case prize //Savings_Ac
    
    func getValue() -> String{
        switch self {
        case .saving:
            return "saving"
        case .current:
            return "current"
        case .prize:
            return "price"
        }
    }

    func getBackendValue() -> String{
        switch self {
        case .saving:
            return "313030"
        case .current:
            return "310020"
        case .prize:
            return "313010"
        }
    }

}

enum AddonServices : String {
    case non = "non"
    case debitcard = "debitcard"
    case mobilebanking = "current"
    case both = "both"
    
    
}


enum DropDownOptionsEnum : String {
    case salutation_c = "salutation_c"
    case gender_c = "gender_c"
    case country_of_birth_c = "country_of_birth_c"
    case account_type_c = "account_type_c"
    case purpose_of_account_opening_c = "purpose_of_account_opening_c"
    case employment_status_c = "employment_status_c"
    case employment_sector_c = "employment_sector_c"
    case country_c = "country_c"
    case city_c = "city_c"
    case profession_c = "profession_c"
    case education_level_c = "education_level_c"
    case usual_mode_of_transactions_c = "usual_mode_of_transactions_c"
    case percentage_of_ownership_c = "percentage_of_ownership_c"
    case monthly_income_c = "monthly_income_c"
    case sources_of_wealth_c = "sources_of_wealth_c"
    case country_to_send_remittances_c = "country_to_send_remittances_c"
    case countryto_receive_remittance_c = "countryto_receive_remittance_c"
    case is_pep_c = "is_pep_c"
    case type_of_pep_c = "type_of_pep_c"
    case nationality_of_pep_c = "nationality_of_pep_c"
    case relationship_with_the_pep_c = "relationship_with_the_pep_c"
    case is_crs_c = "is_crs_c"
    case reason_if_no_taxpayerid_crs_c = "reason_if_no_taxpayerid_crs_c"
    case branch_c = "branch_c"
    case service_delivery_method_c = "service_delivery_method_c"
    case need_mobile_banking_c = "need_mobile_banking_c"
    case need_debit_card_c = "need_debit_card_c"
    case collecting_from_branch_c = "collecting_from_branch_c"
    case application_status_c = "application_status_c"
    case industry_type_c = "industry_type_c"
    case citizenship_c = "citizenship_c"
    case resident_status_c = "resident_status_c"
    case sources_of_fund_c = "sources_of_fund_c"
    case relation_with_funds_provider_c = "relation_with_funds_provider_c"
    case have_other_source_of_income_c = "have_other_source_of_income_c"
    case monthly_sales_turnover_c = "monthly_sales_turnover_c"
    case fatca_classification_c = "fatca_classification_c"
    case federal_tax_classification_c = "federal_tax_classification_c"
    case is_pep_associate_c = "is_pep_associate_c"
    case country_of_tax_residence_crs_c = "country_of_tax_residence_crs_c"
    case cra_level_c = "cra_level_c"
    case branch_debit_card_c = "branch_debit_card_c"
    case preferred_by_maisarah_c = "preferred_by_maisarah_c"
    case liveness_check_verified_c = "liveness_check_verified_c"
    case additional_documents_c = "additional_documents_c"
    case cif_account_already_exists_c = "cif_account_already_exists_c"
    case imal_caution_flag_c = "imal_caution_flag_c"
    case cbo_caution_flag_c = "cbo_caution_flag_c"
    case sla_hold_c = "sla_hold_c"
    case escalation_flag_c = "escalation_flag_c"
    case resident_postal_code_c = "resident_postal_code_c"
    case expected_no_of_credit_trans_c = "expected_no_of_credit_trans_c"
    case expected_no_of_debit_trans_c = "expected_no_of_debit_trans_c"
    case source_of_wealth_of_pep_c = "source_of_wealth_of_pep_c"
    case resident_country_c = "resident_country_c"
    case receive_remittance_country2_c = "receive_remittance_country2_c"
    case receive_remittance_country3_c = "receive_remittance_country3_c"
    case nationality_c = "nationality_c"
    case contact_time_preference_c = "contact_time_preference_c"
    case occupation_of_fund_provider_c = "occupation_of_fund_provider_c"
    case name_of_fund_provider_c = "name_of_fund_provider_c"
    case proof_of_address_doctype_c = "proof_of_address_doctype_c"
    case country_of_residence_c = "country_of_residence_c"
    case debit_card_collection_c = "debit_card_collection_c"
    case kiosk_location_c = "kiosk_location_c"
    case debit_card_collection_time_c = "debit_card_collection_time_c"
    
}

enum STEPS_FRONT_END_NAME: String {
    case selectAccountTypeScreen
    case selectCountryScreen
    case enterOtpScreen
    case selectCitizenshipTypeScreen
    case selectDocumentTypeScreen
    case livenessCheckScreen
    case personalInfoScreen
    case financialInfoScreen
    case regularityDeclarationScreen
    case reviewApplicationScreen
    case termsAndConditionsScreen
    case signatureUploadScreen
    case screen_user_details
    case videoCallSchedule
    case addOnServices
    case proofOfAddressScreen
    case highRiskCustomerScreen
    case veryHighRiskCustomerScreen
    case getDocumentsList
    
    func getValue() -> String{
        switch self {
        case .selectAccountTypeScreen: return "selectAccountTypeScreen"
        case .selectCountryScreen: return "selectCountryScreen"
        case .enterOtpScreen: return "enterOtpScreen"
        case .selectCitizenshipTypeScreen: return "selectCitizenshipTypeScreen"
        case .selectDocumentTypeScreen: return "selectDocumentTypeScreen"
        case .livenessCheckScreen: return "livenessCheckScreen"
        case .personalInfoScreen: return "personalInfoScreen"
        case .financialInfoScreen: return "financialInfoScreen"
        case .regularityDeclarationScreen: return "regularityDeclarationScreen"
        case .reviewApplicationScreen: return "reviewApplicationScreen"
        case .termsAndConditionsScreen: return "termsAndConditionsScreen"
        case .signatureUploadScreen: return "signatureUploadScreen"
        case .screen_user_details: return "screen_user_details"
        case .videoCallSchedule: return "videoCallSchedule"
        case .addOnServices: return "addOnServices"
        case .proofOfAddressScreen: return "proofOfAddressScreen"
        case .highRiskCustomerScreen: return "highRiskCustomerScreen"
        case .veryHighRiskCustomerScreen: return "veryHighRiskCustomerScreen"
        case .getDocumentsList: return "getDocumentsList"
            
        }
    }
}

enum operationType: String{
    case RESUME_ACCOUNT_OPEN
    case CREATE_ACCOUNT_OPEN
    case SCHEDULE_VIDEO_CALL
    case CHECK_APPLICATION_STATUS
    case ADD_ON_SERVICES
    case PROOF_OF_ADDRESS
    case HIGH_RISK_CUSTOMER
    case VERY_HIGH_RISK_CUSTOMER
    
    func getValue() -> String{
        switch self {
        case .RESUME_ACCOUNT_OPEN: return "RESUME_ACCOUNT_OPEN"
        case .CREATE_ACCOUNT_OPEN: return "CREATE_ACCOUNT_OPEN"
        case .SCHEDULE_VIDEO_CALL: return "SCHEDULE_VIDEO_CALL"
        case .CHECK_APPLICATION_STATUS: return "CHECK_APPLICATION_STATUS"
        case .ADD_ON_SERVICES: return "ADD_ON_SERVICES"
        case .PROOF_OF_ADDRESS: return "PROOF_OF_ADDRESS"
        case .HIGH_RISK_CUSTOMER: return "HIGH_RISK_CUSTOMER"
        case .VERY_HIGH_RISK_CUSTOMER: return "VERY_HIGH_RISK_CUSTOMER"
            
        }
    }
}

enum docType: String{
    case national
    case resident
    case passport
    case visa
    case gcc
    case customer_photo
    case address_proof
    case electricity_bill
    case salary_slip
    case Other
    case employment_letter
    case eSignature
    case profile_pic
    case bank_statement
    case utility_bill
    case evidence_of_property
    
    func getValue() -> String{
        switch self {
        case .national: return "national"
        case .resident: return "resident"
        case .passport: return "passport"
        case .visa: return "visa"
        case .gcc: return "gcc"
        case .customer_photo: return "customer_photo"
        case .address_proof: return "address_proof"
        case .electricity_bill: return "electricity_bill"
        case .salary_slip: return "salary_slip"
        case .Other: return "Other"
        case .employment_letter: return "employment_letter"
        case .eSignature: return "eSignature"
        case .profile_pic: return "profile_pic"
        case .bank_statement: return "bank_statement"
        case .utility_bill: return "utility_bill"
        case .evidence_of_property: return "evidence_of_property"
        }
    }
}
func docTypeBackendValue(value: String) -> String{
    switch value {
    case "national": return "National_ID"
    case "resident": return "Resident_ID"
    case "passport": return "Passport"
    case "visa": return "visa"
    case "gcc": return "GCC_National_ID"
    case "customer_photo": return "Customer_Photo"
    case "address_proof": return "Address_Proof"
    case "electricity_bill": return "electricity_bill"
    case "salary_slip": return "salary_slip"
    case "Other": return "Other"
    case "employment_letter": return "Employment_Letter"
    case "eSignature": return "eSignature"
    case "profile_pic": return "profile_pic"
    case "bank_statement": return "bank_statement"
    case "utility_bill": return "utility_bill"
    case "evidence_of_property": return "evidence_of_property"
        
    default:
       return ""
    }
}

enum viewType: String{
    case front
    case rear
    case other
    
    func getValue() -> String{
        switch self {
        case .front: return "front"
        case .rear: return "rear"
        case .other: return "other"
            
        }
    }
}



enum CitizenshipType: String{
    case non = "non"
    case omani = "Omani"
    case expatriate = "Expatriates"
    case gcc = "GCC_Nationals"
}

enum ApplicationStatus: String {
    case non = ""
    case New = "New"
    case InProgress = "InProgress"
    case OnHold = "OnHold"
    case application_submitted = "application_submitted"
    case submitted_to_compliance = "submitted_to_compliance"
    case submitted_to_headofbranches = "submitted_to_headofbranches"
    case submitted_to_headofretail = "submitted_to_headofretail"
    case Account_Created = "Account_Created"
    case middleware_api_pending = "middleware_api_pending"
    case Rejected = "Rejected"
    case Dead = "Dead"
    case Duplicate = "Duplicate"
    
    
}

enum ServiceType: String{
    case non = "non"
    case ResumeAccountOpening = "ResumeAccountOpening"
    case StartAccountOpening = "StartAccountOpening"
    case ScheduleVideoCall = "ScheduleVideoCall"
    case CheckApplicationStatus = "CheckApplicationStatus"
    case AddOnServices = "AddOnServices"
    case ProofOfAddress = "ProofOfAddress"
    case HighRiskCustomer = "HighRiskCustomer"
    case VeryHighRiskCustomer = "VeryHighRiskCustomer"
    case StartVideoCall = "StartVideoCall"
    case AllNotifications = "AllNotifications"
}


enum ScreenNameEnum{
    case mainVC
    case selectAccountTypeVC
    case selectCitizenshipVC
    case omaniCitizenshipDocVC
    case expatrIateCitizenshipDoc
    case gCCNationalsCitizenshipDocVC
    case personalInfoVC
    case financialInfoVC
    case regularityDeclVC
    case reviewApplicationVC
    case livenessCheckVC
    case failedLivenessCheckVC
    case highCustomerVC
    case veryHighCustomerVC
    case termsConditionsVC
    case addSignatureVC
    
}
