*** Settings ***
Documentation     A test suite with a single test for Jumia | Vendor Center
...               Created by hats' Robotcorder
Resource     ../../../Resources/common.robot
Library                ScreenCapLibrary  screenshot_module=PyGTK

*** Variables ***
${BROWSER}    firefox
${SLEEP}    3

*** Keywords ***
Get Browser Console Log Entries
    ${selenium}=    Get Library Instance    SeleniumLibrary
    ${webdriver}=    Set Variable     ${selenium._drivers.active_drivers}[0]
    ${log entries}=    Evaluate    $webdriver.get_log('browser')
    RETURN    ${log entries}

Record Screen 
    Start Video Recording    alias=None    name=DemoRecording    fps=None    size_percentage=1    embed=True    embed_width=300px    monitor=1

Stop Record
    Stop Video Recording    alias=None

*** Test Cases ***
Jumia | Vendor Center test
    #[Tags]    robot:skip
    Record Screen
    Open Browser    https://vendorcenter-staging.jumia.com/sign-in    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    //button[@data-action="keycloak-login"]
    Click Element    //button[@data-action="keycloak-login"]
    Input Text    //input[@name="username"]    test49@test.com
    Input Text    //input[@name="password"]    P@ssw0rd
    Click Element    //button[@name="login"]
    Handle Alert	
    Wait Until Element Is Visible    //div[contains(text(), "Welcome to Jumia! Let’s take your shop live!")]
    Sleep    20s
    Close Browser
    Stop Record
