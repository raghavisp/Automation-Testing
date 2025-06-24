*** Settings ***
Library    AppiumLibrary
Library    Process
Library    Collections
Library    String
Library    SeleniumLibrary


Resource    config.resource

#Suite Setup    Setup Connection
#Suite Teardown    Close All Applications

*** Variables ***
${REMOTE_URL1}         http://localhost:4723/wd/hub1
${PLATFORM_NAME1}      Android
${AUTOMATION_NAME1}    UiAutomator2
${DEVICE_NAME1}        RF8MB02MB1E
${APP_PACKAGE1}        com.sec.android.app.launcher
${APP_ACTIVITY1}       com.sec.android.app.launcher.activities.LauncherActivity
${MESSAGE_XPATH1}      //android.widget.TextView[contains(@text, "Messages")]

${REMOTE_URL2}         http://localhost:4725/wd/hub2
${PLATFORM_NAME2}      Android
${AUTOMATION_NAME2}    UiAutomator2
${DEVICE_NAME2}        RFCR10EJB9N
${APP_PACKAGE2}        com.sec.android.app.launcher
${APP_ACTIVITY2}       com.sec.android.app.launcher.activities.LauncherActivity


${REMOTE_URL3}         http://localhost:4727/wd/hub3
${PLATFORM_NAME3}      Android
${AUTOMATION_NAME3}    UiAutomator2
${DEVICE_NAME3}        RFCT61D1Z1T
${APP_PACKAGE3}        com.sec.android.app.launcher
${APP_ACTIVITY3}       com.sec.android.app.launcher.activities.LauncherActivity


${REMOTE_URL4}         http://localhost:4729/wd/hub4
${PLATFORM_NAME4}      Android
${AUTOMATION_NAME4}    UiAutomator2
${DEVICE_NAME4}        RFCT90VNDMZ
${APP_PACKAGE4}        com.sec.android.app.launcher
${APP_ACTIVITY4}       com.sec.android.app.launcher.activities.LauncherActivity


${REMOTE_URL5}         http://localhost:4731/wd/hub5
${PLATFORM_NAME5}      Android
${AUTOMATION_NAME5}    UiAutomator2
${DEVICE_NAME5}        R5CR513H8JX
${APP_PACKAGE5}        com.sec.android.app.launcher
${APP_ACTIVITY5}       com.sec.android.app.launcher.activities.LauncherActivity


*** Keywords ***
#*************************************************************************************************************************************************
#PHONE 1# 46180517
#*************************************************************************************************************************************************
Launch Phone 517
    [Documentation]    Login for mobile app
    # Start scrcpy to mirror the device (non-blocking)
    Start Process    scrcpy -s ${DEVICE_GS10} --max-size 620 --window-x 3080 --window-y 100 --stay-awake --show-touches  shell=True    stdout=NONE    stderr=NONE

    # Open the mobile app with Appium
    Open Application    ${REMOTE_URL1}
    ...    platformName=${PLATFORM_NAME1}
    ...    automationName=${AUTOMATION_NAME1}
    ...    udid=${DEVICE_NAME1}
    ...    appPackage=${APP_PACKAGE1}
    ...    appActivity=${APP_ACTIVITY1}
#    ...    systemPort=8201
    ...    noReset=true

Open SMS App 517
    ${contexts}=    Get Contexts
    Log Many    ${contexts}
    Switch To Context    NATIVE_APP
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Messages")]    timeout=10s
    Log    Messages app opened successfully
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@text="Messages"]
    Sleep    2s
    # Wait for message list to load
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.TextView[contains(@text, "4746180220")]    timeout=10s
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[contains(@text, "+4746180220")]
    Sleep    2s

