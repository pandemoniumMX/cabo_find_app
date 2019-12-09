<?php
include 'conn.php';
$sql=$conn->query("SELECT n.NEG_NOMBRE, n.NEG_ETIQUETAS, g.GAL_FOTO, g.GAL_TIPO FROM negocios n, galeria g WHERE n.ID_NEGOCIO = g.ID_NEGOCIO and g.GAL_TIPO='Galeria' LIMIT 1");
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