<?php

session_start();

$year = $_POST["year"];
$month = $_POST["month"];

$user_id = $_SESSION["id"];
$db = new PDO("mysql:host=localhost;dbname=u_lesson","root","");
$db->query("set character set 'gdk'");
$sql = "select lesson_id from student_lesson where user_id = '$user_id'";
$rs=$db->prepare($sql);//准备查询语句
$rs->execute();

$rows = $rs -> fetchAll(PDO::FETCH_ASSOC);
$rows_count =  count($rows);

$ddl_arr = array();

$sql = "select * from ddls where lesson_id=:lesson and year='$year' and month='$month'";
$rs=$db->prepare($sql);
for($i = 0; $i < $rows_count ; $i++){
    $lesson = $rows[$i]["lesson_id"];
    $rs->execute(array(':lesson'=>'$lesson'));
    $rows = $rs -> fetchAll(PDO::FETCH_ASSOC);
    array_merge($ddl_arr,$rows);
}

$ddl_json = json_encode($ddl_arr);
echo $ddl_json;
?>