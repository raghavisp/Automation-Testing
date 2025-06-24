*** Settings ***
Library     FlaUILibrary        WITH NAME    Micro
Library     BuiltIn

Resource    ../resource/config.resource
Resource    web_elements.resource



*** Keywords ***
Launch MicroSIP
    [Arguments]    ${MICROSIP_APP_PATH}    ${MICROSIP_APP_NAME}
    [Documentation]    Launches the MicroSIP application.
    ${pid}    Launch Application    ${MICROSIP_APP_PATH}
    Log    Launched Applicatin : ${MICROSIP_APP_NAME}
    BuiltIn.Sleep    1s

Input Phone Number In Text Box
    [Arguments]    ${MICROSIP_APP_NAME}    ${PHONE_NUMBER}
    [Documentation]    Imputs phone number in micor sip textbox
    BuiltIn.Sleep    1s
    Click   /Window[@Name='${MICROSIP_APP_NAME}']/ComboBox/Edit
    Set Text To Textbox     /Window[@Name='${MICROSIP_APP_NAME}']/ComboBox/Edit     ${PHONE_NUMBER}
    Log     phone number input successful
    BuiltIn.Sleep    2s

Press Call Button
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Imputs phone number in micor sip textbox
    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/ComboBox/Edit
    ${IS_ENABLED}=  Micro.Is Element Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='Call']
    IF   ${IS_ENABLED} == True
        Micro.Click   /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='Call']
    ELSE
        Micro.Press Key    s'ENTER'
    END
    BuiltIn.Sleep    2s
 
Incoming Call Button
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Incoming call Window
    BuiltIn.Sleep    1s
    Wait Until Element Exist    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']
    Sleep    1s

Answer Call Button
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Answer the call
    Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
    Micro.Move To    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
    Log    Call Answered Successfully

End Call Button
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    End the call
    BuiltIn.Sleep    1s
    Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='End']
    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='End']
    Log    Call ended Successfully

Inactive Microsip
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Inactive the MicroSIP
    BuiltIn.Sleep    1s
    Wait Until Element Exist    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='Menu']
    Micro.Move To    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='Menu']
    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='Menu']
    Wait Until Element Exist    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    Move To    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    Click    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    #Wait Until Element Exist    /Window[@Name='${MICROSIP_APP_NAME}']/StatusBar[@Name='MicroSIP']
    #Move To    /Window[@Name='${MICROSIP_APP_NAME}']/StatusBar[@Name='MicroSIP']
    #Double Click    /Window[@Name='${MICROSIP_APP_NAME}']/StatusBar[@Name='MicroSIP']
    Sleep    2s

Activate Microsip
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Inactive the MicroSIP
    BuiltIn.Sleep    5s
    Wait Until Element Exist    /Window[@ClassName='MicroSIP']/Button[@Name='Menu']
    Micro.Move To    /Window[@ClassName='MicroSIP' and @Name='MicroSIP']/Button[@Name='Menu']
    Micro.Click    /Window[@ClassName='MicroSIP' and @Name='MicroSIP']/Button[@Name='Menu']
    Wait Until Element Exist    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    Move To    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    Click    /Menu[@Name='Context']/MenuItem[@Name='22391428']
    Sleep    2s

Capture Notification From Browser
    [Documentation]    the notifications from browser is captured via FLAUI
    Wait Until Element Exist    /Window[@Name='New notification']
    Log    /Window[@Name='New notification']
    Micro.Move To    /Window[@Name='New notification']
    Sleep    2s
    Micro.Click    /Window[@Name='New notification']
    Sleep    3s


Close MicroSIP
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Closes the MicroSIP application.
    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/TitleBar/Button[@Name='Close']
    Log    Closed Applicatin : ${MICROSIP_APP_NAME}
    BuiltIn.Sleep    3s

Close All Microsip Window
        Run    taskkill /f /im MicroSIP.exe
        Sleep    10s
        Log    MicroSIP process terminated successfully

Cookie popup
    [Documentation]    Closes the MicroSIP application.
    Micro.Click    /Pane[@Name='MBN Sentralbord - Permission requested, press F6 to respond - Google Chrome']/Pane[@Name='cpbx-at.telenor.no wants to: Show notifications']/Pane/Pane/Pane/Pane/Button[@Name='Allow']
    Sleep    2s

#FOF

