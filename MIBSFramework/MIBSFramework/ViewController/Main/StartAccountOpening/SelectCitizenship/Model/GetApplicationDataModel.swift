//
//  GetApplicationDataModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 28/06/22.
//

import Foundation
//import ObjectMapper

class GetApplicationDataModel: Mappable {
    
    var status: Int = 0
    var message: String = ""
    var Response: GetApplicationDataResponse?
    
    //Error
    var error: String = ""
    var hint: String = ""
    
    init() {
    }

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        Response <- map["Response"]
        
        //Error
        error <- map["error"]
        hint <- map["hint"]
    }
}
class GetApplicationDataResponse: Mappable {
    
    var Body: GetApplicationDataBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
        
    }
}

class GetApplicationDataBody: Mappable {
    
    var Result: GetApplicationDataResult?
    var status: String = ""
    var statusMsg: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Result <- map["Result"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}

class GetApplicationDataResult: Mappable {
    var application_preview_link: String = ""
    
    var account_number_c: Any?
    var account_opening_check_c: Any?
    var account_type_c: Any?
    var accountcurrency_c: Any?
    var additional_documents_c: Any?
    var additional_info_required_c: Any?
    var address_number_fatca_w8_c: Any?
    var address_number_w9_c: Any?
    var address_verification_c: Any?
    var addressline1_c: Any?
    var addressline2_c: Any?
    var addressline3_c: Any?
    var aml_check_verfied_c: Any?
    var aml_check_verified_c: Any?
    var amount: Any?
    var amount_usdollar: Any?
    var app_current_step_c: Any?
    var application_status_c: Any?
    var application_submitted_date_c: Any?
    var apt_suite_no_facta_w8_c: Any?
    var apt_suite_no_facta_w9_c: Any?
    var area_c: Any?
    var assigned_user_id: Any?
    var bd_caution_flag_c: Any?
    var blacklist_check_verified_c: Any?
    var branch_c: Any?
    var branch_debit_card_c: Any?
    var campaign_id: Any?
    var cbo_caution_check_c: Any?
    var cboblacklistflag_c: Any?
    var cif_account_already_exists_c: Any?
    var cif_approve_check_c: Any?
    var cif_creation_c: Any?
    var cif_creation_check_c: Any?
    var cif_number_c: Any?
    var cif_type_c: Any?
    var cif_validate_check_c: Any?
    var citizenship_c: Any?
    var city_c: Any?
    var city_facta_w9_c: Any?
    var city_fatca_w8_c: Any?
    var city_of_birth_c: Any?
    var civil_id_c: Any?
    var civil_id_expiry_date_c: Any?
    var collecting_from_branch_c: Any?
    var communication_preference_c: Any?
    var confirm_login_password_c: Any?
    var confirm_transaction_password_c: Any?
    var contact_time_preference_c: Any?
    var copy_of_cr_c: Any?
    var country_facta_w8_c: Any?
    var country_of_birth_c: Any?
    var country_of_citizenship_w8_c: Any?
    var country_of_residence_c: Any?
    var country_of_tax_residence2_c: Any?
    var country_of_tax_residence3_c: Any?
    var country_of_tax_residence_crs_c: Any?
    var country_to_send_remittances_c: Any?
    var countryto_receive_remittance_c: Any?
    var cra_level_c: Any?
    var created_by: Any?
    var currency_id: Any?
    var customer_type_c: Any?
    var date_closed: Any?
    var date_entered: Any?
    var date_modified: Any?
    var date_modified_mobile_c: Any?
    var date_of_birth_c: Any?
    var datetime_veryhighrisk_c: Any?
    var debit_card_address_c: Any?
    var debit_card_city_c: Any?
    var debit_card_collection_c: Any?
    var debit_card_datetime_c: Any?
    var debit_card_flat_villa_no_c: Any?
    var debit_card_issued_c: Any?
    var debit_card_requested_by_c: Any?
    var debit_card_requested_c: Any?
    var debit_card_state_c: Any?
    var debit_card_street_name_c: Any?
    var debit_card_zipcode_c: Any?
    var dedupe_check_verified_c: Any?
    var deleted: Any?
    var deleted_from_mobileapp_c: Any?
    var delivery_to_me_c: Any?
    var description: Any?
    var education_level_c: Any?
    var email_address_c: Any?
    var employer_name_c: Any?
    var employment_letter_c: Any?
    var employment_sector_c: Any?
    var employment_status_c: Any?
    var escalation_check_c: Any?
    var escalation_flag_c: Any?
    var expected_credit_amount_omr_c: Any?
    var expected_creditamt_flagcode_c: Any?
    var expected_debit_amount_omr_c: Any?
    var expected_debitamt_flagcode_c: Any?
    var expected_no_of_credit_trans_c: Any?
    var expected_no_of_debit_trans_c: Any?
    var expected_purpose_receive2_c: Any?
    var expected_purpose_receive3_c: Any?
    var expected_purpose_receive_c: Any?
    var expected_purpose_send2_c: Any?
    var expected_purpose_send3_c: Any?
    var expected_purpose_send_c: Any?
    var fatca_classification_c: Any?
    var fatca_crs_update_c: Any?
    var fatca_update_check_c: Any?
    var fcm_playerid_c: Any?
    var federal_tax_classification_c: Any?
    var field_change_c: Any?
    var first_name_c: Any?
    var foreign_tax_id_number_w8_c: Any?
    var full_name_c: Any?
    var gender_c: Any?
    var have_other_source_of_income_c: Any?
    var id: Any?
    var id_c: Any?
    var id_type_c: Any?
    var imal_caution_flag_c: Any?
    var imalblacklistflag_c: Any?
    var income_amount_c: Any?
    var industry_type_c: Any?
    var is_crs_c: Any?
    var is_pep_associate_c: Any?
    var is_pep_c: Any?
    var is_us_account_holder_c: Any?
    var is_us_born_c: Any?
    var kiosk_location_c: Any?
    var langpreference_c: Any?
    var last_name_c: Any?
    var lead_source: Any?
    var liveness_check_verified_c: Any?
    var liveness_facial_match_c: Any?
    var login_password_c: Any?
    var mailing_address_number_w8_c: Any?
    var mailing_address_same_w8_c: Any?
    var mailing_apt_suite_no_w8_c: Any?
    var mailing_city_fatca_w8_c: Any?
    var mailing_city_w8_c: Any?
    var mailing_country_fatca_w8_c: Any?
    var mailing_postal_code_fatca_w8_c: Any?
    var mailing_state_fatca_w8_c: Any?
    var mailing_street_fatca_w8_c: Any?
    var main_registered_activities_c: Any?
    var maisarah_staff_number_c: Any?
    var marital_status_c: Any?
    var mobile_id_c: Any?
    var mobile_notification_status_c: Any?
    var mobile_number_c: Any?
    var mobile_offline_unique_id_c: Any?
    var mobile_verified_c: Any?
    var mode_of_statement_delivery_c: Any?
    var modified_user_id: Any?
    var monthly_income_c: Any?
    var monthly_income_level_c: Any?
    var monthly_income_range_c: Any?
    var monthly_incomerange_flagcode_c: Any?
    var monthly_sales_turnover_c: Any?
    var name: Any?
    var name_fatca_w8_c: Any?
    var name_fatca_w9_c: Any?
    var name_of_business_c: Any?
    var name_of_fund_provider_c: Any?
    var name_of_the_pep_c: Any?
    var nationality_c: Any?
    var nationality_of_pep_c: Any?
    var need_debit_card_c: Any?
    var need_mobile_banking_c: Any?
    var next_step: Any?
    var occupation_c: Any?
    var occupation_of_fund_provider_c: Any?
    var only_digital_card_c: Any?
    var opportunities_scoring_c: Any?
    var opportunity_attachments_c: Any?
    var opportunity_documents_c: Any?
    var opportunity_type: Any?
    var other_mode_of_transaction_c: Any?
    var other_purpose_of_account_c: Any?
    var other_resident_country_c: Any?
    var other_sources_of_funds_c: Any?
    var others_c: Any?
    var passport_expiry_date_c: Any?
    var passport_number_c: Any?
    var pension_amount_c: Any?
    var pension_amount_pensioner_c: Any?
    var percentage_of_ownership_c: Any?
    var photo_of_customer_holding_id_c: Any?
    var position_of_pep_c: Any?
    var preferred_by_maisarah_c: Any?
    var printing_from_kiosk_c: Any?
    var probability: Any?
    var profession_c: Any?
    var proof_of_address_doctype_c: Any?
    var purpose_of_account_opening_c: Any?
    var reason_for_lost_c: Any?
    var reason_if_no_taxpayerid_crs2_c: Any?
    var reason_if_no_taxpayerid_crs3_c: Any?
    var reason_if_no_taxpayerid_crs_c: Any?
    var receive_remittance_country2_c: Any?
    var receive_remittance_country3_c: Any?
    var record_source_c: Any?
    var record_updated_place_c: Any?
    var reference_number_w8_c: Any?
    var relation_with_funds_provider_c: Any?
    var relationship_with_the_pep_c: Any?
    var resident_country_c: Any?
    var resident_house_no_c: Any?
    var resident_po_box_c: Any?
    var resident_postal_code_c: Any?
    var resident_status_c: Any?
    var residential_status_c: Any?
    var salary_income_c: Any?
    var salary_income_flagcode_c: Any?
    var sales_stage: Any?
    var salutation_c: Any?
    var send_remittance_country2_c: Any?
    var send_remittance_country3_c: Any?
    var service_delivery_method_c: Any?
    var sla_hold_c: Any?
    var source_of_wealth_of_pep_c: Any?
    var sources_of_fund_c: Any?
    var sources_of_wealth_c: Any?
    var specify_other_wealth_source_c: Any?
    var specify_source_of_income_c: Any?
    var state_facta_w9_c: Any?
    var state_fatca_w8_c: Any?
    var street_fatca_w8_c: Any?
    var street_number_facta_w9_c: Any?
    var test_usdollar_c: Any?
    var tin2_c: Any?
    var tin3_c: Any?
    var tin_c: Any?
    var totalcifs_blacklist_mw_api_c: Any?
    var transaction_password_c: Any?
    var type_of_pep_c: Any?
    var us_taxpayer_id_fatca_w8_c: Any?
    var ustaxpayer_id_fatca_w9_c: Any?
    var usual_mode_of_transactions_c: Any?
    var videokyc_verfied_c: Any?
    var zip_code_facta_w9_c: Any?
    var zip_code_w8_c: Any?
    var liveness_attempts_done_c: Any?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        application_preview_link <- map["application_preview_link"]
        
