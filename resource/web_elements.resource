*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library    Collections
Library    Process


Resource          config.resource
Resource          web_elements_xpath.resource
Resource          app_elements.resource
Resource          highlight.resource
Resource          PhoneSCRCPY.resource

*** Keywords ***
Open Web Browser And Maximize Login
    [Documentation]    Log in to Sentralbord with Chrome browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Log    Main login page loaded successfully
    Builtin.Sleep    10s

Open Url In New Tab And Wait
    Execute JavaScript    window.open('${CRM_07}', '_blank')
    Sleep    4s
    Wait Until Page Contains    1881.no
    Sleep    4s
    Switch Window    title=Move Tst At3-Ph3-4, Fornebu, Bærum - 1881.no
    Reload Page
    Wait Until Keyword Succeeds    15s    1s    Execute JavaScript    return document.querySelector('#usercentrics-cmp-ui').shadowRoot.querySelector('#deny').click()
    #Execute javascript    return document.querySelector('#usercentrics-cmp-ui').shadowRoot.querySelector('#deny').click();
    Sleep    2s
    ${text}=    SeleniumLibrary.Get Text    xpath=//h1[normalize-space()="Move Tst At3-Ph3-4"]
    Should Be Equal As Strings    ${text}    ${EXPECTED_TEXT}
    Double Click Element    xpath=//h1[normalize-space()="Move Tst At3-Ph3-4"]

Open Url In New Tab Already Opened And Wait
    Execute JavaScript    window.open('${CRM}', '_blank')
    Sleep    5s
    Switch Window    title=Move Tst At3-Ph3-4, Fornebu, Bærum - 1881.no
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Execute JavaScript    return document.querySelector('#usercentrics-cmp-ui').shadowRoot.querySelector('#deny').click()
    Wait Until Element Is Visible    xpath=//h1[normalize-space()="Move Tst At3-Ph3-4"]    timeout=7s
    # Read and verify the text
    ${text}=    Get Text    xpath=//h1[normalize-space()="Move Tst At3-Ph3-4"]
    Should Be Equal As Strings    ${text}    ${EXPECTED_TEXT}
    # Double-click the header element
    Double Click Element    xpath=//h1[normalize-space()="Move Tst At3-Ph3-4"]


Open CRM Page In New Tab And Verify Header
    Execute JavaScript    window.open('${CRM}', '_blank')
    Sleep    5s
    # Step 4: Switch to the new window
    ${titles}=    Get Window Titles
     FOR    ${title}    IN    @{titles}
        Switch Window    title=${title}
        ${current_title}=    Get Title
        Log    Title found: ${current_title}
        Run Keyword If    '1881.no' in '${current_title}'    Exit For Loop
    END
    # Step 5: Wait and verify page content
    Wait Until Element Is Visible    xpath=//h1[contains(., "${PHONE_NUMBER_2}")]    timeout=7s
    ${header_text}=    Get Text    xpath=//h1
    Log    Header text: ${header_text}


Input LoginHint In TextBox In Login
    [Documentation]    Input agent number for logging in to kø
    Input Text    xpath=${txtloginhint}    ${LOGIN_HINT}
    Log    Login hint entered successfully
    SeleniumLibrary.Wait Until Element Is Enabled    xpath=${buttongo_login}    10s
    Click Element    xpath=${buttongo_login}
    Log    Go button clicked successfully

Open Initial MicroSip In Browser During Login
    [Documentation]    Microsip triggered for call to receive otp
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Initial Call Answer End In During Login In SB    ${MICROSIP_1_APP_NAME}

Enter OTP ON Browser Login
    [Documentation]    OTP input in the browser
    Wait Until Element Is Visible    xpath=${otp_login}    10s
    Input Text    xpath=${otp_login}    ${OTP}
    Click Element    xpath=${otpgobutton_login}
    Log    OTP confirmed successfully

CheckBox Function On Browser Login
    [Documentation]    checkbox to select the Kø number
    SeleniumLibrary.Wait Until Element Is Enabled    xpath=${checkbox_login}    10s
    ${CHECKBOX_STATE}    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    xpath=${checkbox_login}
    Run Keyword If    ${CHECKBOX_STATE} == False    Click Element    xpath=${checkbox_login}
    Log    Checkbox checked successfully