Launch MicroSIP Basic
    #[Template]  shal be used with function name for various users or iterative users take function from resource or keywords from same file
    [Arguments]    ${MICROSIP_APP_PATH}    ${MICROSIP_APP_NAME}    ${PHONE_NUMBER}
    [Documentation]    basic MicroSIP Functions
    Log    Launch Microsip basic Functions
    Launch MicroSIP    ${MICROSIP_APP_PATH}    ${MICROSIP_APP_NAME}
    Input Phone Number In Text Box         ${MICROSIP_APP_NAME}    ${PHONE_NUMBER}
    Press Call Button                      ${MICROSIP_APP_NAME}


Receive Call Only
    [Documentation]    Receive call Only MicroSIP Functions
    [Arguments]    ${MICROSIP_APP_PATH}    ${MICROSIP_APP_NAME}
    Incoming Call Button    ${MICROSIP_APP_NAME}
    Answer Call Button    ${MICROSIP_APP_NAME}
    Sleep    5s

Initial Call Answer End In During Login In SB
    [Arguments]    ${MICROSIP_APP_NAME}
    ${timeout} =       Set Variable    15
    ${interval} =      Set Variable    5
    ${call_appeared} =    Set Variable    False
    Log    Checking for incoming call...
    FOR    ${i}    IN RANGE    0    ${timeout}    ${interval}
        ${call_appeared}=    Run Keyword And Return Status    Micro.Element Should Exist    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
        Log    Call appearance check: ${call_appeared}
        IF    ${call_appeared}
            Log    Incoming call detected. Proceeding to answer.
            Handle Incoming Call    ${MICROSIP_APP_NAME}
            BREAK
        END
        Sleep    ${interval}
    END
    IF    not ${call_appeared}
        Log    No incoming call detected. Proceeding with execution.
    END



Handle Incoming Call
    [Arguments]    ${MICROSIP_APP_NAME}
    Log    Trying to answer and end the call...
    Wait Until Keyword Succeeds    5x    5s    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
    Sleep    2s
    Run Keyword And Ignore Error    Micro.Click    /Window[@Name='${MICROSIP_APP_NAME}']/Button[@Name='End']
    Log    Call handled successfully.


Decline Call Button
      [Arguments]    ${MICROSIP_APP_NAME}
      [Documentation]    Decline call button
      BuiltIn.Sleep    5s
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Decline']
      Micro.Click     /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Decline']


Transfer of call from MicroSip
      [Arguments]    ${MICROSIP_APP_NAME}       ${MICROSIP_APPs_NAME}       ${PHONE_NUMBER}
      [Documentation]    Decline call button
      BuiltIn.Sleep    5s
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Transfer']
      Micro.Click     /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Transfer']
      Wait Until Element Exist    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Window[@Name='Call Transfer']
      Micro.Is Element Enabled    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Window[@Name='Call Transfer']/ComboBox/Edit
      Set Text To Textbox          /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Window[@Name='Call Transfer']/ComboBox/Edit    ${PHONE_NUMBER}
      Micro.Click         /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Window[@Name='Call Transfer']/Button[@Name='OK']
      BuiltIn.Sleep    5s
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APPs_NAME}']/Window[@Name='Incoming Call']
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APPs_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
      Micro.Click    /Window[@Name='${MICROSIP_APPs_NAME}']/Window[@Name='Incoming Call']/Button[@Name='Answer']
      Micro.Element Should Be Enabled    /Window[@Name='${MICROSIP_APPs_NAME}']/Button[@Name='End']
      Micro.Click    /Window[@Name='${MICROSIP_APPs_NAME}']/Button[@Name='End']


Dial From One MicroSIP To Another And Answer Call From MicroSIP1
    [Arguments]    ${MICROSIP_APP_NAME}     ${MICROSIP_APPs_PATH}       ${MICROSIP_APPs_NAME}       ${PHONE_NUMBER_TO_Q}
    Launch MicroSIP    ${MICROSIP_APPs_PATH}    ${MICROSIP_APPs_NAME}
    Input Phone Number In Text Box          ${MICROSIP_APPs_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APPs_NAME}
    Sleep    1s
    Incoming Call Button                    ${MICROSIP_APP_NAME}
    Check Incoming Call Prefix              ${MICROSIP_APP_NAME}
    Answer Call Button                      ${MICROSIP_APP_NAME}
    Sleep    1s

