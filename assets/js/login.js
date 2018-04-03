function SendAccount() {

    var uid = $("#inputEmail").val();
    var pwd = $("#inputPassword").val();

    $.ajax({
        type: "post",
        url: "logincheck.php",
        data: {
            request: "login",
            username: uid,
            password: pwd
        },
        dataType: "TEXT",
        success: function(r) {
            if(r.trim() == "y") {
                window.location.href = "person_homepage.html";
            } else {
                alert("用户名或密码错误");
            }
        },
        error:function(){
            alert("向服务器发送请求失败");
        }
    });
    return false;
}
$(function() {
    $("#form").submit(SendAccount);
});