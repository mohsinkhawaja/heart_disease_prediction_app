// Local Storage with SQLite
import 'package:frontend/core/models/doctor.dart';
import 'package:frontend/core/models/patient.dart';
import 'package:frontend/core/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'heart_disease.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        user_type TEXT NOT NULL,
        is_verified INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Patients table
    await db.execute('''
      CREATE TABLE patients(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        full_name TEXT NOT NULL,
        age INTEGER NOT NULL,
        gender TEXT NOT NULL,
        medical_history TEXT,
        profile_photo TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // Doctors table
    await db.execute('''
      CREATE TABLE doctors(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        full_name TEXT NOT NULL,
        phone TEXT NOT NULL,
        dob TEXT NOT NULL,
        gender TEXT NOT NULL,
        license_number TEXT UNIQUE NOT NULL,
        license_authority TEXT NOT NULL,
        license_expiry TEXT NOT NULL,
        specialization TEXT NOT NULL,
        experience INTEGER NOT NULL,
        hospital TEXT NOT NULL,
        work_address TEXT NOT NULL,
        license_file TEXT,
        id_file TEXT,
        profile_photo TEXT,
        signature_file TEXT,
        stamp_file TEXT,
        is_approved INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // OTP table for verification
    await db.execute('''
      CREATE TABLE otp_verification(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        otp TEXT NOT NULL,
        expires_at TEXT NOT NULL,
        is_used INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // User operations
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Patient operations
  Future<int> insertPatient(Patient patient) async {
    final db = await database;
    return await db.insert('patients', patient.toMap());
  }

  Future<Patient?> getPatientByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'patients',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return Patient.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updatePatient(Patient patient) async {
    final db = await database;
    return await db.update(
      'patients',
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  // Doctor operations
  Future<int> insertDoctor(Doctor doctor) async {
    final db = await database;
    return await db.insert('doctors', doctor.toMap());
  }

  Future<Doctor?> getDoctorByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'doctors',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return Doctor.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateDoctor(Doctor doctor) async {
    final db = await database;
    return await db.update(
      'doctors',
      doctor.toMap(),
      where: 'id = ?',
      whereArgs: [doctor.id],
    );
  }

  // OTP operations
  Future<int> insertOTP(String email, String otp, DateTime expiresAt) async {
    final db = await database;
    return await db.insert('otp_verification', {
      'email': email,
      'otp': otp,
      'expires_at': expiresAt.toIso8601String(),
    });
  }

  Future<bool> verifyOTP(String email, String otp) async {
    final db = await database;
    final maps = await db.query(
      'otp_verification',
      where: 'email = ? AND otp = ? AND is_used = 0 AND expires_at > ?',
      whereArgs: [email, otp, DateTime.now().toIso8601String()],
    );
    
    if (maps.isNotEmpty) {
      await db.update(
        'otp_verification',
        {'is_used': 1},
        where: 'id = ?',
        whereArgs: [maps.first['id']],
      );
      return true;
    }
    return false;
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}