Dropdown Function On Browser And Click SB Button Login
    [Documentation]    Velg telefonnummeret du ønsker å motta kø-anrop på
    Log    Try to Select Dropdown
    Wait Until Element Is Visible    xpath=${dropdown_dynamic_login}    10s
    Click Element    xpath=${dropdown_arrow_button_click}
    Wait Until Element Is Visible    xpath=${dropdown_option_first_element}    5s
    Click Element    xpath=${dropdown_option_first_element}
    Log    First dropdown option selected
    Builtin.Sleep    2s
    Click Element    xpath=${start_SB_button}
    Log    Button clicked successfully

Handle Node Highlight And Pause Button
    [Documentation]    click on the pause button
    Builtin.Sleep    2s
    Wait Until Element Is Visible    xpath=${pause_button_on_right_corner}
    ${ELEMENT}    Get WebElement    xpath=${pause_button_on_right_corner}
    Execute JavaScript    arguments[0].style.border='3px solid red'    ARGUMENTS    ${ELEMENT}
    Click Element    xpath=${pause_button_on_right_corner}
    Log    Pause button clicked successfully

Handle Dialog Box
    [Documentation]    Notification Alert: Agent is the Last in the Queue After Pausing
    Builtin.Sleep    2s
    Wait Until Element Is Visible    xpath=${jabtn_inside_dialog_after_pause}    timeout=20 seconds
    ${dialog_text}=    Get Text    xpath=${jabtn_inside_dialog_after_pause}
    Log    Dialog Title: ${dialog_text}
    Click Element    xpath=${Kø_after_Pausing_Ja_Button}
    Log    Clicked the 'Ja' button successfully

Verify Pause Status
    [Documentation]    Pause Status Label: Highlighted Notification for Last Agent in Queue
    Builtin.Sleep    2s
    ${ELEMENT}      Get WebElement      xpath=${pause_ststus_on_leftcorner}
    ${ELEMENT_TEXT}    Get Text    xpath=${pause_ststus_on_leftcorner}
    Should Contain    ${ELEMENT_TEXT}    PAUSE
    Execute JavaScript    arguments[0].style.border='3px solid red'    ARGUMENTS    ${ELEMENT}
    Log    Pause status is visible on screen

Handle Resume Button
    [Documentation]    Resume button: clicked after validating the Pause status
    Sleep    1s
    Wait Until Element Is Visible     xpath=${resume_button_after_pause}       timeout=5 seconds
    ${ELEMENT}    Get WebElement    xpath=${resume_button_after_pause}
    Execute JavaScript    arguments[0].style.border='3px solid red'    ARGUMENTS    ${ELEMENT}
    Click Element    xpath=${resume_button_after_pause}
    Log    Resume button clicked successfully
    
Verify Toggle State
    [Documentation]    **Toggle State in the Mine Køer Section Verified: Active Queue Indicated by Green Color**
    Sleep    2s
    Wait Until Element Is Visible    xpath=${toggle_state_inside_kø}   timeout=5s
    ${ELEMENT}    Get WebElement    xpath=${toggle_state_inside_kø}
    Sleep    2s
    ${attribute_value}    SeleniumLibrary.Get Element Attribute    ${ELEMENT}    focusable
    Should Be Equal As Strings    ${attribute_value}    false
    Log    Queue is active and toggle is ON
    Sleep    2s

Call To Queue Detected
    [Documentation]    incoming call from users detected in contact card
    Sleep    2s
    Wait Until Element Is Visible    xpath=${check_call_exist}
    Log    Detecting an Incoming call
    Sleep    5s

Call Active And Highlight Contact Card
    [Documentation]    Incoming call is active after the agent answers the call and the active call duration is lighlighted.
    SeleniumLibrary.Wait Until Element Is Enabled       xpath=${active_call}
    ${call_duration_element}        Get WebElement    xpath=${active_call}
    Highlight Controls    ${call_duration_element}    Highlight triggered and cleared successfully
    Log    Call is Active
    Sleep    1s
    ${contact_card}    Get WebElement     xpath=${contactcard_call_detected}
    Highlight Controls    ${contact_card}    Highlight for contact card triggered and cleared successfully



Validate Caller Name
    [Documentation]     Caller Name of the Incoming call is validated and highlighted
    Sleep    1s
    ${caller_name}    Get Text    xpath=${callername_inside_contactcard}
    ${caller_element}    Get WebElement     xpath=${callername_inside_contactcard}
    FOR    ${i}    IN RANGE    3
        Execute JavaScript    arguments[0].style.backgroundColor='yellow'    ARGUMENTS    ${caller_element}
        Sleep    0.3s
        Execute JavaScript    arguments[0].style.backgroundColor=''    ARGUMENTS    ${caller_element}
        Sleep    0.3s
    END
    Log    Extracted Text: ${caller_name}

       
