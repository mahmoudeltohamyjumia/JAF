*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../../Resources/common.robot
*** Variables ***

*** Test Cases ***
01. List Total Pending Orders in Last Seven Days - 
    [Tags]  valid    vcs    smoke    Positive
    Log    ok