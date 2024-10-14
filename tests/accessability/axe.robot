*** Settings ***
Library    SeleniumLibrary
Resource         ../../../../Resources/common.robot
*** Test Cases ***
Google Accessibility Test
    [Tags]    robot:skip
    Open Browser    https://vendorcenter-staging.jumia.com    headlessfirefox
    &{results}=    Run Accessibility Tests    vcs.json
    Log   Violations Count: ${results.violations}
    Get Json Accessibility Result
    Log Readable Accessibility Result
    [Teardown]    Close All Browsers