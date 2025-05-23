*** Settings ***
Resource       ../resource/app_elements.resource
Resource       ../resource/web_elements.resource
Resource       ../resource/config.resource


#ADD THIS FILE AS A RESOUECE FILE  IN YOUR FINAL SUBMISSION



*** Test Cases ***
Launch MicroSIP
    #[Template]  shal be used with function name for various users or iterative users take function from resource or keywords from same file
    Log    FlaUILibrary is working!
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
    Input Phone Number In Text Box         ${MICROSIP_1_APP_NAME}   ${PHONE_NUMBER_2}
    Press Call Button                      ${MICROSIP_1_APP_NAME}
    Incoming Call Button                   ${MICROSIP_2_APP_NAME}
    Answer Call Button                     ${MICROSIP_2_APP_NAME}
    End Call Button                        ${MICROSIP_1_APP_NAME}
    Close All Microsip Window
Initial Call Answer End During Login In SB Test
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Initial Call Answer End In During Login In SB    ${MICROSIP_1_APP_NAME}

Transfer of call from MicroSip
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Launch MicroSIP    ${MICROSIP_3_APP}    ${MICROSIP_3_APP_NAME}
    Transfer of call from MicroSip          ${MICROSIP_1_APP_NAME}      ${MICROSIP_3_APP_NAME}      ${PHONE_NUMBER_3}

Dial from One MicroSIP To Another And Answer Call From MicroSIP1 Test
    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
    Input Phone Number In Text Box          ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_2_APP_NAME}
    Incoming Call Button                    ${MICROSIP_1_APP_NAME}
    Answer Call Button                      ${MICROSIP_1_APP_NAME}

Check KØ Prefix
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Launch MicroSIP    ${MICROSIP_2_APP}    ${MICROSIP_2_APP_NAME}
    Input Phone Number In Text Box         ${MICROSIP_2_APP_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                      ${MICROSIP_2_APP_NAME}
    Incoming Call Button                   ${MICROSIP_1_APP_NAME}
    Check Incoming Call Prefix             ${MICROSIP_1_APP_NAME}
    Answer Call Button                     ${MICROSIP_1_APP_NAME}
    End Call Button                        ${MICROSIP_1_APP_NAME}
    #Close MicroSIP                         ${MICROSIP_1_APP_NAME}
    #Close MicroSIP                         ${MICROSIP_2_APP_NAME}

Test Notification click to be deleted
    Launch MicroSIP    ${MICROSIP_1_APP}    ${MICROSIP_1_APP_NAME}
    Capture Notification From Browser


Close MicroSIP Test
    Close MicroSIP    ${MICROSIP_1_APP_NAME}
    Close MicroSIP    ${MICROSIP_2_APP_NAME}
    Close MicroSIP    ${MICROSIP_3_APP_NAME}