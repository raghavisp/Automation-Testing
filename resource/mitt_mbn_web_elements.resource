*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    Collections

Resource    config.resource
Resource    web_elements.resource
Resource    app_elements.resource
Resource    highlight.resource
Resource    mitt_mbn_xpath.resource


*** Keywords ***

Change To Mitt MBN Page
    [Documentation]    click on toggle to go to Mitt MBN Page
    Sleep  1s
    Wait Until Element Is Visible    ${mittmbn_application_entry}   1s
    Click Element    ${mittmbn_application_entry}

#Call To Agent Detected
 #   [Documentation]    incoming call from users detected in contact card
  #  Sleep    2s
   # Wait Until Element Is Visible    xpath=${mittmbn_call_detected_tile}    2s
    #Highlight Controls    ${mittmbn_call_detected_tile}    the call detected is highlighted
    #Log    Detecting an Incoming call
    #Sleep    5s

Call Active In Mitt MBN
    [Documentation]    Incoming call is active after the agent answers the call and the active call duration is lighlighted in MITT MBN
    Sleep    2s
    SeleniumLibrary.Wait Until Element Is Enabled       xpath=${mittmbn_call_active_tile}    2s
    ${activecall}       Get WebElement    xpath=${mittmbn_call_active_outline}
    Sleep    1s
    Highlight Controls    ${active_call}    Highlight triggered and cleared successfully in MITT MBN
    Log    Call is Active


Call Highlight Contact Card In Mitt MBN
    Sleep    5s
    ${contactcard_outline}=    Get WebElement     xpath=${mitt_mbn_contact_card_outline}
    Highlight Controls    ${contactcard_outline}    Highlight for contact card triggered and cleared successfully in Mitt MBN

Validate Caller Name In Mitt MBN
    [Documentation]     Caller Name of the Incoming call is validated and highlighted
    Sleep    1s
    ${caller_name}    Get Text    xpath=${mitt_mbn_caller_name}
    ${caller_element}    Get WebElement     xpath=${mitt_mbn_caller_name}
    Flash Element    ${caller_element}    caller name is highlighted
    Log    Extracted Text: ${caller_name}


Call To MittMBN Legg På
    [Documentation]    call is disconnected
    Sleep    5s
    ${leggpå_button}    Get WebElement    xpath=${mittmbn_Leggpå_outline}
    Highlight Controls    ${leggpå_button}    highlighted leggpå button
    Sleep    1s
    Click Element    xpath=${mittmbn_Leggpå}
    Log    Call Disconnected successfully in MITT MBN

Call To MittMBN Sett På Vent
    [Documentation]    call is sett på vent
    Sleep    5s
    ${settpåvent_button}    Get WebElement    xpath=${mittmbn_settpåvent_outline}
    Highlight Controls    ${settpåvent_button}    Highlight for Set På Vent triggered and cleared successfully
    Click Element    xpath=${mittmbn_settpåvent}
    Log    Call Set På Vent Successfully In MItt MBN
    Sleep    2s


Call To MittMBN Gjenoppta
    [Documentation]    call is sett på vent
    Sleep    5s
    ${gjenoppta_button}    Get WebElement    xpath=${mittmbn_gjenoppta_outline}
    Highlight Controls    ${gjenoppta_button}    Highlight for Set På Vent triggered and cleared successfully
    Click Element    xpath=${mittmbn_gjenoppta}
    Log    Call Set På Vent Successfully In MItt MBN


#Check Navn På AnroppsKØlog functions for MItt MBN
Anroplog Tab Selection and Highlight MittMBN
    [Documentation]    BedriftsKatlog Tab Selection and Highlight
    Sleep    2s
    ${bdk_tab}      Get WebElement    xpath=${mittmbn_Anropslogg_tab}
    Highlight Controls    ${bdk_tab}    Bedrifts katalog tab highlightd
    Log    Anropslog is Hilighted Successfully



SearchBox Identification Mitt MBN
    [Documentation]   SearchBox Identification And CallerName Validation
    Sleep    2s
    Wait Until Element Is Visible    ${mittmbn_searchbox_button}    timeout=2s
    Click Element    ${mittmbn_searchbox_button}
    ${akl_navn_searchbox}    Get WebElement    xpath=${mittbmn_searchbox}
    Highlight Controls    ${akl_navn_searchbox}    search box highlighted
    Log    SearchBox identified and Highlighted


