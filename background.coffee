whitelist = ["http://jsonip.com/"]

isLocalUrl = (url) ->
  protocol = url.split("://")[0]
  return protocol == 'file' || protocol == 'chrome-extension'

chrome.webRequest.onBeforeRequest.addListener(
  (info) ->
    $.ajaxSetup(async: false)

    ip = ""
    $.get('http://jsonip.com').done(
      (data) => ip = data.ip
    )

    ips = localStorage.getItem('proxy_ips')

    if ips? && ips.indexOf(ip) != -1
      return chrome.browserAction.setIcon({path: "assets/icon_on.png"})
    else
      chrome.browserAction.setIcon({path: "assets/icon_off.png"})

      urlWhitelisted = isLocalUrl(info.url) || $.inArray(info.url, whitelist) == 0
      showAlerts = localStorage.getItem('show_alerts') == 'true'

      if !showAlerts || urlWhitelisted
        return { cancel: false }

    return { redirectUrl: chrome.extension.getURL('blocked.html') }
  ,
  {
    urls: ["<all_urls>"]
  },
  ["blocking"]
)
