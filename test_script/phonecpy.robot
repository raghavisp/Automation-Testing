*** Settings ***
Resource       ../resource/app_elements.resource
Resource       ../resource/web_elements.resource
Resource       ../resource/config.resource
Resource       ../resource/PhoneSCRCPY.resource



Suite Setup
Suite Teardown
#ADD THIS FILE AS A RESOUECE FILE  IN YOUR FINAL SUBMISSION

*** Test Cases ***
Launch Phone Copy
    [Documentation]    This function is to text the make call functionality
    Launch PhoneCpy2
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Input Phone Number In Text Box         ${MICROSIP_1_APP_NAME}   ${PHONE_NUMBER_SCR_517}
    Press Call Button                      ${MICROSIP_1_APP_NAME}
    Sleep    2s
    Incoming Call PCY2
    Answer Call PCY2

    End Call From PCY2

Call from one to other PCY
    [Documentation]    make call from one to another phone copy
    Launch PhoneCpy
    Launch PhoneCpy2
    MakeCall From PCY    ${PHONE_NUMBER_SCR_517}
    Incoming Call PCY2
    Answer Call PCY2
    End Call From PCY2



check email
    Launch PhoneCpy2
    Click Home
    Get Email Access
    Get Email Body
    Close PCY    ${PHONECPY_PATH2}


Open SMS App
    Launch PhoneCpy3
    Unlock Device Screen    ${ADB_PATH3}    ${Device_ID_EX_033}
    Open SMS Conversation From Caller    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information    ${ADB_PATH3}    ${Device_ID_EX_033}
    Click To Go Back Twice    ${ADB_PATH3}
    Sleep    2s
    Click On Recent Apps Button And Close All    ${ADB_PATH3}
    Sleep    5s

Open SMS App Test2
    Launch PhoneCpy2
    Open SMS Conversation From Caller2    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information    ${ADB_PATH2}    ${DEVICE_GS10}
    Click To Go Back Twice    ${ADB_PATH2}
    Sleep    2s

Receive An Incoming Call
    Launch PhoneCpy1
    Launch MicroSIP Basic    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}    ${PHONE_NUMBER_SCRCPY}
    Incoming Call PCY1
    Check Phone Is Ringing
    Answer Call PCY1
    Check If Call Is Active
    End Call From PCY1