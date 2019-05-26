<?php
include 'conn.php';
$sql=$conn->query("SELECT n.NEG_NOMBRE, n.NEG_MAP, c.CAT_NOMBRE,s.SUB_NOMBRE, g.GAL_FOTO  
FROM negocios n, subcategoria s, galeria g ,exposicion e, categorias c
WHERE n.ID_SUBCATEGORIA = s.ID_SUBCATEGORIA
and n.ID_SUBCATEGORIA=s.ID_SUBCATEGORIA 
and g.ID_NEGOCIO=n.ID_NEGOCIO 
and n.exposicion_ID_EXPOSICION=e.ID_EXPOSICION 
and n.exposicion_ID_EXPOSICION='3' 
and g.GAL_TIPO='Logo'
and s.SUB_NOMBRE='Antros'
and c.CAT_NOMBRE='Vida nocturna' 
union
SELECT n.NEG_NOMBRE, n.NEG_MAP, c.CAT_NOMBRE,s.SUB_NOMBRE, g.GAL_FOTO
FROM negocios n, subcategoria s, galeria g ,exposicion e, categorias c
WHERE n.ID_SUBCATEGORIA = s.ID_SUBCATEGORIA
and n.ID_SUBCATEGORIA=s.ID_SUBCATEGORIA 
and g.ID_NEGOCIO=n.ID_NEGOCIO 
and n.exposicion_ID_EXPOSICION=e.ID_EXPOSICION 
and n.exposicion_ID_EXPOSICION='2' 
and g.GAL_TIPO='Logo'
and s.SUB_NOMBRE='Antros'
and c.CAT_NOMBRE='Vida nocturna'
union
SELECT n.NEG_NOMBRE, n.NEG_MAP, c.CAT_NOMBRE,s.SUB_NOMBRE, g.GAL_FOTO
FROM negocios n, subcategoria s, galeria g ,exposicion e, categorias c
WHERE n.ID_SUBCATEGORIA = s.ID_SUBCATEGORIA
and n.ID_SUBCATEGORIA=s.ID_SUBCATEGORIA 
and g.ID_NEGOCIO=n.ID_NEGOCIO 
and n.exposicion_ID_EXPOSICION=e.ID_EXPOSICION 
and n.exposicion_ID_EXPOSICION='1' 
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