Call To Queue Legg På
    [Documentation]    call is disconnected
    Sleep    5s
    SeleniumLibrary.Wait Until Element Is Enabled    xpath=${leggpå_button_xpath}
    Sleep    1s
    Click Element    xpath=${leggpå_button_xpath}
    Log    Call Disconnected successfully



Call To Queue Sett På Vent
    [Documentation]    call is sett på vent
    Sleep    5s
    ${settpåvent_button}    Get WebElement    xpath=${settpåvent_button_outline}
    Highlight Controls    ${settpåvent_button}    Highlight for Set På Vent triggered and cleared successfully
    Click Element    xpath=${settpåvent_button_xpath}
    Log    Call Set På Vent Successfully
    
Call To Queue Gjenoppta
    [Documentation]    call to queue is gjenoppta
     Sleep    5s
    ${gjenoppta_button}    Get WebElement    xpath=${gjenoppta_button_xpath}
    Highlight Controls    ${gjenoppta_button}    Highlight for Gjenoppta triggered and cleared successfully
    Click Element    xpath=${gjenoppta_button_xpath}
    Log    Call Set På Vent Successfully

Mark VIP
    [Documentation]     VIP markering
    Sleep    2s
    Wait Until Element Is Visible    xpath=${vipbutton_xpath}    timeout=10s
    ${vip_button}       Get WebElement   xpath=${vipbutton_xpath}
    Click Element   xpath=${vipbutton_xpath}
    Run Keyword And Ignore Error    Highlight Controls    ${vip_button}     VIP Highlighted Successfully
    log     VIP Block Valiodated Successfully


Avvis Anrop
    [Documentation]    cut the call and pick up '
    Log    Avvis loop starts
    Sleep    1s
    Wait Until Element Is Visible    xpath=${avvis_anrop_sb}
    Click Element    xpath=${avvis_anrop_sb}
    Sleep    2s
    Log    Avvis Successfull


#Check Navn På AnroppsKØlog functions
BedriftsKatlog Tab Selection and Highlight
    [Documentation]    BedriftsKatlog Tab Selection and Highlight
    Sleep    2s
    ${bdk_tab}      Get WebElement    xpath=${Bedriftskatalog_xpath}
    Highlight Controls    ${bdk_tab}    Bedrifts katalog tab highlightd
    Log    Bedriftskatalog is Hilighted Successfully

SearchBox Identification And CallerName Validation
    [Documentation]   SearchBox Identification And CallerName Validation
    ${bd_navn_searchbox}    Get WebElement    xpath=${searchbox_xpath}
    Highlight Controls    ${bd_navn_searchbox}    search box highlighted
    ${caller_name}    Get Text    xpath=${callername_inside_contact_WO_pranthesis}
    ${search_texts}=    Strip String    ${caller_name}
    ${number_in_katlog}=    Get Text    xpath=${telephonenumber_inside_log_row_after_search}
    Input Text    ${bd_navn_searchbox}    ${search_texts}
    Sleep    2s
    ${caller_number}    Evaluate    '${caller_name}'.split()[-1]            # Extract only the number from caller_name
    ${number_in_katlog}    Get Text    xpath=${telephonenumber_inside_log_row_after_search}
    Should Be Equal As Strings    ${caller_number}    ${number_in_katlog}

SearchBox Identification And Input Phone Number
     [Documentation]   SearchBox Identification
     [Arguments]    ${PHONE_NUMBER}
     Sleep    2s
     ${bd_navn_searchbox}    Get WebElement    xpath=${searchbox_xpath}
     Highlight Controls    ${bd_navn_searchbox}    search box highlighted
     Sleep    1s
     Input Text    ${bd_navn_searchbox}    ${PHONE_NUMBER_3_S}
     Sleep    1s
     ${search_text}=    Get Value    ${bd_navn_searchbox}
     ${search_texts}=    Strip String    ${search_text}
     ${number_in_katlog}=    Get Text    xpath=${telenum_inside_log_row_after_search_status_check}
     ${number_in_katlogs}=    Strip String    ${number_in_katlog}
     Should Be Equal As Strings    ${search_texts}    ${number_in_katlogs}
     Sleep    5s

SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User
     [Documentation]   SearchBox Identification
     [Arguments]    ${PHONE_NUMBER}
     Sleep    2s
     ${bd_navn_searchbox}    Get WebElement    xpath=${searchbox_xpath}
     Highlight Controls    ${bd_navn_searchbox}    search box highlighted
     Sleep    1s
     Input Text    ${bd_navn_searchbox}    ${PHONE_NUMBER}
     Sleep    1s

