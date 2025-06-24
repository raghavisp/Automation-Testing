*** Settings ***
Resource    ../resource/config.resource
Resource    ../resource/web_elements.resource
Resource    ../resource/app_elements.resource
Resource    ../resource/PhoneSCRCPY.resource

Suite Setup    Open Web Browser And Maximize Login
Suite Teardown    Close WebBrowser And MicroSIP

*** Test Cases ***
Login and Perform Actions To Pause Kø 1
    [Documentation]    log in to the Switch board to check the pause button functionality
    Launch SwitchBoard
    Handle Node Highlight And Pause Button
    Handle Dialog Box
    Verify Pause Status
    Handle Resume Button
    Verify Toggle State
    Log    End Of TC 1
    Sleep    10s

Check Call To Queue from MicroSIP legg På 2
    [Documentation]    "Queue Call Handling: Agent Receives, Completes Conversation, and Disconnects"
    #Launch SwitchBoard
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
    Call Active And Highlight Contact Card
    Validate Caller Name
    Call To Queue Legg På
    Log    End Of TC 2
    Sleep    10s

Check Call To Queue from MicroSIP Sett På Vent Og Gjenoppta 3
    [Documentation]    "Queue Call Handling: Agent Puts Call on Hold, Resumes Conversation, and Disconnects"
    Launch SwitchBoard
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
    Call Active And Highlight Contact Card
    Validate Caller Name
    Call To Queue Sett På Vent
    Call To Queue Gjenoppta
    Call To Queue Legg På
    Log    End Of TC 3
    Sleep    10s


Ckeck VIP Navn På SB Anropslogg And Kø Prefix 4
    [Documentation]    "Queue Call Handling: Agent Attends the call, Validates VIP Indicator, Checks Caller in Bedrifts KO Log, and Verifies Kø Prefix Before Disconnecting"
    #Launch SwitchBoard
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
    Call Active And Highlight Contact Card
    Validate Caller Name
    Mark VIP
    Check Navn På AnroppsKØlog
    Call To Queue Legg På
    Log    End Of TC 4
    Sleep    10s

CLick Hent Button When Q Is Paused 5
    [Documentation]    log in to the Switch board to check the pause button functionality
    #Launch SwitchBoard
    Handle Node Highlight And Pause Button
    Handle Dialog Box
    Verify Pause Status
    Sleep    3s
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1 for Hent    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
    Call To Queue Legg På
    Handle Resume Button
    Log    End Of TC 5
    Sleep    10s

