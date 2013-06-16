$('#ip_address').text(localStorage.getItem('proxy_ips'))

$('#ip_address').keyup ->
  localStorage.setItem('proxy_ips', $('#ip_address').val().split(","))
  console.log(localStorage.proxy_ips)