SMS Validation
    Sleep    1s
    # ✅ Get all native messages in the conversation
    ${elements}=    AppiumLibrary.Get Webelements    xpath=//android.widget.LinearLayout[@content-desc]

    ${msg_count}=    Get Length    ${elements}
    Run Keyword If    ${msg_count} == 0    Fail    No messages found in the conversation.

    ${last_msg}=    Get From List    ${elements}    -1

    ${text}=    AppiumLibrary.Get Element Attribute    ${last_msg}    content-desc
    ${body}=    Replace String    ${text}    \n    ${SPACE}
    ${body}=    Strip String    ${body}
    ${body}=    Replace String    ${body}    \u00A0    ${SPACE}
    ${body}=    Evaluate    ' '.join("""${body}""".split())
    ${body}=    Strip String    ${body}

    ${Ring til}=       Evaluate    ' '.join("""${Ring til}""".replace(u'\u00A0', ' ').split())
    Log    Latest SMS: ${body}    console=True
    Log    *****************************************
    IF    '${body}' == '${MBN_App_text}'
    Log    result for MBN App: ${body}
    ELSE IF    '${body}' == '${Ring_SB}'
        Log    result for Ring SB Option: ${body}
    ELSE IF    '${body}' == '${Ring til}'
        Log    result for Ring till SB Option: ${body}
    ELSE IF    '${body}' == '${Ingen mal valgt}'
        Log    result for Custom Message: ${body}
    ELSE
        Log    none of the above
    END
    Log    **********************************************


Unlock mobile
    Switch To Context    NATIVE_APP
    Press Keycode    26

Go Back in
    Switch To Context    NATIVE_APP
    Press Keycode    4


Open Email App
    Sleep    2s
    # Open the mobile app with Appium
    Open Application    ${REMOTE_URL1}
    ...    platformName=${PLATFORM_NAME1}
    ...    automationName=${AUTOMATION_NAME1}
    ...    udid=${DEVICE_NAME1}
    ...    appPackage=${APP_PACKAGE1}
    ...    appActivity=${APP_ACTIVITY1}
#    ...    systemPort=8201
    ...    noReset=true
    Switch To Context    NATIVE_APP
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Gmail"]    timeout=10s
    Log    Email app opened successfully
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@text="Gmail"]
    Sleep    3s

Search box Click and Input Name
    Sleep    1s
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.EditText[@resource-id="com.google.android.gm:id/open_search"]    10s
    AppiumLibrary.Click Element    xpath=//android.widget.EditText[@resource-id="com.google.android.gm:id/open_search"]
    Sleep    1s
    Input Text Into Current Element    ${SENDER_NAME}
    Sleep    5s

Select the latest Email
    # Wait for email previews to load
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@resource-id="com.google.android.gm:id/viewified_conversation_item_view"]
    # Get all email previews
    ${emails}=    AppiumLibrary.Get Webelements    xpath=//android.view.ViewGroup[@resource-id="com.google.android.gm:id/viewified_conversation_item_view"]
    ${first_email}=    Get From List    ${emails}    0

    # Get the text content of the first email
    ${text}=    AppiumLibrary.Get Element Attribute    ${first_email}    text
    ${cleaned}=    Replace String    ${text}    \n    ${SPACE}
    ${cleaned}=    Strip String    ${cleaned}
    Log    \nFirst email text: ${cleaned}    console=True

    # Verify that it's from "sentralbord"
    IF    '${sendername}' in '${cleaned}'
       Log    Found sender in email preview.
    ELSE
       Fail    Sender not found in latest email.
    END

    # Click to open the email
    AppiumLibrary.Click Element    ${first_email}

    Log    Opened the latest email from Sentralbord

Email Body Validation
    Sleep    2s
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.TextView[starts-with(@resource-id, 'm#msg-f:') and contains(@resource-id, '-content')]    timeout=10s
    ${elements}=    AppiumLibrary.Get WebElement    xpath=//android.widget.TextView[starts-with(@resource-id, 'm#msg-f:') and contains(@resource-id, '-content')]
    ${email_body}=    AppiumLibrary.Get Element Attribute    ${elements}    text
    ${body}=    Replace String    ${email_body}    \n    ${SPACE}
    ${body}=    Strip String    ${body}
    ${body}=    Replace String    ${body}    \u00A0    ${SPACE}
    ${body}=    Evaluate    ' '.join("""${body}""".split())
    ${body}=    Strip String    ${body}
    ${Ring til}=       Evaluate    ' '.join("""${Ring til}""".replace(u'\u00A0', ' ').split())

    Log    Latest email: ${body}    console=True
    Log    *****************************************

        IF    '${body}' == '${MBN_App_text}'
    Log    result for MBN App: ${body}
    ELSE IF    '${body}' == '${Ring_SB}'
        Log    result for Ring SB Option: ${body}
    ELSE IF    '${body}' == '${Ring_til}'
        Log    result for Ring SB Option: ${body}
    ELSE IF    '${body}' == '${Ingen mal valgt}'
        Log    result for Custom Message: ${body}
    ELSE
        Log    none of the above
    END
    Log    *****************************************

   
