var Android = new Object;
Android.setCaptchaResponse = function(challenge, response) {
    var string = challenge + "|" + response;
    navigator.qt.postMessage(string);
}