Dial From One MicroSIP To Another And Answer Call From MicroSIP1 for Hent
    [Arguments]    ${MICROSIP_APP_NAME}     ${MICROSIP_APPs_PATH}       ${MICROSIP_APPs_NAME}       ${PHONE_NUMBER_TO_Q}
    Launch MicroSIP    ${MICROSIP_APPs_PATH}    ${MICROSIP_APPs_NAME}
    Input Phone Number In Text Box          ${MICROSIP_APPs_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APPs_NAME}
    Identify Row To Hent Call
    Click Hent Button
    Sleep    1s
    Incoming Call Button                    ${MICROSIP_APP_NAME}
    Answer Call Button                      ${MICROSIP_APP_NAME}
    Sleep    1s
    
Dial From One MicroSIP To Another And Answer Call From MicroSIP1 for Hent With Avvis
    [Arguments]    ${MICROSIP_APP_NAME}     ${MICROSIP_APPs_PATH}       ${MICROSIP_APPs_NAME}    ${PHONE_NUMBER_TO_Q}
    Launch MicroSIP    ${MICROSIP_APPs_PATH}    ${MICROSIP_APPs_NAME}
    Input Phone Number In Text Box          ${MICROSIP_APPs_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APPs_NAME}
    Identify Row To Hent Call
    Avvis Anrop
    Identify Row To Hent Call
    Click Hent Button
    Incoming Call Button                    ${MICROSIP_APP_NAME}
    Answer Call Button                      ${MICROSIP_APP_NAME}


Dial From Two MicroSIPs To Another And Answer Call From MicroSIP1
    [Arguments]    ${MICROSIP_APP_NAME}     ${MICROSIP_APPs_PATH}       ${MICROSIP_APPs_NAME}    ${MICROSIP_APP3_PATH}    ${MICROSIP_APP3_NAME}    ${PHONE_NUMBER_TO_Q}
    Launch MicroSIP    ${MICROSIP_APPs_PATH}    ${MICROSIP_APPs_NAME}
    Launch MicroSIP    ${MICROSIP_APP3_PATH}    ${MICROSIP_APP3_NAME}
    Input Phone Number In Text Box          ${MICROSIP_APPs_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APPs_NAME}
    Sleep    20s
    Input Phone Number In Text Box          ${MICROSIP_APP3_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APP3_NAME}
    Sleep    2s
    Identify Row To Hent Call
    Sleep    1s
    Avvis Anrop
    Sleep    1s
    Identify Row To Hent Call
    Sleep    1s
    Click Hent Button
    Incoming Call Button                    ${MICROSIP_APP_NAME}
    Check Incoming Call Prefix              ${MICROSIP_APP_NAME}
    Answer Call Button                      ${MICROSIP_APP_NAME}

Dial From Two MicroSIPs To Another And Answer Call From MicroSIP1 For Negative
    [Arguments]    ${MICROSIP_APP_NAME}     ${MICROSIP_APPs_PATH}       ${MICROSIP_APPs_NAME}    ${MICROSIP_APP3_PATH}    ${MICROSIP_APP3_NAME}    ${PHONE_NUMBER_TO_Q}
    Launch MicroSIP    ${MICROSIP_APPs_PATH}    ${MICROSIP_APPs_NAME}
    Launch MicroSIP    ${MICROSIP_APP3_PATH}    ${MICROSIP_APP3_NAME}
    Input Phone Number In Text Box          ${MICROSIP_APPs_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APPs_NAME}
    Sleep    15s
    Input Phone Number In Text Box          ${MICROSIP_APP3_NAME}   ${PHONE_NUMBER_TO_Q}
    Press Call Button                       ${MICROSIP_APP3_NAME}
    Identify Row To Hent Call
    Sleep    10s
    Call Active And Highlight Contact Card
    Sleep    1s
    Identify Row To Hent Call
    Click Hent For Snack label Fikk Ikke Hentet Inn
    Sleep    5s


Check Incoming Call Prefix
    [Arguments]    ${MICROSIP_APP_NAME}
    [Documentation]    Verifies the prefix from the incoming call window in MicroSIP
    Log    Incoming call Kø Prefix check start
    Sleep    1s
    Wait Until Element Exist    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']
    Sleep    5s
    Focus    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']
    ${text} =    Get Text From Textbox    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Document[@ClassName='Edit']
    Log    Text read from incoming call window: ${text}
     #Correct way to check if a string contains a substring in Robot Framework
    Run Keyword If    '${text}'.startswith('+47100220')
    ...    Log    Queue validation successful
    ...    ELSE
    ...    Log    The value is not from Queue! number is a Normal number: ${text}
    Micro.Double Click    /Window[@Name='${MICROSIP_APP_NAME}']/Window[@Name='Incoming Call']/Document[@ClassName='Edit']
    Log    Incoming call Kø Prefix check End