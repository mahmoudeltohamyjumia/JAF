*** Settings ***
Library    Browser
Library    JSONLibrary
# Library    SeleniumLibrary

*** Variables ***
${URL}    https://vendorcenter-staging.jumia.com/

*** Test Cases ***
Intercept Login Request
    New Browser    firefox    headless=True    args=['disable-web-security','dom.disable_beforeunload']
    New Page    ${URL}
    Click    xpath=(//button[@data-action="keycloak-login"])[1]
    Type Text    xpath=//input[@name="username"]    test49@test.com
    Type Text    xpath=//input[@name="password"]    P@ssw0rd
    Keyboard Key    press    Enter
    Keyboard Key    press    Enter

    #Click    xpath=//button[@name="login"]
    # Sleep    1s
    # ${button}     Get Element By Role    button    name=Continue

    # Click    ${button}
    ${data}    Wait For response    **/api/v2/users/login/keycloak    timeout=30s
    Log    ${data}
    ${values}    Get Value From Json	${data}    $.body.token	
    Log    ${values}[0]
    #Close Browser