Make Call
    Sleep    2s
    # Open the mobile app with Appium
    Open Application    ${REMOTE_URL1}
    ...    platformName=${PLATFORM_NAME1}
    ...    automationName=${AUTOMATION_NAME1}
    ...    udid=${DEVICE_NAME1}
    ...    appPackage=${APP_PACKAGE1}
    ...    appActivity=${APP_ACTIVITY1}
#    ...    systemPort=8201
    ...    noReset=true
    Switch To Context    NATIVE_APP
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.TextView[@content-desc="Phone"]    10s
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@content-desc="Phone"]
    Input Text Into Current Element    46180785
    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout[@content-desc="Call button"]
    Sleep    5s

End Call
    Sleep    3s
    Switch To Context    NATIVE_APP
    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.ImageButton[@content-desc="End call"]     10s
    AppiumLibrary.Click Element    xpath=//android.widget.ImageButton[@content-desc="End call"]
    Sleep    3s


Receive Call
    Log    the loop started
    ${id1}=    Open Application    ${REMOTE_URL1}
    ...    platformName=${PLATFORM_NAME1}
    ...    automationName=${AUTOMATION_NAME1}
    ...    udid=${DEVICE_GS10}
    ...    appPackage=com.samsung.android.incallui
    ...    appActivity=com.android.incallui.call.InCallActivity
    ...    noReset=true
    Switch Application    ${id1}
    Log    the receive call starts
#    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.ImageView[@content-desc="Answer, Drag right with two fingers to answer call."]
    Long Press Keycode    5
    Sleep    3s

Decline call
    Log    the End Call Loop started
    ${id1}=    Open Application    ${REMOTE_URL1}
    ...    platformName=${PLATFORM_NAME1}
    ...    automationName=${AUTOMATION_NAME1}
    ...    udid=${DEVICE_GS10}
    ...    appPackage=com.samsung.android.incallui
    ...    appActivity=com.android.incallui.call.InCallActivity
    ...    noReset=true
    Switch Application    ${id1}
    Log    the Decline call starts
    AppiumLibrary.Press Keycode    6
    Sleep    3s





    
#*************************************************************************************************************************************************
#PHONE 2# 46180785
#*************************************************************************************************************************************************


Launch Phone 785
    [Documentation]    Login for mobile app
    # Start scrcpy to mirror the device (non-blocking)
    Start Process    scrcpy -s ${DEVICE_ID} --max-size 620 --window-x 2775 --window-y 150 --stay-awake    shell=True    stdout=NONE    stderr=NONE
    # Open the mobile app with Appium
    Open Application    ${REMOTE_URL2}
    ...    platformName=${PLATFORM_NAME2}
    ...    automationName=${AUTOMATION_NAME2}
    ...    udid=${DEVICE_ID}
    ...    appPackage=com.sec.android.app.launcher
    ...    appActivity=com.sec.android.app.launcher.activities.LauncherActivity
    ...    noReset=true


Make Call 785
    Sleep    2s
    # Open the mobile app with Appium
    ${id2}=    Open Application    ${REMOTE_URL2}
    ...    platformName=${PLATFORM_NAME2}
    ...    automationName=${AUTOMATION_NAME2}
    ...    udid=${DEVICE_ID}
    ...    appPackage=com.sec.android.app.launcher
    ...    appActivity=com.sec.android.app.launcher.activities.LauncherActivity
    ...    noReset=true
    Switch Application    ${id2}
    Switch To Context    NATIVE_APP
    Press Keycode    3
    Run Keyword And Continue On Failure    AppiumLibrary.Wait Until Page Contains Element    xpath=//android.widget.TextView[@content-desc="Phone"]
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@content-desc="Phone"]
    Run Keyword And Continue On Failure    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@content-desc="Keypad, Selected"]
    AppiumLibrary.Click Element    xpath=//android.widget.LinearLayout[@resource-id="com.samsung.android.dialer:id/dialpad_edit_text_container"]
    Input Text Into Current Element    46180517
    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout[@content-desc="Call"]

   


