function ajax_get_json(url, cb) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
                if(xhr.readyState == 4) {
                        if(cb != null) {
                                cb(JSON.parse(xhr.responseText));
                        }
                }
        }
        xhr.send();
}

function ajax_post_json(url, obj, cb) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function() {
                if(xhr.readyState == 4) {
                        if(cb != null) {
                                cb(JSON.parse(xhr.responseText));
                        }
                }
        }
        xhr.send(JSON.stringify(obj));
}