/*
 application.js
 TVML
 
 Copyright (c) 2017 David Cordero. All rights reserved.
 */

App.onLaunch = function(options) {
    var alert = createAlert();
    navigationDocument.pushDocument(alert);
}

var createAlert = function() {
    var alertString = `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
        <alertTemplate>
            <title>Loading...</title>
            <description>Welcome to TVML</description>
            <button onselect="buttonselect(this);">
                <text>Show my name in a Swifty way</text>
            </button>
        </alertTemplate>
    </document>`
    
    var parser = new DOMParser();
    var alertDoc = parser.parseFromString(alertString, "application/xml");
    
    return alertDoc
}

function updateName(name) {
    getActiveDocument().getElementsByTagName("title").item(0).textContent = name;
}

function buttonselect(target) {
    showMyNameButtonWasPressed(getActiveDocument().getElementsByTagName("title").item(0).textContent);
}
