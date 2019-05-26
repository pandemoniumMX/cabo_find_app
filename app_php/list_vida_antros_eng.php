<?php
include 'conn.php';
$sql=$conn->query("SELECT n.NEG_NOMBRE, c.CAT_NOMBRE_ING,s.SUB_NOMBRE_ING, g.GAL_FOTO  
FROM negocios n, subcategoria s, galeria g ,exposicion e, categorias c
WHERE n.ID_SUBCATEGORIA = s.ID_SUBCATEGORIA
and n.ID_SUBCATEGORIA=s.ID_SUBCATEGORIA 
and g.ID_NEGOCIO=n.ID_NEGOCIO 
and n.exposicion_ID_EXPOSICION=e.ID_EXPOSICION 
and n.exposicion_ID_EXPOSICION='3' 
and g.GAL_TIPO='Logo'
and s.SUB_NOMBRE='Antros'
and c.CAT_NOMBRE='Vida nocturna'

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