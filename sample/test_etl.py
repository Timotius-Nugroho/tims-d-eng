# File: test_etl.py

# Import fungsi yang ingin diuji dari file DAG Anda
from simple_etl import extract, transform, load

# Buat kelas tiruan (mock) untuk mensimulasikan Task Instance dan XCom
class MockTaskInstance:
    def __init__(self):
        self.xcom_data = {}

    def xcom_pull(self, task_ids):
        """Simulasi mengambil data dari XCom."""
        return self.xcom_data.get(task_ids)

    def xcom_push(self, key, value):
        """Simulasi menyimpan data ke XCom."""
        # Dalam pengujian lokal, kita bisa langsung set datanya
        self.xcom_data[key] = value

print("--- Memulai Pengujian Lokal ---")

# Inisialisasi mock Task Instance
mock_ti = MockTaskInstance()

# --- Uji fungsi extract ---
print("\n1. Menjalankan extract()...")
extracted_data = extract()
# Simulasikan task 'extract' menyimpan hasilnya ke XCom
mock_ti.xcom_push('extract', extracted_data)
print("   Hasil Extract:", extracted_data)


# --- Uji fungsi transform ---
print("\n2. Menjalankan transform()...")
# Panggil fungsi transform dengan memberikan context tiruan
transformed_data = transform(ti=mock_ti)
# Simulasikan task 'transform' menyimpan hasilnya ke XCom
mock_ti.xcom_push('transform', transformed_data)
print("   Hasil Transform (usia > 25):", transformed_data)


# --- Uji fungsi load ---
print("\n3. Menjalankan load()...")
# Panggil fungsi load
load(ti=mock_ti)
print("   Pengujian selesai. Periksa file /tmp/output.csv")