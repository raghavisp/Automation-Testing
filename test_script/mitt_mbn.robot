*** Settings ***
Resource    ../resource/config.resource
Resource    ../resource/web_elements.resource
Resource    ../resource/app_elements.resource
Resource    ../resource/mitt_mbn_web_elements.resource
Resource    ../resource/PhoneSCRCPY.resource

Suite Setup
Suite Teardown    Close WebBrowser And MicroSIP


*** Test Cases ***
Login and Perform Actions Check Caller
    Launch SwitchBoard
    Change To Mitt MBN Page
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_1}
    Call Active In Mitt MBN
    Call Highlight Contact Card In Mitt MBN
    Validate Caller Name In Mitt MBN
    Call To MittMBN Legg På

Login Mitt MBN Perform Sett På Vent And Gjenoppta
    Launch SwitchBoard
    Change To Mitt MBN Page
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_1}
    Call Active In Mitt MBN
    Call Highlight Contact Card In Mitt MBN
    Call To MittMBN Sett På Vent
    Call To MittMBN Gjenoppta

Login Mitt MBN Check Anropslogg
    Launch SwitchBoard
    Change To Mitt MBN Page
    Dial From One MicroSIP To Another And Answer Call From MicroSIP1    ${MICROSIP_1_APP_NAME}    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}    ${PHONE_NUMBER_1}
    Call Active In Mitt MBN
    Call Highlight Contact Card In Mitt MBN
    Anroplog Tab Selection and Highlight MittMBN
    SearchBox Identification Mitt MBN
    CallerName Validation MittMBN

Login Mitt MBN Check Calling from Anropslogg
    Launch SwitchBoard
    Change To Mitt MBN Page
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    SearchBox Identification Mitt MBN
    CallerNumber Validation MittMBN    ${PHONE_NUMBER_3}
    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
    Ringing button From Mitt MBN
    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Receive Call Only    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
    Sleep    5s
    End Call Button    ${MICROSIP_3_APP_NAME}
    Sleep    3s
    Logout Sequence

Send SMS Til En I Loggen
    Launch SwitchBoard
    Change To Mitt MBN Page
    Launch PhoneCpy
    Sleep    3s
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    MakeCall From PCY    ${PHONE_NUMBER_1}
    Send SMS Til en Loggen
    Send Medling Fra MittMBN
    Open SMS Conversation From Caller    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information




