*** Variables ***
#Web elements Xpath

#Launch Switchboard xpath

${txtloginhint}=    //input[@id='txtLoginHint']
${buttongo_login}=    //input[@id='btnGo']
${otp_login}=    //*[@id='app']/div[2]/div/div/form/div/label/div/input
${otpgobutton_login}=    //*[@id='app']/div[2]/div/div/form/div/label/div/button
${checkbox_login}=    //input[@id='mat-mdc-checkbox-0-input']
${dropdown_dynamic_login}=    //mat-select-trigger
${dropdown_arrow_button_click}=    //div[@class='mat-mdc-select-arrow ng-tns-c1711764913-3']//*[name()='svg']
${dropdown_option_first_element}=    //span[@class="mdc-list-item__primary-text"]//div[contains(text(),"22 39 14 20")]
${start_SB_button}=    //span[normalize-space()='Start sentralbord']

#Pause Button and resume elements
${pause_button_on_right_corner}=    //mat-icon[@class='mat-icon notranslate bigger-icon mat-icon-no-color ng-star-inserted']//*[name()='svg']
${jabtn_inside_dialog_after_pause}=    //mat-dialog-content[@class='mat-mdc-dialog-content mdc-dialog__content']
${pause_ststus_on_leftcorner}=    //div[contains(text(),"Pause")]
${resume_button_after_pause}=    //mat-icon[@class='mat-icon notranslate bigger-icon mat-icon-no-color ng-star-inserted']//*[name()='svg']
${toggle_state_inside_kø}=    //mat-icon[@class='mat-icon notranslate slider-icon mat-icon-no-color color-accent']//*[name()='svg']
${Kø_after_Pausing_Ja_Button}=    //span[normalize-space()='Ja']

#Call Elements
${check_call_exist}=    //gt-call-duration[normalize-space()="00:00"]
${active_call}=    //div[@class="active-call-title"]
${contactcard_call_detected}=    //div[@fxlayout="column"]//swb-active-call
${callername_inside_contactcard}=    //h1[@class="color-primary ng-tns-c2758229062-7"]
${callername_inside_contact_WO_pranthesis}=    //span[@class="mat-mdc-tooltip-trigger caller-name ng-tns-c2758229062-7"]
${leggpå_button_outline}=    //button[@color="warn"]//span[4]
${leggpå_button_xpath}=    //span[normalize-space()="Legg på"]
${settpåvent_button_outline}=     //button[@class="btn-on-hold wide-button mdc-button mdc-button--unelevated mat-mdc-unelevated-button ng-tns-c2758229062-7 mat-unthemed mat-mdc-button-base ng-star-inserted"]//span[@class="mat-mdc-button-touch-target"]
${settpåvent_button_xpath}=    //span[normalize-space()="Sett på vent"]
${gjenoppta_button_xpath}=    //span[normalize-space()="Gjenoppta"]
${vipbutton_xpath}=    //span[@class="mdc-button__label"]//span[contains(text(),"VIP")]
${Bedriftskatalog_xpath}=    //span[contains(text(),"Bedriftskatalog")]
${searchbox_xpath}=    //input[@placeholder="Fornavn, Etternavn, Telefonnummer, Avdeling, Adresse, Poststed"]
${telephonenumber_inside_log_row_after_search}=    //div[@title="22391307"]
${telephonenumber_to_be_highlighted}=    //div[@class="name-text ng-star-inserted"][normalize-space()="22391307"]
${profile_section_dialog}=    //div[@class="mat-mdc-dialog-inner-container mdc-dialog__container"]
${profile_section_inside_dialog}=    //div[@class="profile"]
${close_dialog_button}=    //button[@class="close-dialog-button mdc-icon-button mat-mdc-icon-button mat-unthemed mat-mdc-button-base cdk-focused cdk-program-focused"]//mat-icon[@role="img"]//*[name()="svg"]
# Hent Call elements
${identify_row_hent_call}=    //div[@class="mat-mdc-tooltip-trigger hover-link truncate-text ng-star-inserted"]
${hent_button}=    //span[normalize-space()="Hent"]
${snackbar_label}=    //div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"]
${lukk_button_snaker_label}=    //span[normalize-space()="Lukk"]
${row_hent_call_grayedout}=    //tr[@class="mat-mdc-row mdc-data-table__row cdk-row mat-mdc-tooltip-trigger ng-star-inserted grayed_out"]//div[@class="mat-mdc-tooltip-trigger truncate-text"][normalize-space()="Testkø-46nr-2"]
${second_row_identification}=    //tr[@class="mat-mdc-row mdc-data-table__row cdk-row mat-mdc-tooltip-trigger ng-star-inserted"]//div[@class="mat-mdc-tooltip-trigger truncate-text"][normalize-space()="Testkø-46nr-2"]

#Status Check Elements
${avvis_anrop_sb}=    //span[normalize-space()="Avvis"]
${telenum_inside_log_row_after_search_status_check}=    //div[contains(text(),"22 39 14 28")]
${ledig_status_indicator_sb}=    //div[@class="min-width ng-star-inserted"]//div[@class="ng-star-inserted"]//*[name()="svg"]//*[name()="circle" and contains(@fill,"#37c65d")]
${isamtale_status_indicator_sb}=    //*[name()="path" and contains(@fill,"#db3347")]
${frakoblet_status_indicator_sb}=    //*[name()="path" and contains(@fill,"#b3b1b1")]
${status_text_sb}=    //div[@class="truncate-text hover-link"]
${status_tab_text}=    //span[normalize-space()='Status']
${telephonenumber_inside_log_row_after_search_for_number}=    //div[contains(text(),"461 80 785")]
#Konsult or Sett Over
${settover_samtalen_button}=    //span[normalize-space()="Sett over"]
${konsulter_button}=    //span[normalize-space()="Konsulter"]
${Konsultermed_text_inside_banner}=    //div[normalize-space()="Konsulterer med:"]
${leggpå_button_konsult_banner}=    //div[@class="consult-actions"]//span[@class="mdc-button__label"][normalize-space()="Legg på"]



















