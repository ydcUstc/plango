<?php

// Pear Mail 扩展
require_once('Mail.php');
require_once('Mail/mime.php');
require_once('Net/SMTP.php');

$smtpinfo = array();
$smtpinfo["host"] = "smtp.qq.com";//SMTP服务器
$smtpinfo["port"] = "587"; //SMTP服务器端口
$smtpinfo["username"] = "1639351514@qq.com"; //发件人邮箱
//$smtpinfo["password"] = "kpyjmlhafxoejdai";//发件人邮箱密码[授权码]
$smtpinfo["password"] = "gvapynjdkqdwehid";//发件人邮箱密码[授权码]
$smtpinfo["timeout"] = 10;//网络超时时间，秒
$smtpinfo["auth"] = true;//登录验证
//$smtpinfo["debug"] = true;//调试模式

// 收件人列表
$mailAddr = array('ydc@mail.ustc.edu.cn');

// 发件人显示信息
$from = "Plango <plango.amp@foxmail.com>";

// 收件人显示信息
$to = implode(',',$mailAddr);

// 邮件标题
$subject = "这是一封测试邮件";

// 邮件正文
$content = "<h3>随便写点什么1</h3>";

// 邮件正文类型，格式和编码
$contentType = "text/html; charset=utf-8";

//换行符号 Linux: \n  Windows: \r\n
$crlf = "\r\n";
$mime = new Mail_mime($crlf);
$mime->setHTMLBody($content);

$param['text_charset'] = 'utf-8';
$param['html_charset'] = 'utf-8';
$param['head_charset'] = 'utf-8';
$body = $mime->get($param);

$headers = array();
$headers["From"] = $from;
$headers["To"] = $to;
$headers["Subject"] = $subject;
$headers["Content-Type"] = $contentType;
$headers = $mime->headers($headers);

$smtp = Mail::factory("smtp", $smtpinfo);


$mail = $smtp->send($mailAddr, $headers, $body);
$smtp->disconnect();

if (PEAR::isError($mail)) {
    //发送失败
    echo 'Email sending failed: ' . $mail->getMessage()."\n";
}
else{
    //发送成功
    echo "success!\n";
}