#Click Hent on Avvis Call 6
#    [Documentation]    log in to the Switch board to check the Avvis and Hent button functionality
#    #Launch SwitchBoard
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1 for Hent With Avvis    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Call To Queue Legg På
#
#
#Check Hent For Multiple Call In Queue Fuctionality 7
#    [Documentation]    log in to the Switch board to check the Avvis and Hent button functionality
#    #Launch SwitchBoard
#    Dial From Two MicroSIPs To Another And Answer Call From MicroSIP1   ${MICROSIP_1_APP_NAME}    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
#    Call To Queue Legg På
#    Sleep    15s
#    Answer Call Button    ${MICROSIP_1_APP_NAME}
#    Sleep    5s
#    End Call Button    ${MICROSIP_1_APP_NAME}
#
#Check Hent For Multiple Call In Queue Fuctionality Negative 8
#    [Documentation]    "Hent For Multiple Call In Queue Fuctionality Negative"
#    #Launch SwitchBoard
#    Dial From Two MicroSIPs To Another And Answer Call From MicroSIP1 For Negative    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}   ${PHONE_NUMBER_TO_Q}
#    Log    End the Microsip
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    End Call Button    ${MICROSIP_3_APP_NAME}
#
#Check for Status 9
#    [Documentation]    Check all the 3 status with Call on hold during I Samtale validation
#    #Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Log To Console    🚦 Detecting and preparing to verify all statuses
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Status Check For SB
#
#
#Check for Konsult with SetOver 10
#    [Documentation]    call consult with Sett Over A calls Kø, B gets the call distributed and does a consult call to C who a different avtaling
#    #Launch SwitchBoard
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Log    call from Microsip 2 to the Operater MicroSIP1
#    Call Active And Highlight Contact Card
#    Validate Caller Name
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    Konsult call
#    Check Incoming Call Prefix    ${MICROSIP_3_APP_NAME}
#    Incoming Call Button    ${MICROSIP_3_APP_NAME}
#    Answer Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    5s
#    verify Konsut Banner
#    SettOver From Konsult Banner
#    Sleep    4s
#    End Call Button    ${MICROSIP_3_APP_NAME}
#    Log    Microsip 2 and 3 speaks now
#
#
#Check for Konsult with SetOver For External user 11
#    [Documentation]    call consult with Sett Over A calls Kø, B gets the call distributed and does a consult call to C who a External User
#    Launch SwitchBoard
#    Launch PhoneCpy3
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Log    Call from Microsip 2 to the Operater MicroSIP1
#    Call Active And Highlight Contact Card
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_EX}
#    Sleep    2s
#    Konsult call
#    Answer Call PCY3
#    Sleep    2s
#    Verify Konsut Banner
#    SettOver Samtalen
#    Sleep    25s
#    Move To    ${MICROSIP_2_APP_NAME}
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#    Log    Microsip 2 and External user speaks now
#
#
#
#Check for Konsult with Leggpå 12
#    [Documentation]    call consult with Legg på A calls Kø, B gets the call distributed and does a consult call to C who a different avtaling- Consult reject
#    #Launch SwitchBoard
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Log    call from Microsip 2 to the Operater MicroSIP1
#    Call Active And Highlight Contact Card
#    Validate Caller Name
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Log To Console    BedriftsKatalog and Search box input is done Phone number must be 22391428
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    Log To Console   Konsult call starts
#    Konsult call
#    Check Incoming Call Prefix    ${MICROSIP_3_APP_NAME}
#    Incoming Call Button    ${MICROSIP_3_APP_NAME}
#    Answer Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    5s
#    Log To Console   konsult call banner check block
#    verify Konsut Banner
#    leggpå From Konsult Banner
#    Sleep    5s
#    Log    Microsip 2 and 3 speaks now
#
#
#Konsult Call With Multiple Users On Kø Plukk Fra Kø Consult Og Settover 13
#    [Documentation]    call consult with Sett Over A calls Kø, B gets the call distributed and does a consult call to C who a different avtaling when done with multiple calls
#    #Launch SwitchBoard
#    Check Hent For Multiple Call In Queue Fuctionality
#    Call Active And Highlight Contact Card
#    Validate Caller Name
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Sleep    2s
#    Konsult call
#    Check Incoming Call Prefix    ${MICROSIP_3_APP_NAME}
#    Incoming Call Button    ${MICROSIP_3_APP_NAME}
#    Answer Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    5s
#    verify Konsut Banner
#    SettOver From Konsult Banner
#    Sleep    5s
#    Log    Microsip 2 and 3 speaks now
#    End Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    3s
#
#
#
#Konsult Call Ring From Queue Og SettOver 14
#    [Documentation]    call consult with Sett Over A calls Kø, B gets the call distributed and does a consult call to C who a different avtaling when done with multiple calls
#    #Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Receive Call Only    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep     3s
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Sleep    2s
#    Konsult call
#    Check Incoming Call Prefix    ${MICROSIP_2_APP_NAME}
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    3s
#    SettOver Samtalen
#    Sleep    15s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#    Log    Microsip 2 and 3 speaks now
#
#
#Konsult Call Ring From Queue to Phone With Onset Phone Og SettOver 15
#    [Documentation]    Sett Over samtalen
#    #Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Launch PhoneCpy2
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Sleep    2s
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Receive Call Only    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    Konsult call
#    Sleep    1s
#    Check Phone Is Ringing2
#    Answer Call PCY2
#    Check If Call Is Active2
#    SettOver Samtalen
#    Sleep    15s
#    End Call Button    ${MICROSIP_3_APP_NAME}
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#    Log    Microsip 2 and Phone 517 speaks now
#
#
#Konsult Call Ring From Queue to Phone With Offset Phone With 2 Avtaller Og SettOver 16
#    [Documentation]    Sett Over samtalen
#    #Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Launch PhoneCpy
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Sleep    2s
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    2s
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCRCPY}
#    Sleep    2s
#    Konsult call
#    Sleep    1s
#    Check Phone Is Ringing
#    Answer Call PCY
#    Check If Call Is Active
#    SettOver Samtalen
#    Sleep    15s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Close PCY    ${PHONECPY_PATH}
#    Sleep    5s
#    Log    Microsip 2 and Phone 785 speaks now
#
#
#
#Check SettOver Samtalen 17
#    [Documentation]    Sett Over samtalen
#    #Launch SwitchBoard
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Call Active And Highlight Contact Card
#    Validate Caller Name
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    SettOver Samtalen
#    Check Incoming Call Prefix    ${MICROSIP_3_APP_NAME}
#    Incoming Call Button    ${MICROSIP_3_APP_NAME}
#    Answer Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    15s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#    Log    Microsip 2 and 3 speaks now
#
#Check SettOver Samtalen from MS To Number With Member of More than Avtaller 18
#    [Documentation]    Sett Over samtalen
#    #Launch SwitchBoard
#    Launch PhoneCpy2
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Call Active And Highlight Contact Card
#    Validate Caller Name
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    SettOver Samtalen
#    Sleep    1s
#    Check Phone Is Ringing2
#    Answer Call PCY2
#    Check If Call Is Active2
#    Sleep    15s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#    Close PCY    ${PHONECPY_PATH}
#    Log    Microsip 2 and Phone 46180785 which is a part of 2 different Avtaller speaks now
#
#
#
#Check SettOver Samtalen ring from Queue 19
#    [Documentation]    Sett Over samtalen
#    #Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Launch PhoneCpy2
#    SearchBox Identification And Input Phone Number    ${PHONE_NUMBER_3}
#    Sleep    2s
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Receive Call Only    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    SettOver Samtalen
#    Sleep    1s
#    Incoming Call PCY2
#    Check Phone Is Ringing2
#    Answer Call PCY2
#    Check If Call Is Active2
#    Sleep    15s
#    End Call Button    ${MICROSIP_3_APP_NAME}
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#    Log    Microsip 2 and Phone 785 speaks now
#
#Ring from Queue To Phone 20
#    [Documentation]    ring from Queue
#    #Launch SwitchBoard
#    Launch PhoneCpy2
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517_S}
#    Sleep    2s
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Incoming Call PCY2
#    Check Phone Is Ringing2
#    Answer Call PCY2
#    Check If Call Is Active2
#    Sleep    5s
#    End Call Button    ${MICROSIP_1_APP_NAME}
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    3s

