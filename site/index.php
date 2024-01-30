<?php

if(!count($_GET)) {
  $_POST['auth'] = [
    'server' => '10.10.20.11',
    'username' => 'giornaliera_parcheggi',
    'password' => 'Password&1',
    'driver' => 'server',
    'db'    => 'giornaliera_parcheggi'
  ];
}

include "adminer-4.8.1.php";