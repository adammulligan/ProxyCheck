whitelist = ["http://jsonip.com"]

isLocalUrl = (url) ->
  protocol = url.split("://")[0]
  return protocol == 'file' || protocol == 'chrome-extension'

chrome.webRequest.onBeforeRequest.addListener(
  (info) ->
    $.get 'http://jsonip.com', (data) =>
      ip = data.ip

      ips = localStorage.getItem('proxy_ips')

      if ips? && ips.indexOf(window.ip) != -1
        chrome.browserAction.setIcon({path: "assets/icon_on.png"})
      else
        chrome.browserAction.setIcon({path: "assets/icon_off.png"})

        if localStorage.getItem('show_alerts') == 'true'
          if isLocalUrl(info.url) || $.inArray(info.url, whitelist) == 0
            return { cancel: false }
          else
            return { redirectUrl: chrome.extension.getURL('blocked.html') }
  ,
  {
    urls: ["<all_urls>"]
  },
  ["blocking"]
)