CallerNumber Validation MittMBN
    [Documentation]   Validate that the caller number appears correctly in the search results.
    [Arguments]    ${PHONE_NUMBER}
    Log To Console    Number Validation
    Input Text    ${mittbmn_searchbox}    ${PHONE_NUMBER_3_S}
    Sleep    1s
    ${number_in_kølog}=    Get Text    xpath=${mitt_mbn_telephonenumber}
    Should Be Equal As Strings    ${PHONE_NUMBER_3_S}    ${number_in_kølog}
    Click Element    ${mitt_mbn_telephonenumber}
    Sleep    2s



Ringing button From Mitt MBN
    [Documentation]   identify Ring button from Anropslog
    Log To Console    Number Validation
    Get WebElement    ${mitt_mbn_ring_button}
    Wait Until Element Is Visible    ${mitt_mbn_ring_button}    timeout=7s
    Click Element    ${mitt_mbn_ring_button}
    Sleep    2s
    #Wait Until Element Is Visible    xpath=//div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"] timeout=5s
    #Click Element    xpath=    //span[normalize-space()="Lukk"]
    

CallerName Validation MittMBN
    [Documentation]   Callername valicated against rows
    ${caller_name}    SeleniumLibrary.Get Text    xpath=${mitt_mbn_caller_name}
	${Inputcallername}  ${number}  Split String  ${caller_name}  (
	Log  ${Inputcallername}   # "Move Tst At3-Ph3-4 22391307"
    Log  ${number}   # "22 39 13 07)"
    SeleniumLibrary.Input Text    ${mittbmn_searchbox}    ${Inputcallername.strip()}
    ${caller_number}=    Evaluate    "${number}".replace(')', '')
    Log  ${caller_number}
    Get WebElement    ${mittmbn_name_frm_anropslogg}
    Sleep    2s
    ${name_in_kølog}    SeleniumLibrary.Get Text    xpath=${mittmbn_name_frm_anropslogg}
    ${number_in_kølog}    Get Text    xpath=${mitt_mbn_telephonenumber}
    Should Be Equal As Strings    ${Inputcallername.strip()}    ${name_in_kølog.strip()}
    Wait Until Element Is Visible    ${mittmbn_name_frm_anropslogg}     timeout=10s
    SeleniumLibrary.Double Click Element    xpath=${mittmbn_name_frm_anropslogg}
    Sleep    3s
    Get WebElement    ${mittmbn_profile_section}
    Wait Until Element Is Visible    ${mittmbn_profile_close_dialog}    timeout=7s
    Click Element    xpath=${mittmbn_profile_close_dialog}
    Sleep    2s


Call Caller From Apropslogg
    [Documentation]   ring till en innringer i loggen- call a caller in the log
    Anroplog Tab Selection and Highlight MittMBN
    SearchBox Identification Mitt MBN
    CallerNumber Validation MittMBN    ${PHONE_NUMBER_3}
    Ringing button From Mitt MBN

Logout Sequence
    [Documentation]   logout sequence
    Sleep    4s
    Get WebElement    xpath=//mat-icon[@class="mat-icon notranslate material-icons-outlined mat-icon-no-color"]//*[name()="svg"]
    Click Element    xpath=//mat-icon[@class="mat-icon notranslate material-icons-outlined mat-icon-no-color"]//*[name()="svg"]
    Wait Until Element Is Visible    xpath=//a[normalize-space()="Logg ut"]    timeout=5s
    Get WebElement    xpath=//a[normalize-space()="Logg ut"]
    Click Element    xpath=//a[normalize-space()="Logg ut"]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Ja, avslutt"]
    Click Element    xpath=//span[normalize-space()="Ja, avslutt"]
    Sleep    5s
    Page Should Not Contain Textfield    xpath=//h1[normalize-space()="Du har blitt logget ut"]
    Log To Console    xpath=//h1[normalize-space()="Du har blitt logget ut"]


Send SMS Til en Loggen
    [Documentation]   SMS to [Documentation]  Innkommende anrop
    Wait Until Element Is Visible    xpath=//div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"]    timeout=2s
    ${snaker_label}    Get WebElement     xpath=//div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"]
    Highlight Controls    ${snaker_label}    Highlight of snaker label
    SeleniumLibrary.Wait Until Element Is Enabled    xpath=//span[normalize-space()="Avvis med SMS"]    timeout=7s
    Click Element    xpath=//span[normalize-space()="Avvis med SMS"]

Send Medling Fra MittMBN
    [Documentation]   SMS to [Documentation]  Innkommende anrop
    Wait Until Element Is Visible    xpath=//textarea[@formcontrolname='text']    timeout=3s
    Input Text    xpath=//textarea[@formcontrolname='text']    Hi, from Q via MicroSIP and so thisis the new message it is today
    Sleep    2s
    Get WebElement    xpath=//span[normalize-space()="Send"]
    Click Element    xpath=//span[normalize-space()="Send"]
    Sleep    4s