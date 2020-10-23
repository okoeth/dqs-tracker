#!/bin/bash

/Users/koetho/Library/Java/JavaVirtualMachines/corretto-11.0.8/Contents/Home/bin/java -Dfile.encoding=UTF-8 -Dapple.awt.UIElement=true -jar "/Users/koetho/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-3.2.3-2020-10-13-c14e609bd/bin/monkeybrains.jar" -o /Users/koetho/Workspace/eclipse/dqs-tracker/bin/dqs-tracker.prg -w -t -y /Users/koetho/.ssh/garmin_developer_key.der -f /Users/koetho/Workspace/eclipse/dqs-tracker/monkey.jungle

"/Users/koetho/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-3.2.3-2020-10-13-c14e609bd/bin/monkeydo" \-t bin/dqs-tracker.prg