Open Profile Dialogbox After Double Click
    [Documentation]    Open Profile Dialogbox After Double Click
    Sleep    2s
    Double Click Element    xpath=${telephonenumber_inside_log_row_after_search}
    Log    Number Double Clicked

Validate Profile Section
    [Documentation]    Validate Profile Section
    Wait Until Element Is Visible    xpath=${profile_section_dialog}       timeout=5s
    ${profile_control_inside_dialog}        Get WebElement    xpath=${profile_section_inside_dialog}
    Highlight Controls    ${profile_control_inside_dialog}    profile control is enabled

Close Profile Dialog Box
    [Documentation]    Close Profile Dialog Box
    Sleep    1s
    Wait Until Element Is Visible    xpath=${close_dialog_button}      timeout=2s
    Click Element    xpath=${close_dialog_button}
    Log    anroppsKølog executed successfully

Identify Row To Hent Call
    [Documentation]    this locates the row to hennt the call '
    Log    Hent Row identified
    Sleep    1s
    Wait Until Element Is Visible    xpath=${identify_row_hent_call}
    Sleep    2s
    Mouse Over    xpath=${identify_row_hent_call}
    Log    hent row identification is successfull

Click Hent Button
    [Documentation]    this locates the  hent button in the row
    Log    Hent function starts
    Wait Until Element Is Visible    xpath=${hent_button}
    Sleep    1s
    Click Element    xpath=${hent_button}
    Sleep    1s
    Wait Until Element Contains    xpath=${snackbar_label}    Anrop hentet inn
    Click Element    xpath=${lukk_button_snaker_label}
    Log    Call Hent successfully
    Sleep    1s

SettOver Samtalen
    [Documentation]    SettOver samtalen button identification and Click
    Log    Sett Over Button function starts
    Wait Until Element Is Visible    xpath=${settover_samtalen_button}
    Sleep    1s
    Click Element    xpath=${settover_samtalen_button}
    Log    SettOver clicked successfully
    Sleep    1s

Click Hent For Snack label Fikk Ikke Hentet Inn
    [Documentation]    This locates the Hent button in the row
    Log    Hent function starts

    ${row_grayed_out}=    Run Keyword And Return Status    Get WebElement    xpath=${row_hent_call_grayedout}

    IF    ${row_grayed_out} == True
        Log    Grayed out row found
        ${target_row}=    Get WebElement    xpath=${second_row_identification}

        Mouse Over    ${target_row}
        Sleep    2s

        Wait Until Element Is Visible    xpath=${hent_button}
        Sleep    1s
        Click Element    xpath=${hent_button}
        Sleep    1s

        Wait Until Element Contains    xpath=${snackbar_label}    Fikk ikke hentet inn anrop

        #Highlight Controls    xpath=//div[@class="mat-mdc-snack-bar-label mdc-snackbar__label"]    Snackbar is clicked

        Click Element    xpath=${lukk_button_snaker_label}
        Log    Call Hent successfully
        Sleep    1s
    ELSE
        Log    Row is not grayed out or not found
    END


Konsult call
    [Documentation]    Consult the call from one user to another
    Log    Konsult function starts
    Sleep    5s
    ${konsult_button}    Get WebElement    xpath=${konsulter_button}
    Execute JavaScript    arguments[0].style.border='5px solid red'    ARGUMENTS    ${konsult_button}
    Sleep    1s
    Wait Until Element Is Visible    xpath=${konsulter_button}    timeout=5s
    Click Element    ${konsult_button}
    Sleep    15s
    Log    Konsult Button clicked successfully


Verify Konsut Banner
    [Documentation]    Consult the call from one user to another
    Log    Konsult banner check starts
    Sleep    5s
    Wait Until Element Is Visible    xpath=${Konsultermed_text_inside_banner}    timeout=7s
    ${konsult_banner}    Get WebElement    xpath=${Konsultermed_text_inside_banner}
    Sleep    1s

SettOver From Konsult Banner
    [Documentation]    Consult the call from one user to another
    Log    Set Over button inside the Konsult Banner
    Sleep    5s
    ${sett_over_konsult_banner}    Get WebElement    xpath=${settover_samtalen_button}
    Click Element    xpath=${settover_samtalen_button}
    #Execute JavaScript    arguments[0].style.border='5px solid red'    ARGUMENTS    xpath=//button[@class="btn-complete-transfer wide-button mdc-button mdc-button--unelevated mat-mdc-unelevated-button ng-tns-c3787235074-7 mat-primary mat-mdc-button-base ng-star-inserted"]//span[@class="mat-mdc-button-touch-target"]
    Sleep    1s
    ${status_text}    Get Text    ${status_text_sb}
    ${result}=    Evaluate    "${status_text}" == "I samtale"
    Log    ${result}
    Sleep    7s

