*** Settings ***

Library           ScreenCapLibrary

*** Keywords ***
Record Screen 
    Start Video Recording    alias=None    name=DemoRecording    fps=None    size_percentage=1    embed=True    embed_width=300px    monitor=1

Stop Record
    Stop Video Recording    alias=None
