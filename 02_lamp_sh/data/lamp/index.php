Hello Politechnika:) :D :D ewoifhgkvdsapjfda kfhsdklrsfohewq :T:T:T:T:T:

<br>

<!-- Connect yo MySQL test -->

<?php
$servername = "mysqldb";
$username = "lamp_user";
$password = "89423reufabvjkwsagiuolr";

// Create connection
$conn = new mysqli($servername, $username, $password);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
echo "Connected successfully to MySQL :)";
?> 

<br>
<!-- Connect to MSSQL test -->

<?php
$host ="mssqldb"; 
$username ="sa";
$password ="Pass@word";
$database ="master";

$db = new PDO("sqlsrv:Server=$host;Database=$database", "$username", "$password");
var_dump($db);
?>

<?php
// phpinfo();
?>