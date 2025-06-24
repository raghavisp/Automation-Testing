*** Settings ***
Library    AppiumLibrary


#Suite Setup    Launch Phone 517
#Suite Teardown

Resource    ../resource/phone_appium.resource
Resource    ../resource/PhoneSCRCPY.resource

*** Test Cases ***
Message Validation On Phone
    [Documentation]    go to sms app
    Open SMS App 517
    SMS Validation



Email validation from Mobile
    Sleep    5s
    Open Email App
    Search box Click and Input Name
    Select the latest Email
    Email Body Validation


Make Call Scenario
    Launch Phone 785
    Unlock mobile
    Make Call 785
    Receive Call
    Sleep    5s
    End Call
    Go Back in

Make Call Scenario with decline
    Launch Phone 785
    Make Call 785
    Decline call
    Sleep    5s


ReLaunch all5 calls test
    #Run Process    C:/RaghaviSP/scrcpy-win64-v3.2/scrcpy    -s    RF8MB02MB1E
    Launch All 5 PCY
    #Receive call


Decline incoming Call
    Decline call