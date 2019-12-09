<?php
include 'conn.php';
$sql=$conn->query("SELECT p.PUB_TITULO,p.PUB_DETALLE,p.PUB_FECHA,p.PUB_VIDEO, n.ID_NEGOCIO 
FROM publicacion p, negocios n, galeria g 
where p.negocios_ID_NEGOCIO = n.ID_NEGOCIO 
and p.galeria_ID_GALERIA = g.ID_GALERIA 
and g.GAL_TIPO='Publicacion' 
and p.negocios_ID_NEGOCIO='22' 
ORDER by p.PUB_FECHA DESC");
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