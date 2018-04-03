<?php
/**
 * Created by PhpStorm.
 * User: YDC
 * Date: 2018/1/25
 * Time: 22:08
 */

$uploadDir = 'C:/xampp/htdocs/upload/';
if(!file_exists($uploadDir)) {
    @mkdir($uploadDir, 0777, true);
}
$uploadFile = $uploadDir . basename($_FILES['file']['name']);
if(move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile)) {
    echo "OK";
} else {
    echo "NO";
}