leggpå From Konsult Banner
    [Documentation]    Consult the call from one user to another
    Log    Leggpå button inside the Konsult Banner
    Sleep    5s
    ${leggpå_konsult_banner}    Get WebElement    xpath=${leggpå_button_konsult_banner}
    #Execute JavaScript    arguments[0].style.border='5px solid red'    ARGUMENTS    xpath=//div[@class="consult-actions"]//button[@class="btn-disconnect wide-button mdc-button mdc-button--unelevated mat-mdc-unelevated-button ng-tns-c3787235074-7 mat-warn mat-mdc-button-base ng-star-inserted"]//span[@class="mat-mdc-button-touch-target"]

Ring Button From SB
    [Documentation]    ring button from SB
    Log    clicking ring button starts
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Ring"]   timeout=5s
    Get WebElement    xpath=//span[normalize-space()="Ring"]
    Click Element    xpath=//span[normalize-space()="Ring"]
    Log    clcking ring button ends
    Sleep    5s

Medling Button Click
    [Documentation]    Medling button click from Queue sequence starts
    Log    clicking Medling button starts
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Melding"]
    Get WebElement    xpath=//span[normalize-space()="Melding"]
    Click Element    xpath=//span[normalize-space()="Melding"]
    Log    clcking Medling button starts
    Sleep    3s

Send Medling
    [Documentation]   Send Medling from Queue sequence starts
    Log    clicking Send Medling button starts
    Wait Until Element Is Visible    xpath=//overlay-message[@class="ng-star-inserted"]    timeout=3s
    Click Element    xpath=//mat-select[@role="combobox"]
    Click Element    xpath=//span[normalize-space()="Ingen mal valgt"]
    ${selected}=    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    ${selected}    Log    ✅ Checkbox is already checked
    Run Keyword If    not ${selected}    Click Element    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    not ${selected}    Log    🔘 Checkbox was not checked — clicked now
    Wait Until Element Is Visible    xpath=//textarea[@formcontrolname='text']    timeout=3s
    Input Text    xpath=//textarea[@formcontrolname='text']    Hi, from Q via MicroSIP
    Sleep    2s
    Get WebElement    xpath=//span[normalize-space()="Send"]
    Click Element    xpath=//span[normalize-space()="Send"]
    Sleep    4s

Send Medling for MBN App
    [Documentation]   Send Medling from Queue sequence starts for MBN App
    Log    Send Medling from Queue sequence starts for MBN App
    Wait Until Element Is Visible    xpath=//overlay-message[@class="ng-star-inserted"]    timeout=3s
    Click Element    xpath=//mat-select[@role="combobox"]
    Click Element    xpath=//span[normalize-space()="MBN App"]
    ${selected}=    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    ${selected}    Log    ✅ Checkbox is already checked
    Run Keyword If    not ${selected}    Click Element    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    not ${selected}    Log    🔘 Checkbox was not checked — clicked now
    Wait Until Element Is Visible    xpath=//textarea[@formcontrolname='text']    timeout=3s
    Sleep    2s
    Get WebElement    xpath=//span[normalize-space()="Send"]
    Click Element    xpath=//span[normalize-space()="Send"]
    Sleep    4s

Send Medling for Ring sentralbord
    [Documentation]   Send Medling from Queue sequence starts for Ring sentralbord
    Log    Send Medling from Queue sequence starts for Ring sentralbord
    Wait Until Element Is Visible    xpath=//overlay-message[@class="ng-star-inserted"]    timeout=3s
    Click Element    xpath=//mat-select[@role="combobox"]
    Click Element    xpath=//span[normalize-space()="Ring sentralbord"]
    Sleep    1s
    ${selected}=    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    ${selected}    Log    ✅ Checkbox is already checked
    Run Keyword If    not ${selected}    Click Element    xpath=//label[normalize-space()='SMS']
    Run Keyword If    not ${selected}    Log    🔘 Checkbox was not checked — clicked now
    Wait Until Element Is Visible    xpath=//textarea[@formcontrolname='text']    timeout=3s
    Sleep    2s
    Get WebElement    xpath=//span[normalize-space()="Send"]
    Click Element    xpath=//span[normalize-space()="Send"]
    Sleep    4s

