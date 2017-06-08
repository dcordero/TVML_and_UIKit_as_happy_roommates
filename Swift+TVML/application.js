/*
 application.js
 TVML
 
 Copyright (c) 2017 David Cordero. All rights reserved.
 */

App.onLaunch = function(options) {
    var alert = createAlert("Hello...!", "Welcome to tvOS");
    navigationDocument.pushDocument(alert);
}

/**
 * This convenience funnction returns an alert template, which can be used to present errors to the user.
 */
var createAlert = function(title, description) {
    
    var alertString = `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
        <alertTemplate>
            <title>${title}</title>
            <description>${description}</description>
            <button><text>Show my name</text></button>
        </alertTemplate>
    </document>`
    
    var parser = new DOMParser();
    
    var alertDoc = parser.parseFromString(alertString, "application/xml");
    
    return alertDoc
}
