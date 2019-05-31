<?php
include 'conn.php';
$sql=$conn->query("SELECT p.PUB_TITULO_ING, p.PUB_DETALLE_ING, p.PUB_FECHA,n.NEG_NOMBRE,s.SUB_NOMBRE,n.exposicion_ID_EXPOSICION 
FROM negocios n, publicacion p, subcategoria s, galeria g ,exposicion e 
WHERE n.ID_NEGOCIO = p.negocios_ID_NEGOCIO 
and n.ID_SUBCATEGORIA=s.ID_SUBCATEGORIA 
and g.ID_GALERIA=p.galeria_ID_GALERIA 
and n.exposicion_ID_EXPOSICION=e.ID_EXPOSICION 
and n.exposicion_ID_EXPOSICION='2'

");
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