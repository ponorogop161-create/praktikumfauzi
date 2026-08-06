<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

// --- KONFIGURASI DATABASE MYSQL ---
$db_host = 'localhost';
$db_name = 'data_api'; // Sesuaikan nama DB di phpMyAdmin
$db_user = 'root';     // Default XAMPP
$db_pass = '';         // Default XAMPP

try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8mb4", $db_user, $db_pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => "Koneksi Database Gagal: " . $e->getMessage()]);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];

// ==========================================
// 1. MEMBACA DATA DARI DATABASE MYSQL (GET)
// ==========================================
if ($method === 'GET') {
    try {
        $sql = "SELECT 
                    u.id, u.name, u.username, u.email, u.phone, u.website,
                    a.street, a.suite, a.city, a.zipcode,
                    c.name AS company_name, c.catch_phrase, c.bs
                FROM users u
                LEFT JOIN addresses a ON u.id = a.user_id
                LEFT JOIN companies c ON u.id = c.user_id
                ORDER BY u.id DESC";
                
        $stmt = $pdo->query($sql);
        $rows = $stmt->fetchAll();

        $users = array_map(function($row) {
            return [
                "id" => (int)$row['id'],
                "name" => $row['name'],
                "username" => $row['username'],
                "email" => $row['email'],
                "phone" => $row['phone'],
                "website" => $row['website'],
                "address" => [
                    "street" => $row['street'],
                    "suite" => $row['suite'],
                    "city" => $row['city'],
                    "zipcode" => $row['zipcode']
                ],
                "company" => [
                    "name" => $row['company_name'],
                    "catchPhrase" => $row['catch_phrase'],
                    "bs" => $row['bs']
                ]
            ];
        }, $rows);

        echo json_encode($users);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
    exit;
}

// ==========================================
// 2. SIMPAN DATA BARU KE MYSQL (POST)
// ==========================================
else if ($method === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    if (!$input || empty($input['name']) || empty($input['username']) || empty($input['email'])) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "Nama, Username, dan Email wajib diisi!"]);
        exit;
    }

    try {
        $pdo->beginTransaction();

        // 1. Insert ke tabel users
        $stmtUser = $pdo->prepare("INSERT INTO users (name, username, email, phone, website) VALUES (:name, :username, :email, :phone, :website)");
        $stmtUser->execute([
            ':name' => $input['name'],
            ':username' => $input['username'],
            ':email' => $input['email'],
            ':phone' => $input['phone'] ?? null,
            ':website' => 'example.com'
        ]);

        $newUserId = $pdo->lastInsertId();

        // 2. Insert ke tabel addresses
        $stmtAddr = $pdo->prepare("INSERT INTO addresses (user_id, street, suite, city, zipcode) VALUES (:user_id, :street, :suite, :city, :zipcode)");
        $stmtAddr->execute([
            ':user_id' => $newUserId,
            ':street' => '-',
            ':suite' => '',
            ':city' => $input['city'] ?? '-',
            ':zipcode' => '-'
        ]);

        // 3. Insert ke tabel companies
        $stmtComp = $pdo->prepare("INSERT INTO companies (user_id, name, catch_phrase, bs) VALUES (:user_id, :name, :catch_phrase, :bs)");
        $stmtComp->execute([
            ':user_id' => $newUserId,
            ':name' => $input['company'] ?? '-',
            ':catch_phrase' => 'Member Baru',
            ':bs' => 'new user'
        ]);

        $pdo->commit();

        // Kirim respon balik ke JS
        $newUser = [
            "id" => (int)$newUserId,
            "name" => $input['name'],
            "username" => $input['username'],
            "email" => $input['email'],
            "phone" => $input['phone'] ?? '-',
            "website" => 'example.com',
            "address" => [
                "street" => '-',
                "suite" => '',
                "city" => $input['city'] ?? '-',
                "zipcode" => '-'
            ],
            "company" => [
                "name" => $input['company'] ?? '-',
                "catchPhrase" => 'Member Baru'
            ]
        ];

        echo json_encode(["status" => "success", "data" => $newUser]);

    } catch (PDOException $e) {
        $pdo->rollBack();
        http_response_code(500);
        if ($e->getCode() == 23000) {
            echo json_encode(["status" => "error", "message" => "Username/Email sudah pernah terdaftar."]);
        } else {
            echo json_encode(["status" => "error", "message" => "Gagal simpan DB: " . $e->getMessage()]);
        }
    }
    exit;
}