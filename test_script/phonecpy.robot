*** Settings ***
Resource       ../resource/app_elements.resource
Resource       ../resource/web_elements.resource
Resource       ../resource/config.resource
Resource       ../resource/PhoneSCRCPY.resource

Suite Setup
Suite Teardown    Close PCY
#ADD THIS FILE AS A RESOUECE FILE  IN YOUR FINAL SUBMISSION

*** Test Cases ***
Launch Phone Copy
    [Documentation]    This function is to text the make call functionality
    Launch PhoneCpy
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    MakeCall From PCY    ${PHONE_NUMBER_1}
    Receive Call Only    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    End Call From PCY

Open SMS App Test
    Launch PhoneCpy
    Unlock Device Screen
    Open SMS Conversation From Caller    ${PHONE_NUMBER_TO_Q}
    Get Last SMS Information
    Click To Go Back Twice
    Sleep    4s
    Click On Recent Apps Button And Close All
    Sleep    5s



Receive An Incoming Call
    Launch PhoneCpy
    Launch MicroSIP Basic    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}    ${PHONE_NUMBER_SCRCPY}
    Incoming Call PCY
    Answer Call PCY
    Sleep    10s
    End Call From PCY