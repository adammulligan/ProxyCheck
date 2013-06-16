$.get 'http://jsonip.com', (data) ->
  $('#address').text(data.ip)

  ips = localStorage.getItem('proxy_ips')

  state = "off"
  state = "on" if ips? && localStorage.proxy_ips.indexOf(data.ip) != -1

  $('#thumbs_image').
    attr("src", "assets/thumbs_#{state}.png").
    attr("alt", "Proxy is #{state}!")

  chrome.browserAction.setIcon({path: "assets/icon_#{state}.png"})

$('#running').prop 'checked', localStorage.getItem('show_alerts') == 'true'
$('#running').change ->
  localStorage.setItem(
    'show_alerts',
    $('#running').is(':checked')
  )