        account_number_c <- map["account_number_c"]
        account_opening_check_c <- map["account_opening_check_c"]
        account_type_c <- map["account_type_c"]
        accountcurrency_c <- map["accountcurrency_c"]
        additional_documents_c <- map["additional_documents_c"]
        additional_info_required_c <- map["additional_info_required_c"]
        address_number_fatca_w8_c <- map["address_number_fatca_w8_c"]
        address_number_w9_c <- map["address_number_w9_c"]
        address_verification_c <- map["address_verification_c"]
        addressline1_c <- map["addressline1_c"]
        addressline2_c <- map["addressline2_c"]
        addressline3_c <- map["addressline3_c"]
        aml_check_verfied_c <- map["aml_check_verfied_c"]
        aml_check_verified_c <- map["aml_check_verified_c"]
        amount <- map["amount"]
        amount_usdollar <- map["amount_usdollar"]
        app_current_step_c <- map["app_current_step_c"]
        application_status_c <- map["application_status_c"]
        application_submitted_date_c <- map["application_submitted_date_c"]
        apt_suite_no_facta_w8_c <- map["apt_suite_no_facta_w8_c"]
        apt_suite_no_facta_w9_c <- map["apt_suite_no_facta_w9_c"]
        area_c <- map["area_c"]
        assigned_user_id <- map["assigned_user_id"]
        bd_caution_flag_c <- map["bd_caution_flag_c"]
        blacklist_check_verified_c <- map["blacklist_check_verified_c"]
        branch_c <- map["branch_c"]
        branch_debit_card_c <- map["branch_debit_card_c"]
        campaign_id <- map["campaign_id"]
        cbo_caution_check_c <- map["cbo_caution_check_c"]
        cboblacklistflag_c <- map["cboblacklistflag_c"]
        cif_account_already_exists_c <- map["cif_account_already_exists_c"]
        cif_approve_check_c <- map["cif_approve_check_c"]
        cif_creation_c <- map["cif_creation_c"]
        cif_creation_check_c <- map["cif_creation_check_c"]
        cif_number_c <- map["cif_number_c"]
        cif_type_c <- map["cif_type_c"]
        cif_validate_check_c <- map["cif_validate_check_c"]
        citizenship_c <- map["citizenship_c"]
        city_c <- map["city_c"]
        city_facta_w9_c <- map["city_facta_w9_c"]
        city_fatca_w8_c <- map["city_fatca_w8_c"]
        city_of_birth_c <- map["city_of_birth_c"]
        civil_id_c <- map["civil_id_c"]
        civil_id_expiry_date_c <- map["civil_id_expiry_date_c"]
        collecting_from_branch_c <- map["collecting_from_branch_c"]
        communication_preference_c <- map["communication_preference_c"]
        confirm_login_password_c <- map["confirm_login_password_c"]
        confirm_transaction_password_c <- map["confirm_transaction_password_c"]
        contact_time_preference_c <- map["contact_time_preference_c"]
        copy_of_cr_c <- map["copy_of_cr_c"]
        country_facta_w8_c <- map["country_facta_w8_c"]
        country_of_birth_c <- map["country_of_birth_c"]
        country_of_citizenship_w8_c <- map["country_of_citizenship_w8_c"]
        country_of_residence_c <- map["country_of_residence_c"]
        country_of_tax_residence2_c <- map["country_of_tax_residence2_c"]
        country_of_tax_residence3_c <- map["country_of_tax_residence3_c"]
        country_of_tax_residence_crs_c <- map["country_of_tax_residence_crs_c"]
        country_to_send_remittances_c <- map["country_to_send_remittances_c"]
        countryto_receive_remittance_c <- map["countryto_receive_remittance_c"]
        cra_level_c <- map["cra_level_c"]
        created_by <- map["created_by"]
        currency_id <- map["currency_id"]
        customer_type_c <- map["customer_type_c"]
        date_closed <- map["date_closed"]
        date_entered <- map["date_entered"]
        date_modified <- map["date_modified"]
        date_modified_mobile_c <- map["date_modified_mobile_c"]
        date_of_birth_c <- map["date_of_birth_c"]
        datetime_veryhighrisk_c <- map["datetime_veryhighrisk_c"]
        debit_card_address_c <- map["debit_card_address_c"]
        debit_card_city_c <- map["debit_card_city_c"]
        debit_card_collection_c <- map["debit_card_collection_c"]
        debit_card_datetime_c <- map["debit_card_datetime_c"]
        debit_card_flat_villa_no_c <- map["debit_card_flat_villa_no_c"]
        debit_card_issued_c <- map["debit_card_issued_c"]
        debit_card_requested_by_c <- map["debit_card_requested_by_c"]
        debit_card_requested_c <- map["debit_card_requested_c"]
        debit_card_state_c <- map["debit_card_state_c"]
        debit_card_street_name_c <- map["debit_card_street_name_c"]
        debit_card_zipcode_c <- map["debit_card_zipcode_c"]
        dedupe_check_verified_c <- map["dedupe_check_verified_c"]
        deleted <- map["deleted"]
        deleted_from_mobileapp_c <- map["deleted_from_mobileapp_c"]
        delivery_to_me_c <- map["delivery_to_me_c"]
        description <- map["description"]
        education_level_c <- map["education_level_c"]
        email_address_c <- map["email_address_c"]
        employer_name_c <- map["employer_name_c"]
        employment_letter_c <- map["employment_letter_c"]
        employment_sector_c <- map["employment_sector_c"]
        employment_status_c <- map["employment_status_c"]
        escalation_check_c <- map["escalation_check_c"]
        escalation_flag_c <- map["escalation_flag_c"]
        expected_credit_amount_omr_c <- map["expected_credit_amount_omr_c"]
        expected_creditamt_flagcode_c <- map["expected_creditamt_flagcode_c"]
        expected_debit_amount_omr_c <- map["expected_debit_amount_omr_c"]
        expected_debitamt_flagcode_c <- map["expected_debitamt_flagcode_c"]
        expected_no_of_credit_trans_c <- map["expected_no_of_credit_trans_c"]
        expected_no_of_debit_trans_c <- map["expected_no_of_debit_trans_c"]
        expected_purpose_receive2_c <- map["expected_purpose_receive2_c"]
        expected_purpose_receive3_c <- map["expected_purpose_receive3_c"]
        expected_purpose_receive_c <- map["expected_purpose_receive_c"]
        expected_purpose_send2_c <- map["expected_purpose_send2_c"]
        expected_purpose_send3_c <- map["expected_purpose_send3_c"]
        expected_purpose_send_c <- map["expected_purpose_send_c"]
        fatca_classification_c <- map["fatca_classification_c"]
        fatca_crs_update_c <- map["fatca_crs_update_c"]
        fatca_update_check_c <- map["fatca_update_check_c"]
        fcm_playerid_c <- map["fcm_playerid_c"]
        federal_tax_classification_c <- map["federal_tax_classification_c"]
        field_change_c <- map["field_change_c"]
        first_name_c <- map["first_name_c"]
        foreign_tax_id_number_w8_c <- map["foreign_tax_id_number_w8_c"]
        full_name_c <- map["full_name_c"]
        gender_c <- map["gender_c"]
        have_other_source_of_income_c <- map["have_other_source_of_income_c"]
        id <- map["id"]
        id_c <- map["id_c"]
        id_type_c <- map["id_type_c"]
        imal_caution_flag_c <- map["imal_caution_flag_c"]
        imalblacklistflag_c <- map["imalblacklistflag_c"]
        income_amount_c <- map["income_amount_c"]
        industry_type_c <- map["industry_type_c"]
        is_crs_c <- map["is_crs_c"]
        is_pep_associate_c <- map["is_pep_associate_c"]
        is_pep_c <- map["is_pep_c"]
        is_us_account_holder_c <- map["is_us_account_holder_c"]
        is_us_born_c <- map["is_us_born_c"]
        kiosk_location_c <- map["kiosk_location_c"]
        langpreference_c <- map["langpreference_c"]
        last_name_c <- map["last_name_c"]
        lead_source <- map["lead_source"]
        liveness_check_verified_c <- map["liveness_check_verified_c"]
        liveness_facial_match_c <- map["liveness_facial_match_c"]
        login_password_c <- map["login_password_c"]
        mailing_address_number_w8_c <- map["mailing_address_number_w8_c"]
        mailing_address_same_w8_c <- map["mailing_address_same_w8_c"]
        mailing_apt_suite_no_w8_c <- map["mailing_apt_suite_no_w8_c"]
        mailing_city_fatca_w8_c <- map["mailing_city_fatca_w8_c"]
        mailing_city_w8_c <- map["mailing_city_w8_c"]
        mailing_country_fatca_w8_c <- map["mailing_country_fatca_w8_c"]
        mailing_postal_code_fatca_w8_c <- map["mailing_postal_code_fatca_w8_c"]
        mailing_state_fatca_w8_c <- map["mailing_state_fatca_w8_c"]
        mailing_street_fatca_w8_c <- map["mailing_street_fatca_w8_c"]
        main_registered_activities_c <- map["main_registered_activities_c"]
        maisarah_staff_number_c <- map["maisarah_staff_number_c"]
        marital_status_c <- map["marital_status_c"]
        mobile_id_c <- map["mobile_id_c"]
        mobile_notification_status_c <- map["mobile_notification_status_c"]
        mobile_number_c <- map["mobile_number_c"]
        mobile_offline_unique_id_c <- map["mobile_offline_unique_id_c"]
        mobile_verified_c <- map["mobile_verified_c"]
        mode_of_statement_delivery_c <- map["mode_of_statement_delivery_c"]
        modified_user_id <- map["modified_user_id"]
        monthly_income_c <- map["monthly_income_c"]
        monthly_income_level_c <- map["monthly_income_level_c"]
        monthly_income_range_c <- map["monthly_income_range_c"]
        monthly_incomerange_flagcode_c <- map["monthly_incomerange_flagcode_c"]
        monthly_sales_turnover_c <- map["monthly_sales_turnover_c"]
        name <- map["name"]
        name_fatca_w8_c <- map["name_fatca_w8_c"]
        name_fatca_w9_c <- map["name_fatca_w9_c"]
        name_of_business_c <- map["name_of_business_c"]
        name_of_fund_provider_c <- map["name_of_fund_provider_c"]
        name_of_the_pep_c <- map["name_of_the_pep_c"]
        nationality_c <- map["nationality_c"]
        nationality_of_pep_c <- map["nationality_of_pep_c"]
        need_debit_card_c <- map["need_debit_card_c"]
        need_mobile_banking_c <- map["need_mobile_banking_c"]
        next_step <- map["next_step"]
        occupation_c <- map["occupation_c"]
        occupation_of_fund_provider_c <- map["occupation_of_fund_provider_c"]
        only_digital_card_c <- map["only_digital_card_c"]
        opportunities_scoring_c <- map["opportunities_scoring_c"]
        opportunity_attachments_c <- map["opportunity_attachments_c"]
        opportunity_documents_c <- map["opportunity_documents_c"]
        opportunity_type <- map["opportunity_type"]
        other_mode_of_transaction_c <- map["other_mode_of_transaction_c"]
        other_purpose_of_account_c <- map["other_purpose_of_account_c"]
        other_resident_country_c <- map["other_resident_country_c"]
        other_sources_of_funds_c <- map["other_sources_of_funds_c"]
        others_c <- map["others_c"]
        passport_expiry_date_c <- map["passport_expiry_date_c"]
        passport_number_c <- map["passport_number_c"]
        pension_amount_c <- map["pension_amount_c"]
        pension_amount_pensioner_c <- map["pension_amount_pensioner_c"]
        percentage_of_ownership_c <- map["percentage_of_ownership_c"]
        photo_of_customer_holding_id_c <- map["photo_of_customer_holding_id_c"]
        position_of_pep_c <- map["position_of_pep_c"]
        preferred_by_maisarah_c <- map["preferred_by_maisarah_c"]
        printing_from_kiosk_c <- map["printing_from_kiosk_c"]
        probability <- map["probability"]
        profession_c <- map["profession_c"]
        proof_of_address_doctype_c <- map["proof_of_address_doctype_c"]
        purpose_of_account_opening_c <- map["purpose_of_account_opening_c"]
        reason_for_lost_c <- map["reason_for_lost_c"]
        reason_if_no_taxpayerid_crs2_c <- map["reason_if_no_taxpayerid_crs2_c"]
        reason_if_no_taxpayerid_crs3_c <- map["reason_if_no_taxpayerid_crs3_c"]
        reason_if_no_taxpayerid_crs_c <- map["reason_if_no_taxpayerid_crs_c"]
        receive_remittance_country2_c <- map["receive_remittance_country2_c"]
        receive_remittance_country3_c <- map["receive_remittance_country3_c"]
        record_source_c <- map["record_source_c"]
        record_updated_place_c <- map["record_updated_place_c"]
        reference_number_w8_c <- map["reference_number_w8_c"]
        relation_with_funds_provider_c <- map["relation_with_funds_provider_c"]
        relationship_with_the_pep_c <- map["relationship_with_the_pep_c"]
        resident_country_c <- map["resident_country_c"]
        resident_house_no_c <- map["resident_house_no_c"]
        resident_po_box_c <- map["resident_po_box_c"]
        resident_postal_code_c <- map["resident_postal_code_c"]
        resident_status_c <- map["resident_status_c"]
        residential_status_c <- map["residential_status_c"]
        salary_income_c <- map["salary_income_c"]
        salary_income_flagcode_c <- map["salary_income_flagcode_c"]
        sales_stage <- map["sales_stage"]
        salutation_c <- map["salutation_c"]
        send_remittance_country2_c <- map["send_remittance_country2_c"]
        send_remittance_country3_c <- map["send_remittance_country3_c"]
        service_delivery_method_c <- map["service_delivery_method_c"]
        sla_hold_c <- map["sla_hold_c"]
        source_of_wealth_of_pep_c <- map["source_of_wealth_of_pep_c"]
        sources_of_fund_c <- map["sources_of_fund_c"]
        sources_of_wealth_c <- map["sources_of_wealth_c"]
        specify_other_wealth_source_c <- map["specify_other_wealth_source_c"]
        specify_source_of_income_c <- map["specify_source_of_income_c"]
        state_facta_w9_c <- map["state_facta_w9_c"]
        state_fatca_w8_c <- map["state_fatca_w8_c"]
        street_fatca_w8_c <- map["street_fatca_w8_c"]
        street_number_facta_w9_c <- map["street_number_facta_w9_c"]
        test_usdollar_c <- map["test_usdollar_c"]
        tin2_c <- map["tin2_c"]
        tin3_c <- map["tin3_c"]
        tin_c <- map["tin_c"]
        totalcifs_blacklist_mw_api_c <- map["totalcifs_blacklist_mw_api_c"]
        transaction_password_c <- map["transaction_password_c"]
        type_of_pep_c <- map["type_of_pep_c"]
        us_taxpayer_id_fatca_w8_c <- map["us_taxpayer_id_fatca_w8_c"]
        ustaxpayer_id_fatca_w9_c <- map["ustaxpayer_id_fatca_w9_c"]
        usual_mode_of_transactions_c <- map["usual_mode_of_transactions_c"]
        videokyc_verfied_c <- map["videokyc_verfied_c"]
        zip_code_facta_w9_c <- map["zip_code_facta_w9_c"]
        zip_code_w8_c <- map["zip_code_w8_c"]
        liveness_attempts_done_c <- map["liveness_attempts_done_c"]
        
    }
}