Send Medling for Ring til
    [Documentation]   Send Medling from Queue sequence starts for Ring til
    Log    Send Medling from Queue sequence starts for Ring til
    Wait Until Element Is Visible    xpath=//overlay-message[@class="ng-star-inserted"]    timeout=3s
    Click Element    xpath=//mat-select[@role="combobox"]
    Click Element    xpath=//span[normalize-space()="Ring til"]
    ${selected}=    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    ${selected}    Log    ✅ Checkbox is already checked
    Run Keyword If    not ${selected}    Click Element    xpath=//input[@class='mdc-checkbox__native-control mdc-checkbox--selected']
    Run Keyword If    not ${selected}    Log    🔘 Checkbox was not checked — clicked now
    Wait Until Element Is Visible    xpath=//textarea[@formcontrolname='text']    timeout=3s
    Sleep    2s
    Get WebElement    xpath=//span[normalize-space()="Send"]
    Click Element    xpath=//span[normalize-space()="Send"]
    Sleep    4s


Send SMS from Caller Active Section SB
    [Documentation]    Send SMS from Caller Active Section SB
    Log     Send SMS from Caller Active Section SB
    Wait Until Element Is Visible    xpath=//button[3]//mat-icon[1]//*[name()='svg']//*[name()='path']   timeout=5s
    Mouse Over    xpath=//button[3]//mat-icon[1]//*[name()='svg']//*[name()='path']
    Sleep    3s
    SeleniumLibrary.Wait Until Element Is Enabled    xpath=//swb-active-call[@class='ng-tns-c2758229062-7 ng-star-inserted']//button[3]//span[4]    timeout=10s
    Click Element    xpath=//swb-active-call[@class='ng-tns-c2758229062-7 ng-star-inserted']//button[3]
    Log    clicking SMS button ends
    Sleep    5s


#Endre Flag stratus Dialod after Clicking SMS from active Caller
#    //h5[normalize-space()="Endre flaggstatus?"]
#//div[contains(text(),"Håndtert")]
#//span[normalize-space()="Endre flaggstatus"]
#//div[contains(text(),"Forsøkt kontaktet")]
#//span[normalize-space()="Avbryt"]









#****************************************************************************************************************************************************************
#CRM basic elements
Click Three Dots
    [Documentation]    Clicks the 3-dot (more actions) menu in the contact card and verifies the dropdown appears
    Log    Clicking the 3 dots in the contact card
    Wait Until Element Is Visible    xpath=//button[@aria-label="Flere samtalevalg"]    timeout=2s
    Click Button    xpath=//button[@aria-label="Flere samtalevalg"]
    Sleep    5s
     ${menu_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[@class="cdk-overlay-pane"]
    Run Keyword If    not ${menu_visible}    Double Click Element    xpath=//button[@aria-label="Flere samtalevalg"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//div[@class="cdk-overlay-pane"]   timeout=5s
    Sleep    2s
    
Click Menu SB URl
    [Documentation]   Clicking "URL for CRM setting"
    Log    Clicking "URL for CRM setting
    Wait Until Element Is Visible    xpath=//span[normalize-space()="URL for CRM-tilknytning"]    timeout=5s
    Click Element    xpath=//span[normalize-space()="URL for CRM-tilknytning"]
    Sleep    2s


Input Link For CRM
    [Documentation]   Input CRM-Link
    Log    Inputing a link for CRM
    Wait Until Element Is Visible    xpath=//input[@placeholder="http://yourcrm.com/index.html?phonenumber=<telefonnummer>"]    timeout=2s
    Get WebElement    xpath=//input[@placeholder="http://yourcrm.com/index.html?phonenumber=<telefonnummer>"]
    Input Text    xpath=//input[@placeholder="http://yourcrm.com/index.html?phonenumber=<telefonnummer>"]    ${CRM}
    Sleep    2s

Clicking Manually Using Hotkey
    [Documentation]   Clicking manually using hotkey
    Log    Clicking manually using hotkey starts
    Wait Until Element Is Visible    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]    timeout=2s
    Click Element    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]
    Click Element    xpath=//span[@class="mdc-list-item__primary-text"][normalize-space()="manuelt med hurtigtast"]



Clicking Automatisk Før Anropet Besvares
    [Documentation]   Clicking automatisk før anropet besvares
    Log    Clicking automatisk før anropet besvares Option starts
    Wait Until Element Is Visible    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]    timeout=2s
    Click Element    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]
    Click Element    xpath=//span[normalize-space()="automatisk før anropet besvares"]
    Sleep    2s

