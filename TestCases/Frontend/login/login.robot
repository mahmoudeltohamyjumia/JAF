*** Settings ***
Documentation     A test suite with a single test for Jumia | Vendor Center
...               Created by hats' Robotcorder
Resource     ../../../Resources/common.robot

*** Variables ***
${BROWSER}    ff
${SLEEP}    3



*** Test Cases ***
Jumia | Vendor Center test
    #[Tags]    robot:skip
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



