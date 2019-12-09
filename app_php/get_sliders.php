<?php

include 'conn.php';
static $SQL_SELECT_ALL="SELECT n.NEG_NOMBRE, n.NEG_RAZONSOCIAL, g.GAL_FOTO FROM negocios n, exposicion e, galeria g WHERE n.ID_NEGOCIO = e.ID_NEGOCIO = g.ID_NEGOCIO";

class Spacecrafts
{
    
    public function select()
    {
        $conn=$this->connect();
        if($conn != null)
        {
            $result=$conn->query(Constants::$SQL_SELECT_ALL);
            if($result->num_rows>0)
            {
                $spacecrafts=array();
                while($row=$result->fetch_array())
                {
                    array_push($spacecrafts, array("id"=>$row['id'],"name"=>$row['name'],
                    "propellant"=>$row['propellant'],"destination"=>$row['destination'],
                    "image_url"=>$row['image_url'],"technology_exists"=>$row['technology_exists']));
                }
                print(json_encode(array_reverse($spacecrafts)));
            }else
            {
                print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
            }
            $conn->close();

        }else{
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }
}
$spacecrafts=new Spacecrafts();
$spacecrafts->select();

//end