#Ring from Queue MicroSIP 21
#    [Documentation]    ring from Queue
#    Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_3}
#    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    2s
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Receive Call Only    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
#    Sleep    5s
#    End Call Button    ${MICROSIP_3_APP_NAME}
#    Sleep    3s
#
#
#Melding from Queue Custom 22
#    [Documentation]    Melding from Queue
#    Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    Medling Button Click
#    Send Medling
#    Open SMS App2
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#
#Melding from Queue Predefined message Meldingsmal: MBN App 23
#    [Documentation]    Melding from Queue
#    Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    Medling Button Click
#    Send Medling for MBN App
#    Open SMS App2
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#
#Melding from Queue Predefined message Meldingsmal: Ring sentralbord 24
#   [Documentation]    Melding from Queue
#    Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    Medling Button Click
#    Send Medling for Ring sentralbord
#    Open SMS App2
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#
#
#Melding from Queue Predefined message Meldingsmal: Ring til 25
#    [Documentation]    Melding from Queue
#    Launch SwitchBoard
#    BedriftsKatlog Tab Selection and Highlight
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
#    Sleep    2s
#    Medling Button Click
#    Send Medling for Ring til
#    Open SMS App2
#    Close PCY    ${PHONECPY_PATH2}
#    Sleep    5s
#
#
Call To Q And Reply with a Message From Operator 26
    Launch SwitchBoard
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Launch PhoneCpy2 For SMS
    MakeCall From PCY2    ${PHONE_NUMBER_TO_Q}
    Incoming Call Button    ${MICROSIP_1_APP_NAME}
    Call Active And Highlight Contact Card
    Validate Caller Name
    Send SMS from Caller Active Section SB
    Send Medling for Ring sentralbord
    Click Element    xpath=//span[normalize-space()='Avbryt']
    Sleep    5s
    Open SMS App2
    Sleep    5s
    End Call From PCY2
    Close PCY    ${PHONECPY_PATH2}

Call from Q And Caller doesnt pick up Reply with a Message From Operator
    Launch SwitchBoard
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Launch PhoneCpy2 For SMS
    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_SCR_517}
    Ring Button From SB
    Incoming Call Button    ${MICROSIP_1_APP_NAME}
    Answer Call Button    ${MICROSIP_1_APP_NAME}
    Validate Caller Name
    Send SMS from Caller Active Section SB
    End Call From PCY2
    Send Medling for Ring sentralbord
    Click Element    xpath=//span[normalize-space()='Avbryt']
    Sleep    5s
    Open SMS App2
    Sleep    5s
    Close PCY    ${PHONECPY_PATH2}

Melding from Queue Predefined message Meldingsmal: Ring sentralbord to External
    [Documentation]    Melding from Queue
    Launch SwitchBoard
    Launch PhoneCpy3
    BedriftsKatlog Tab Selection and Highlight
    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_EX}
    Sleep    2s
    Medling Button Click
    Send Medling for Ring sentralbord
    Open SMS App3
    Close PCY    ${PHONECPY_PATH3}
    Sleep    5s



