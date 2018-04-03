<?php
/**
 * Created by PhpStorm.
 * User: YDC
 * Date: 2018/2/27
 * Time: 17:38
 */

class find_files_in_folder
{/**
 *获取某个目录下所有文件
 *@param $path文件路径
 *@param $child 是否包含对应的目录
 */
    public function __construct( ) {
    }
    public  function getFiles($path,$child=false){
        $files=array();
        if(!$child){
            if(is_dir($path)){
                $dp = dir($path);
            }else{
                return null;
            }
            while ($file = $dp ->read()){
                if($file !="." && $file !=".." && is_file($path.$file)){
                    $files[] = $file;
                }
            }
            $dp->close();
        }else{
            $this->scanfiles($files,$path);
        }
        return $files;
    }
    /**
     *@param $files 结果
     *@param $path 路径
     *@param $childDir 子目录名称
     */
    public function scanfiles(&$files,$path,$childDir=false){
        $dp = dir($path);
        while ($file = $dp ->read()){
            if($file !="." && $file !=".."){
                if(is_file($path.$file)){//当前为文件
                    $files[]= $file;
                }else{//当前为目录
                    $this->scanfiles($files[$file],$path.$file.DIRECTORY_SEPARATOR,$file);
                }
            }
        }
        $dp->close();
    }

}