
var getEntries = function(payer, onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/entries' + '?payer=' + encodeURIComponent(payer), true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.onreadystatechange = function () {
    var res = null;
    if (xhr.readyState === 4) {
      if (xhr.status === 204 || xhr.status === 205) {
        onSuccess();
      } else if (xhr.status >= 200 && xhr.status < 300) {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onSuccess(res);
      } else {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onError(res);
      }
    }
  };
  xhr.send(null);
};

var postEntry = function(body, onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('POST', '/entry', true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onreadystatechange = function () {
    var res = null;
    if (xhr.readyState === 4) {
      if (xhr.status === 204 || xhr.status === 205) {
        onSuccess();
      } else if (xhr.status >= 200 && xhr.status < 300) {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onSuccess(res);
      } else {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onError(res);
      }
    }
  };
  xhr.send(JSON.stringify(body));
};

var deleteEntryByKey = function(key, onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('DELETE', '/entry/' + encodeURIComponent(key) + '', true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.onreadystatechange = function () {
    var res = null;
    if (xhr.readyState === 4) {
      if (xhr.status === 204 || xhr.status === 205) {
        onSuccess();
      } else if (xhr.status >= 200 && xhr.status < 300) {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onSuccess(res);
      } else {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onError(res);
      }
    }
  };
  xhr.send(null);
};

var putEntryByKey = function(key, body, onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('PUT', '/entry/' + encodeURIComponent(key) + '', true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onreadystatechange = function () {
    var res = null;
    if (xhr.readyState === 4) {
      if (xhr.status === 204 || xhr.status === 205) {
        onSuccess();
      } else if (xhr.status >= 200 && xhr.status < 300) {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onSuccess(res);
      } else {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onError(res);
      }
    }
  };
  xhr.send(JSON.stringify(body));
};

var getEntryByKey = function(key, onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/entry/' + encodeURIComponent(key) + '', true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.onreadystatechange = function () {
    var res = null;
    if (xhr.readyState === 4) {
      if (xhr.status === 204 || xhr.status === 205) {
        onSuccess();
      } else if (xhr.status >= 200 && xhr.status < 300) {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onSuccess(res);
      } else {
        try { res = JSON.parse(xhr.responseText); } catch (e) { onError(e); }
        if (res) onError(res);
      }
    }
  };
  xhr.send(null);
};