#CRM For Manual Hot Key 27
#    [Documentation]    Manual Hot Key
#    Launch SwitchBoard
#    Navigate to CRM URL
#    Click Menu SB URl
#    Input Link For CRM
#    Clicking manually using hotkey
#    Clicking Ok Button In CRM Dialogbox
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Sleep    1s
#    Open Url In New Tab And Wait
#    Sleep    2s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Sleep    3s
#
#CRM For automatisk før anropet besvares 28
#    [Documentation]    automatisk før anropet besvares
#    Launch SwitchBoard
#    Navigate to CRM URL
#    Input Link For CRM
#    Clicking automatisk før anropet besvares
#    Clicking Ok Button In CRM Dialogbox
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Input Phone Number In Text Box         ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
#    Press Call Button                      ${MICROSIP_2_APP_NAME}
#    Sleep    1s
#    Open Url In New Tab Already Opened And Wait
#    Sleep    2s
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Sleep    5s
#
#CRM For Automatisk Etter Anropet Besvares Anrop 29
#    [Documentation]    Automatisk Etter Anropet Besvares Anrop
#    Launch SwitchBoard
#    Navigate to CRM URL
#    Input Link For CRM
#    Clicking Automatisk Etter Anropet Besvares Anrop
#    Clicking Ok Button In CRM Dialogbox
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Sleep    1s
#    Open Url In New Tab Already Opened And Wait
#    Sleep    5s
#
#CRM For Automatisk Etter Avsluttet Anrop 30
#    [Documentation]    Automatisk Etter Avsluttet Anrop
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Navigate to CRM URL
#    Click Menu SB URl
#    Input Link For CRM
#    Clicking Automatisk Etter Avsluttet Anrop
#    Clicking Ok Button In CRM Dialogbox
#    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_TO_Q}
#    Sleep    1s
#    End Call Button    ${MICROSIP_2_APP_NAME}
#    Open Url In New Tab Already Opened And Wait
#    Sleep    5s
#
#CRM For Åpne CRM-kobling Også Ved Utgående Anrop Med automatisk før anropet besvares 31
#    [Documentation]    Åpne CRM-kobling Også Ved Utgående Anrop
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Navigate to CRM URL
#    Clicking automatisk før anropet besvares
#    Sleep    2s
#    Clicking Åpne CRM-kobling Også Ved Utgående Anrop
#    Clicking Ok Button In CRM Dialogbox
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Open Url In New Tab Already Opened And Wait
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#
#
#CRM For Åpne CRM-kobling Også Ved Utgående Anrop Med Automatisk Etter Anropet Besvares Anrop 32
#    [Documentation]    Åpne CRM-kobling Også Ved Utgående Anrop
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Navigate to CRM URL
#    Clicking Automatisk Etter Anropet Besvares Anrop
#    Sleep    2s
#    Clicking Åpne CRM-kobling Også Ved Utgående Anrop
#    Clicking Ok Button In CRM Dialogbox
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Open Url In New Tab Already Opened And Wait
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#
#
#CRM For Åpne CRM-kobling Også Ved Utgående Anrop Med Automatisk Etter Avsluttet Anrop 33
#    [Documentation]    Åpne CRM-kobling Også Ved Utgående Anrop
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Navigate to CRM URL
#    Clicking Automatisk Etter Avsluttet Anrop
#    Sleep    2s
#    Clicking Åpne CRM-kobling Også Ved Utgående Anrop
#    Clicking Ok Button In CRM Dialogbox
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Open Url In New Tab Already Opened And Wait
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#
#
#CRM For Åpne CRM-kobling Også Ved Utgående Anrop Med Manual Hot Key 34
#    [Documentation]    Åpne CRM-kobling Også Ved Utgående Anrop
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Navigate to CRM URL
#    Clicking manually using hotkey
#    Clicking Ok Button In CRM Dialogbox
#    Sleep    2s
#    Clicking Åpne CRM-kobling Også Ved Utgående Anrop
#    Clicking Ok Button In CRM Dialogbox
#    SearchBox Identification And Input Phone Number Specific To Konsult External User and Any User    ${PHONE_NUMBER_2}
#    Ring Button From SB
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Open Url In New Tab Already Opened And Wait
#    Receive Call Only    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Sleep    5s
#
#
#CRM For Åpne CRM-kobling ved klikk på innringernotifikasjon 35
#    [Documentation]    Åpne CRM-kobling ved klikk på innringernotifikasjon
#    Launch SwitchBoard
#    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
#    Click Three Dots
#    Click Menu Innringernotifikasjon Option
#    Verify and Click the Check box in Innringernotifikasjon Menu
#    Clicking Ok Button In CRM Dialogbox
#    Cookie popup
#    Navigate to CRM URL
#    Clicking Åpne CRM-kobling Ved Klikk På Innringernotifikasjon
#    Clicking Ok Button In CRM Dialogbox
#    Input Phone Number In Text Box         ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
#    Press Call Button                      ${MICROSIP_2_APP_NAME}
#    Capture Notification From Browser
#    Open CRM Page In New Tab And Verify Header
#    Sleep    3s
#    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
#    Sleep    5s