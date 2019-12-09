<?php
include 'conn.php';
$sql=$conn->query("SELECT p.PUB_TITULO, p.PUB_DETALLE, p.PUB_FECHA, p.negocios_ID_NEGOCIO, g.GAL_TIPO 
FROM publicacion p, galeria g WHERE PUB_ESTATUS='1' AND negocios_ID_NEGOCIO ='22' and GAL_TIPO='Publicacion' ");
$result=array();
//FALTA AGREGAR CAMPO ESTATUS, CHECAR RELACION GALERIA-PUBLICACION
//CAMBIAR CAMPOS, SUSTITUIR ENG POR ING
while($fetchdata=$sql->fetch_assoc()) {
    $result[]=$fetchdata;

     }

/*
while($fetchdata=$sql->fetch_assoc()){
	$result[]=$fetchdata;
}*/
echo json_encode($result);
?> 