<?php
include 'conn.php';
$sql=$conn->query("SELECT CAR_NOMBRE_ENG FROM `caracteristicas` WHERE CAR_ESTATUS='A' AND negocios_ID_NEGOCIO='22' ");
$result=array();

while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }

/*
while($fetchdata=$sql->fetch_assoc()){
	$result[]=$fetchdata;
}*/
echo json_encode($result);
?> 