Clicking Ok Button In CRM Dialogbox
    Get WebElement    xpath=//span[normalize-space()="OK"]
    Click Element    xpath=//span[normalize-space()="OK"]
    Sleep    5s

Clicking Automatisk Etter Anropet Besvares Anrop
    [Documentation]   Clicking automatisk etter anropet besvares option
    Log    Clicking automatisk etter anropet besvares option starts
    Wait Until Element Is Visible    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]    timeout=2s
    Click Element    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]
    Click Element    xpath=//span[normalize-space()="automatisk etter besvart anrop"]
    Sleep    2s


Clicking Automatisk Etter Avsluttet Anrop
    [Documentation]   Clicking automatisk etter avsluttet anrop
    Log    Clicking automatisk etter avsluttet anrop option starts
    Wait Until Element Is Visible    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]    timeout=2s
    Click Element    xpath=//mat-select[@formcontrolname="crmActivationMode"]//div[contains(@class, "mat-mdc-select-trigger")]
    Click Element    xpath=//span[normalize-space()="automatisk etter avsluttet anrop"]
    Sleep    5s

Clicking Åpne CRM-kobling Også Ved Utgående Anrop
    [Documentation]   Clicking Åpne CRM-kobling også ved utgående anrop
    Log    Clicking Åpne CRM-kobling også ved utgående anrop checkbox starts
    Wait Until Element Is Visible    xpath=//label[normalize-space()="Åpne CRM-kobling også ved utgående anrop"]
    Click Element    xpath=//label[normalize-space()="Åpne CRM-kobling også ved utgående anrop"]
    Sleep    2s

Clicking Åpne CRM-kobling Ved Klikk På Innringernotifikasjon
    [Documentation]   Åpne CRM-kobling ved klikk på innringernotifikasjon
    builtin.Log    Åpne CRM-kobling ved klikk på innringernotifikasjon checkbox starts
    Wait Until Element Is Visible    xpath=//label[contains(text(),"Åpne CRM-kobling ved klikk på innringernotifikasjo")]
    Click Element    xpath=//label[contains(text(),"Åpne CRM-kobling ved klikk på innringernotifikasjo")]
    Sleep    2s

Click Menu Innringernotifikasjon Option
    [Documentation]   Clicking Menu Innringernotifikasjon Option
    Log To Console    Clicking  Menu Innringernotifikasjon Option starts
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Innringernotifikasjon"]    timeout=5s
    Click Element    xpath=//span[normalize-space()="Innringernotifikasjon"]
    Sleep    2s


Verify and Click the Check box in Innringernotifikasjon Menu
    [Documentation]   Click the Check box in Innringernotifikasjon
    Log    Click the Check box in Innringernotifikasjon Starts
    Wait Until Element Is Visible    xpath=//label[normalize-space()="Vis varsel om innringer"]    timeout=5s
    Click Element    xpath=//label[normalize-space()="Vis varsel om innringer"]
    Sleep    3s


////////////////////////////////////////////////////
Click Menu Notat-popup
    [Documentation]   Clicking Menu Notat-popup Option
    Log    Clicking  Menu Notat-popup Option starts
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Notat-popup"]    timeout=5s
    Click Element    xpath=//span[normalize-space()="Notat-popup"]
    Sleep    2s

Verify and Click the Check box Notat-popup Option
    [Documentation]   Click the Check box Notat-popup Option
    Log    Click the Check box in Notat-popup Option Starts
    Wait Until Element Is Visible    xpath=//label[normalize-space()="Notatboks vises automatisk ved besvart anrop."]    timeout=5s
    Click Element    xpath=//input[@type="checkbox"]
    Sleep    3s
///////////////////////////////////////////////////////////////////////

Click Vis siste innringer
    [Documentation]   Clicking Vis siste innringer
    Log    Clicking  Menu Notat-popup Option starts
    Wait Until Element Is Visible    xpath=//span[normalize-space()="Vis siste innringer"]   timeout=5s
    Click Element    xpath=//span[normalize-space()="Vis siste innringer"]
    Sleep    2s


#*************************************************************************************************************************************************************************************************************************************************************************************************************************

#Status Change


