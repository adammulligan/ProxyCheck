// Generated by CoffeeScript 1.6.3
(function() {
  $('#ip_address').text(localStorage.getItem('proxy_ips'));

  $('#ip_address').keyup(function() {
    localStorage.setItem('proxy_ips', $('#ip_address').val().split(","));
    return console.log(localStorage.proxy_ips);
  });

}).call(this);
