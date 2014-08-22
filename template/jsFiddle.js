function getAssets() {
    // make sync request to get the assts location
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/read/index.html",false);
    xmlhttp.send();
    var htmlContents = xmlhttp.responseText;

    xmlhttp.open("GET","/read/main.js",false);
    xmlhttp.send();
    var jsContents = xmlhttp.responseText;

    console.log(jsContents);
    xmlhttp.open("GET","/read/main.css",false);
    xmlhttp.send();
    var cssContents = xmlhttp.responseText;
    return {
        'html': htmlContents,
        'css': cssContents,
        'js': jsContents
    };
}

function makePost() {
    var form = document.getElementsByTagName('form')[0];
    form.style.visibility = 'hidden';
    form.action = "http://jsfiddle.net/api/post/library/pure/";
    var postData = getAssets();

    for(key in postData){
        input = document.createElement('input');
        input.name = key;
        input.value = postData[key];
        form.appendChild(input);
    }
    form.submit();
}