#*************************************************************************************************************************************************
# PHONE 3# 46180033
#*************************************************************************************************************************************************








Launch All 5 PCY
    #Comment    === Start scrcpy for each device ===
#    Start Process    ${PHONECPY_PATH1}    -s    ${DEVICE_ID}        --max-size 620 --window-x 3080 --window-y 750 --stay-awake --show-touches    shell=True    stdout=NONE    stderr=NONE
#    Sleep    2s

#    Start Process     ${PHONECPY_PATH1}   -s    ${DEVICE_ID}    --max-size 620   --window-x 100    --window-y 100    --stay-awake    --show-touches    --always-on-top    shell=True    stdout=NONE    stderr=NONE
#    Sleep    2s
    Start Process    ${PHONECPY_PATH2}    -s    RF8MB02MB1E
    Sleep    2s
    Start Process    ${PHONECPY_PATH2}    -s    RFCR10EJB9N
    Sleep    2s
    Start Process    ${PHONECPY_PATH2}    -s    RFCT90VNDMZ
    Sleep    2s
    Start Process    ${PHONECPY_PATH2}    -s    R5CR513H8JX
    Sleep    2s
##    Start Process    ${PHONECPY_PATH3}    -s    ${Device_ID_EX_033}    --max-size 620 --window-x 2775 --window-y 750 --stay-awake --show-touches    shell=True    stdout=NONE    stderr=NONE
##    Sleep    2s
#    Start Process    ${PHONECPY_PATH4}    -s    ${DEVICE_483}    --max-size 620 --window-x 3080 --window-y 750 --stay-awake --show-touches    shell=True    stdout=NONE    stderr=NONE
#    Sleep    2s
#    Start Process    ${PHONECPY_PATH5}    -s    ${DEVICE_059}    --max-size 620 --window-x 2470 --window-y 100 --stay-awake --show-touches    shell=True    stdout=NONE    stderr=NONE
#    Sleep    2s
#
    #Comment    === Launch Appium session for each device ===
#    Open Application    ${REMOTE_URL1}
#    ...    platformName=${PLATFORM_NAME1}
#    ...    automationName=${AUTOMATION_NAME1}
#    ...    udid=${DEVICE_ID}
#    ...    appPackage=${APP_PACKAGE1}
#    ...    appActivity=${APP_ACTIVITY1}
#    ...    noReset=true
#
    Open Application    ${REMOTE_URL2}
    ...    platformName=${PLATFORM_NAME2}
    ...    automationName=${AUTOMATION_NAME2}
    ...    udid=${DEVICE_GS10}
    ...    appPackage=${APP_PACKAGE2}
    ...    appActivity=${APP_ACTIVITY2}
    ...    noReset=true

#    Open Application    ${REMOTE_URL3}
#    ...    platformName=${PLATFORM_NAME3}
#    ...    automationName=${AUTOMATION_NAME3}
#    ...    udid=${Device_ID_EX_033}
#    ...    appPackage=${APP_PACKAGE1}
#    ...    appActivity=${APP_ACTIVITY3}
#    ...    noReset=true
#
#    Open Application    ${REMOTE_URL4}
#    ...    platformName=${PLATFORM_NAME4}
#    ...    automationName=${AUTOMATION_NAME4}
#    ...    udid=${DEVICE_483}
#    ...    appPackage=${APP_PACKAGE4}
#    ...    appActivity=${APP_ACTIVITY4}
#    ...    noReset=true
#
#    Open Application    ${REMOTE_URL5}
#    ...    platformName=${PLATFORM_NAME5}
#    ...    automationName=${AUTOMATION_NAME5}
#    ...    udid=${DEVICE_059}
#    ...    appPackage=${APP_PACKAGE5}
#    ...    appActivity=${APP_ACTIVITY5}
#    ...    noReset=true