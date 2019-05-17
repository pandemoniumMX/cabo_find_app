<?php
include 'conn.php';
$sql=$conn->query("SELECT n.NEG_NOMBRE, n.NEG_RAZONSOCIAL, g.GAL_FOTO FROM negocios n, exposicion e, galeria g WHERE n.ID_NEGOCIO = e.ID_NEGOCIO = g.ID_NEGOCIO");
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