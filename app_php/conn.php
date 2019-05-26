<?php

$servername = "162.241.2.107";
$username = "cabofind";
$password = "6241543710";
$dbname = "cabofind_cabofind";
// Crear connection
$conn = @mysqli_connect($servername, $username, $password,$dbname) or die("Connect failed: %s\n". $conn -> error);
 
if (!$conn) {
   die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";

/*
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "cabofind_cabofind";

//$dbname = md5("electronicax");

// Crear connection
$conn = @mysqli_connect($servername, $username, $password, $dbname);
return $conn;
*/
?>