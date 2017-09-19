xcodebuild -scheme GXProjectTWO -destination 'platform=iOS Simulator,name=iPhone 6s' test | grep -E '^Test\s+(Case)\s+[^\n\r]*'