Handle Ledig
        Log    ✅ Detected and running check for Ledig
        [Arguments]    ${initial_status_flag}=False
		Log To Console    ☎️ Calling from MicroSIP1 to MicroSIP3
		# Need to highlight and validate status text box - Ledig
        Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_3_APP}     ${MICROSIP_3_APP_NAME}     ${PHONE_NUMBER_TO_Q}
        Log    ✅Caller Status moved to ISamtale
		Sleep    10s
		Wait Until Element Is Visible    ${settpåvent_button_xpath}    timeout=5s
		Click Element    xpath=${settpåvent_button_xpath}
		${status}    Get Text    ${status_text_sb}
		Log    ${status}
		Sleep    2s
		Call To Queue Gjenoppta
		Sleep    2s
		End Call Button    ${MICROSIP_3_APP_NAME}
		Log    ✅Caller Status moved to Ledig

		IF    ${initial_status_flag}
		    Log    Checking other status
		    Handle ISamtale
		    Handle FraKoblet    # Activating microsip for future cases
		ELSE
		    RETURN
        END

Handle ISamtale
        Log    ✅ Detected and running check for I Samtale
        [Arguments]    ${initial_status_flag}=False
		Sleep    5s
		# Need to highlight and validate status text box - I Samtale
		Inactive Microsip    ${MICROSIP_3_APP_NAME}
        Log    ✅Caller Status moved to FraKoblet
		Sleep    2s
		IF    ${initial_status_flag}
		    Log    Checking other status
		    Handle FraKoblet
		ELSE
		    RETURN
        END

Handle FraKoblet
        Log    ✅ Detected and running check for Frakoblet
        [Arguments]    ${initial_status_flag}=False
        #Log    ⚠️ Initial status is Frakoblet — activating MicroSIP...
        # Need to highlight and validate status text box
        Activate Microsip    ${MICROSIP_3_APP_NAME}
        Log    ✅Caller Status moved to Ledig
        Sleep    2s
		IF    ${initial_status_flag}
		    Log    Checking other status
		    Handle Ledig
		ELSE
		    RETURN
        END

Status Check For SB
    [Documentation]    Verifies all statuses appear at least once and logs status changes
    Log    📋 Status Check Started

    # Check element is visible and available
    Wait Until Element Is Visible    xpath=${status_tab_text}    10s

    ${status_element}=    Get WebElement    xpath=${status_tab_text}
    ${name_element}=    Get WebElement    xpath=${status_text_sb}

    # Setting initil caller status
    ${initial_status}=    Get Text    ${name_element}
    Log    📌 Initial status: ${initial_status}

    IF    '${initial_status}' == 'Ledig'
        Log    ⚠️ Initial status is Ledig
        Log    Proceeding with actions of Ledig
        Handle Ledig    True

    ELSE IF    '${initial_status}' == 'I samtale'
        Log    ⚠️ Initial status is I samtale
        Log    Proceeding with actions of I samtale
        Handle ISamtale    True

    ELSE IF    '${initial_status}' == 'Frakoblet'
        Log    ⚠️ Initial status is Frakoblet
        Log    Proceeding with actions of Frakoblet
        Handle FraKoblet    True

    ELSE
        Fail    Unknown Status!!! Initial caller status should be Ledig, I samtale or Frakoblet
    END

    Log    ✅ Status tracking completed!
    Log    🎉 Status Check completed successfully
#***************************************************************************************************************************************************************************************************************
#SettFravær Scenarios


#***************************************************************************************************************************************************************************************************************
#CRM Scenarios

Navigate to CRM URL
    Click Three Dots
    Click Menu SB URl
    Input Link For CRM

#***************************************************************************************************************************************************************************************************************
#FOF
Launch SwitchBoard
    [Documentation]   Launch SwitchBoard consolidated scenario FOF
    #Open Web Browser And Maximize Login
    Input LoginHint In TextBox In Login
    Open Initial MicroSip In Browser During Login
    Enter OTP ON Browser Login
    CheckBox Function On Browser Login
    Dropdown Function On Browser And Click SB Button Login

Check Navn På AnroppsKØlog
    [Documentation]   Check Navn På AnroppsKØlog consolidated FOF
    BedriftsKatlog Tab Selection and Highlight
    SearchBox Identification And CallerName Validation
    Open Profile Dialogbox After Double Click
    Validate Profile Section
    Close Profile Dialog Box


Close WebBrowser And MicroSIP
    [Documentation]   for teardown
    Close Browser
    Close All Microsip Window


Check Hent For Multiple Call In Queue Fuctionality
    [Documentation]    log in to the Switch board to check the Avvis and Hent button functionality
    Dial From Two MicroSIPs To Another And Answer Call From MicroSIP1   ${MICROSIP_1_APP_NAME}    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
    Call To Queue Legg På
    Sleep    15s
    Answer Call Button    ${MICROSIP_1_APP_NAME}
    Sleep    5s

